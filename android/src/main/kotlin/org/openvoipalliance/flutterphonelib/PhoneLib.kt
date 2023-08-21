package org.openvoipalliance.flutterphonelib

import android.app.Activity
import android.app.Application
import android.app.PendingIntent
import android.content.Context
import android.content.Intent
import android.content.Intent.FLAG_ACTIVITY_NEW_TASK
import android.os.Bundle
import android.util.Log
import androidx.annotation.NonNull
import com.google.firebase.messaging.RemoteMessage
import com.google.gson.Gson
import io.flutter.BuildConfig
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import org.openvoipalliance.androidphoneintegration.PIL
import org.openvoipalliance.androidphoneintegration.audio.AudioRoute
import org.openvoipalliance.androidphoneintegration.audio.BluetoothAudioRoute
import org.openvoipalliance.androidphoneintegration.call.Call
import org.openvoipalliance.androidphoneintegration.configuration.ApplicationSetup
import org.openvoipalliance.androidphoneintegration.configuration.ApplicationSetup.AutomaticallyLaunchCallActivity.*
import org.openvoipalliance.androidphoneintegration.configuration.Auth
import org.openvoipalliance.androidphoneintegration.configuration.Preferences
import org.openvoipalliance.androidphoneintegration.events.Event
import org.openvoipalliance.androidphoneintegration.events.PILEventListener
import org.openvoipalliance.androidphoneintegration.logging.LogLevel.*
import org.openvoipalliance.androidphoneintegration.push.Middleware
import org.openvoipalliance.androidphoneintegration.push.UnavailableReason
import org.openvoipalliance.androidphoneintegration.startAndroidPIL
import org.openvoipalliance.flutterphonelib.audio.toMap
import org.openvoipalliance.flutterphonelib.call.toMap
import org.openvoipalliance.flutterphonelib.configuration.authOf
import org.openvoipalliance.flutterphonelib.configuration.preferencesOf
import org.openvoipalliance.flutterphonelib.events.ProxyEventListener

typealias OnLogReceivedCallback = (message: String, level: PhoneLibLogLevel) -> Unit
typealias OnCallEndedCallback = (call: NativeCall) -> Unit

class PhoneLib : FlutterPlugin, MethodCallHandler {
    private lateinit var context: Context

    private val eventListener = ProxyEventListener()

    override fun onAttachedToEngine(@NonNull flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
        // For some reason onAttachedEngine is called twice, so this check is needed.
        if (!isChannelInitialized) {
            channel = MethodChannel(
                flutterPluginBinding.binaryMessenger,
                "org.openvoipalliance.flutterphonelib/foreground"
            )
        }

        channel?.setMethodCallHandler(this)
        context = flutterPluginBinding.applicationContext
    }

    override fun onDetachedFromEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {
        channel?.setMethodCallHandler(null)
        channel = null
    }

    @Suppress("UNCHECKED_CAST")
    override fun onMethodCall(@NonNull call: MethodCall, @NonNull result: MethodChannel.Result) =
        try {
            val hasType = call.method.contains('.')
            val type = if (hasType) call.method.split('.')[0] else null
            val method = if (hasType) call.method.split('.')[1] else call.method

            fun assertPILInitialized() {
                if (BuildConfig.DEBUG && !isPILInitialized) {
                    error("PhoneLib not initialized. Create an instance using startPhoneLib.")
                }
            }

            when {
                !hasType && method == "initializePhoneLib" -> result.withSuccess {
                    val arguments = call.arguments<List<*>>()!!
                    val preferences = preferencesOf(arguments[0]!! as Map<String, Any>)
                    val auth = authOf(arguments[1]!! as Map<String, Any>)
                    val userAgent = arguments[2]!! as String

                    persist(auth, preferences, userAgent)

                    app!!.startPhoneLib(
                        activityClass!!,
                        incomingCallActivityClass,
                        nativeMiddleware,
                        onCallEnded,
                        onLogReceived,
                    )
                }
                type == "PhoneLib" -> {
                    assertPILInitialized()

                    when (method) {
                        "start" -> result.withSuccess {
                            val arguments = call.arguments<List<*>>()!!

                            pil.preferences = preferencesOf(arguments[0]!! as Map<String, Any>)
                            pil.auth = authOf(arguments[1]!! as Map<String, Any>)
                            persist(auth = pil.auth, preferences = pil.preferences)
                            pil.start(
                                forceInitialize = false,
                                forceReregister = true,
                            )
                        }
                        "stop" -> result.withSuccess {
                            context.sharedPreferences.edit().clear().apply()
                            pil.stop()
                        }
                        "updatePreferences" -> result.withSuccess {
                            val arguments = call.arguments<List<*>>()!!
                            pil.preferences = preferencesOf(arguments[0]!! as Map<String, Any>)
                        }
                        "call" -> result.withSuccess {
                            val number = call.arguments<String>()!!
                            pil.call(number)
                        }
                        "sessionState" -> result.success(pil.sessionState.toMap())
                        "performEchoCancellationCalibration" -> result.withSuccess {
                            pil.performEchoCancellationCalibration()
                        }
                        else -> result.notImplemented()
                    }
                }
                type == "Calls" -> {
                    assertPILInitialized()

                    when (method) {
                        "active" -> result.success(pil.calls.active?.toMap())
                        else -> result.notImplemented()
                    }
                }
                type == "EventsManager" -> {
                    assertPILInitialized()

                    when (method) {
                        "listen" -> result.withSuccess {
                            pil.events.listen(eventListener)
                        }
                        "stopListening" -> result.withSuccess {
                            pil.events.stopListening(eventListener)
                        }
                        else -> result.notImplemented()
                    }
                }
                type == "CallActions" -> {
                    assertPILInitialized()

                    when (method) {
                        "hold" -> result.withSuccess { pil.actions.hold() }
                        "unhold" -> result.withSuccess { pil.actions.unhold() }
                        "toggleHold" -> result.withSuccess { pil.actions.toggleHold() }
                        "sendDtmf" -> result.withSuccess {
                            pil.actions.sendDtmf(
                                call.arguments<String>()!!.toCharArray().first(),
                                playToneLocally = false
                            )
                        }
                        "beginAttendedTransfer" -> result.withSuccess {
                            pil.actions.beginAttendedTransfer(call.arguments()!!)
                        }
                        "completeAttendedTransfer" -> result.withSuccess { pil.actions.completeAttendedTransfer() }
                        "answer" -> result.withSuccess { pil.actions.answer() }
                        "decline" -> result.withSuccess { pil.actions.decline() }
                        "end" -> result.withSuccess { pil.actions.end() }
                        else -> result.notImplemented()
                    }
                }
                type == "AudioManager" -> {
                    assertPILInitialized()

                    when (method) {
                        "isMicrophoneMuted" -> result.success(pil.audio.isMicrophoneMuted)
                        "state" -> result.success(pil.audio.state.toMap())
                        "routeAudio" -> result.withSuccess {
                            val isStandardAudioRoute = (call.arguments() as? String != null)

                            if (isStandardAudioRoute) {
                                pil.audio.routeAudio(
                                    AudioRoute.valueOf(call.arguments()!!)
                                )
                            } else {
                                val arguments = call.arguments<Map<String, String>>()!!
                                pil.audio.routeAudio(
                                    BluetoothAudioRoute(
                                        arguments["displayName"]!!,
                                        arguments["identifier"]!!,
                                    )
                                )
                            }
                        }
                        "mute" -> result.withSuccess { pil.audio.mute() }
                        "unmute" -> result.withSuccess { pil.audio.unmute() }
                        "toggleMute" -> result.withSuccess { pil.audio.toggleMute() }
                        else -> result.notImplemented()
                    }
                }
                else -> result.notImplemented()
            }
        } catch (t: Throwable) {
            result.error(t.javaClass.simpleName, t.message, t.stackTraceToString())
        }

    /**
     * Persists the data in shared preferences so that we can boot the PIL natively, without
     * having to receive the details via Flutter.
     */
    private fun persist(
        auth: Auth? = null,
        preferences: Preferences? = null,
        userAgent: String? = null
    ) = context.sharedPreferences.edit().apply {
        auth?.let { putString(Keys.AUTH, Gson().toJson(it)) }
        preferences?.let { putString(Keys.PREFERENCES, Gson().toJson(it)) }
        userAgent?.let { putString(Keys.USER_AGENT, it) }
        apply()
    }

    /**
     * Assumes that the [block] runs successfully.
     */
    private fun MethodChannel.Result.withSuccess(block: () -> Unit) {
        block()
        success(null)
    }

    private fun Any?.asLong(): Long {
        if (this is Int) {
            return toLong()
        }

        return this as Long
    }

    companion object {
        internal var channel: MethodChannel? = null

        internal var app: Application? = null
        internal var activityClass: Class<out Activity>? = null
        internal var incomingCallActivityClass: Class<out Activity>? = null
        internal var onLogReceived: OnLogReceivedCallback? = null
        internal var nativeMiddleware: NativeMiddleware? = null
        internal var onCallEnded: OnCallEndedCallback? = null
        internal var callListener: PILEventListener? = null

        // Can't access isInitialized outside of the companion object, so we have to define this
        // getter.
        internal val isPILInitialized: Boolean
            get() = ::pil.isInitialized

        internal val isChannelInitialized: Boolean
            get() = channel != null

        internal lateinit var pil: PIL

        fun notifyMissedCallNotificationPressed() =
            channel?.invokeMethod("onMissedCallNotificationPressed", null)

        internal const val LOG_TAG = "FlutterPhoneLib"

        const val PRESSED_MISSED_CALL_NOTIFICATION_EXTRA = "PRESSED_MISSED_CALL_NOTIFICATION"
    }

    internal object Keys {
        const val SHARED_PREFERENCES = "FlutterPhoneLib"
        const val AUTH = "auth"
        const val PREFERENCES = "preferences"
        const val CALLBACK_DISPATCHER = "callbackDispatcher"
        const val INITIALIZE = "initialize"
        const val MIDDLEWARE_RESPOND = "Middleware.respond"
        const val MIDDLEWARE_TOKEN_RECEIVED = "Middleware.tokenReceived"
        const val MIDDLEWARE_INSPECT = "Middleware.inspect"
        const val USER_AGENT = "userAgent"
    }
}

fun Activity.startCall(number: String) {
    if (PhoneLib.isPILInitialized) {
        PhoneLib.pil.call(number)
    }
}

fun Application.startPhoneLib(
    /**
     * The activity to show when the incoming call notification is pressed. Almost always the
     * `MainActivity`.
     */
    activityClass: Class<out Activity>,
    incomingCallActivityClass: Class<out Activity>? = null,
    nativeMiddleware: NativeMiddleware? = null,
    onCallEnded: OnCallEndedCallback? = null,
    onLogReceived: OnLogReceivedCallback? = null,
) {
    if (PhoneLib.isPILInitialized) {
        Log.d(PhoneLib.LOG_TAG, "FlutterPhoneLib is already initialized")
        return
    }

    if (PhoneLib.app == null) {
        PhoneLib.app = this
    }

    if (PhoneLib.activityClass == null) {
        PhoneLib.activityClass = activityClass
    }

    if (PhoneLib.incomingCallActivityClass == null) {
        PhoneLib.incomingCallActivityClass = incomingCallActivityClass
    }

    if (PhoneLib.onLogReceived == null) {
        PhoneLib.onLogReceived = onLogReceived
    }

    if (PhoneLib.nativeMiddleware == null) {
        PhoneLib.nativeMiddleware = nativeMiddleware
    }

    if (PhoneLib.onCallEnded == null) {
        PhoneLib.onCallEnded = onCallEnded
    }

    val prefs = sharedPreferences
    val preferences = Gson().fromJson(
        prefs.getString(PhoneLib.Keys.PREFERENCES, null),
        Preferences::class.java
    )
    val auth = Gson().fromJson(
        prefs.getString(PhoneLib.Keys.AUTH, null),
        Auth::class.java
    )

    val userAgent = prefs.getString(PhoneLib.Keys.USER_AGENT, null)

    if (preferences == null || auth == null || userAgent == null) {
        Log.d(PhoneLib.LOG_TAG, "Not starting yet, arguments are uninitialized")
        return
    }

    Log.d(PhoneLib.LOG_TAG, "Starting..")

    PhoneLib.pil = startAndroidPIL {
        this.preferences = preferences
        this.auth = auth

        ApplicationSetup(
            application = this@startPhoneLib,
            activities = ApplicationSetup.Activities(
                activityClass,
                incomingCall = incomingCallActivityClass ?: activityClass
            ),
            middleware = nativeMiddleware?.toMiddleware(),
            logger = { message, level ->
                onLogReceived?.invoke(
                    message, when (level) {
                        DEBUG -> PhoneLibLogLevel.DEBUG
                        INFO -> PhoneLibLogLevel.INFO
                        WARNING -> PhoneLibLogLevel.WARNING
                        ERROR -> PhoneLibLogLevel.ERROR
                    }
                )
            },
            onMissedCallNotificationPressed = PendingIntent.getActivity(
                this@startPhoneLib,
                0,
                Intent(this@startPhoneLib, activityClass).apply {
                    flags = FLAG_ACTIVITY_NEW_TASK
                    putExtra(PhoneLib.PRESSED_MISSED_CALL_NOTIFICATION_EXTRA, true)
                },
                PendingIntent.FLAG_IMMUTABLE
            ),
            userAgent = userAgent
        )
    }

    PhoneLib.callListener = object : PILEventListener {
        override fun onEvent(event: Event) {
            when (event) {
                is Event.CallSessionEvent.CallEnded -> onCallEnded
                    ?.invoke(event.state.activeCall.toNativeCall())
                else -> {}
            }
        }
    }.also {
        PhoneLib.pil.events.listen(it)
    }

    Log.d(PhoneLib.LOG_TAG, "Started!")
}

internal val Context.sharedPreferences
    get() = getSharedPreferences(PhoneLib.Keys.SHARED_PREFERENCES, Context.MODE_PRIVATE)

enum class PhoneLibLogLevel {
    DEBUG, INFO, WARNING, ERROR
}

/**
 * An interface to allow a native middleware to be provided rather than via Dart.
 */
interface NativeMiddleware {
    fun respond(
        remoteMessage: RemoteMessage,
        available: Boolean,
        reason: NativeMiddlewareUnavailableReason?,
    )

    fun tokenReceived(token: String)

    /**
     * Inspect the contents of the push notification to determine whether the
     * contents is a push message.
     *
     * @return If TRUE Is returned, processing of the push message will continue as if it
     * is a call. If FALSE is returned, nothing further will be done with this notification.
     */
    fun inspect(remoteMessage: RemoteMessage): Boolean = true
}

fun NativeMiddleware.toMiddleware(): Middleware {
    val nativeMiddleware = this

    return object : Middleware {
        override fun respond(
            remoteMessage: RemoteMessage,
            available: Boolean,
            reason: UnavailableReason?,
        ) = nativeMiddleware.respond(remoteMessage, available, reason.toNative())

        override fun tokenReceived(token: String) = nativeMiddleware.tokenReceived(token)

        override fun inspect(remoteMessage: RemoteMessage) =
            nativeMiddleware.inspect(remoteMessage)
    }
}

fun UnavailableReason?.toNative() = when (this) {
    UnavailableReason.IN_CALL -> NativeMiddlewareUnavailableReason.IN_CALL
    UnavailableReason.REJECTED_BY_ANDROID_TELECOM_FRAMEWORK -> NativeMiddlewareUnavailableReason.REJECTED_BY_ANDROID_TELECOM_FRAMEWORK
    UnavailableReason.UNABLE_TO_REGISTER -> NativeMiddlewareUnavailableReason.UNABLE_TO_REGISTER
    else -> null
}

enum class NativeMiddlewareUnavailableReason {
    IN_CALL,
    REJECTED_BY_ANDROID_TELECOM_FRAMEWORK,
    UNABLE_TO_REGISTER,
}

data class NativeCall(
    val mos: String,
    val reason: String,
    val duration: String,
    val direction: String,
)

fun Call?.toNativeCall(): NativeCall = when {
    this != null -> NativeCall(
        mos.toString(),
        reason,
        duration.toString(),
        direction.name.lowercase()
    )
    else -> NativeCall("", "", "", "")
}