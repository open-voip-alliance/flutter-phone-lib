package org.openvoipalliance.flutterphonelib

import android.app.Activity
import android.app.Application
import android.content.Context
import android.os.Build
import android.util.Log
import android.view.WindowManager
import androidx.annotation.NonNull
import com.google.gson.Gson
import io.flutter.BuildConfig

import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.GlobalScope
import kotlinx.coroutines.launch

import org.openvoipalliance.androidphoneintegration.PIL
import org.openvoipalliance.androidphoneintegration.audio.AudioRoute
import org.openvoipalliance.androidphoneintegration.audio.BluetoothAudioRoute
import org.openvoipalliance.androidphoneintegration.configuration.ApplicationSetup
import org.openvoipalliance.androidphoneintegration.configuration.ApplicationSetup.AutomaticallyLaunchCallActivity.*
import org.openvoipalliance.androidphoneintegration.configuration.Auth
import org.openvoipalliance.androidphoneintegration.configuration.Preferences
import org.openvoipalliance.androidphoneintegration.logging.LogLevel
import org.openvoipalliance.androidphoneintegration.logging.LogLevel.*
import org.openvoipalliance.androidphoneintegration.logging.Logger
import org.openvoipalliance.androidphoneintegration.startAndroidPIL

import org.openvoipalliance.flutterphonelib.audio.toMap
import org.openvoipalliance.flutterphonelib.call.toMap
import org.openvoipalliance.flutterphonelib.configuration.authOf
import org.openvoipalliance.flutterphonelib.configuration.preferencesOf
import org.openvoipalliance.flutterphonelib.events.ProxyEventListener
import org.openvoipalliance.flutterphonelib.push.ProxyMiddleware
import java.util.concurrent.ConcurrentLinkedQueue

class PhoneLib : FlutterPlugin, MethodCallHandler {
    internal lateinit var channel: MethodChannel

    private lateinit var context: Context

    private val eventListener = ProxyEventListener(this)

    override fun onAttachedToEngine(@NonNull flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
        channel = MethodChannel(
                flutterPluginBinding.binaryMessenger,
                "org.openvoipalliance.flutterphonelib/foreground"
        )
        channel.setMethodCallHandler(this)

        context = flutterPluginBinding.applicationContext
    }

    override fun onDetachedFromEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {
        channel.setMethodCallHandler(null)
    }

    @Suppress("UNCHECKED_CAST")
    override fun onMethodCall(@NonNull call: MethodCall, @NonNull result: MethodChannel.Result) {
        val hasType = call.method.contains('.')
        val type = if (hasType) call.method.split('.')[0] else null
        val method = if (hasType) call.method.split('.')[1] else call.method

        fun assertPILInitialized() {
            if (BuildConfig.DEBUG && !isPILInitialized) {
                error("PhoneLib not initialized. Create an instance using startPhoneLib.")
            }
        }

        when {
            !hasType && method == "startPhoneLib" -> {
                val arguments = call.arguments<List<*>>()
                val preferences = preferencesOf(arguments[0]!! as Map<String, Any>)
                val auth = authOf(arguments[1]!! as Map<String, Any>)
                val callbackDispatcherHandle = arguments[2].asLong()
                val initializeResourcesHandle = arguments[3].asLong()
                val loggerHandle = arguments[4].asLong()
                val middlewareRespondHandle = arguments[5].asLong()
                val middlewareTokenReceivedHandle = arguments[6].asLong()
                val userAgent = arguments[7]!! as String

                context.sharedPreferences.edit()
                        .putString(Keys.PREFERENCES, Gson().toJson(preferences))
                        .putString(Keys.AUTH, Gson().toJson(auth))
                        .putString(Keys.USER_AGENT, userAgent)
                        .apply()

                context.registerFlutterCallback(Keys.CALLBACK_DISPATCHER, callbackDispatcherHandle)
                context.registerFlutterCallback(
                        Keys.INITIALIZE,
                        initializeResourcesHandle
                )
                context.registerFlutterCallback(Keys.LOGGER, loggerHandle)
                context.registerFlutterCallback(Keys.MIDDLEWARE_RESPOND, middlewareRespondHandle)
                context.registerFlutterCallback(
                        Keys.MIDDLEWARE_TOKEN_RECEIVED,
                        middlewareTokenReceivedHandle
                )

                app!!.startPhoneLib(activityClass!!)

                result.success(null)
            }
            type == "PhoneLib" -> {
                assertPILInitialized()

                when (method) {
                    "call" -> {
                        val number = call.arguments<String>()

                        pil.call(number)

                        result.success(null)
                    }
                    "sessionState" -> {
                        result.success(pil.sessionState.toMap())
                    }
                }
            }
            type == "Calls" -> {
                assertPILInitialized()

                when (method) {
                    "active" -> {
                        result.success(pil.calls.active?.toMap())
                    }
                }
            }
            type == "EventsManager" -> {
                assertPILInitialized()

                when (method) {
                    "listen" -> {
                        pil.events.listen(eventListener)

                        result.success(null)
                    }
                    "stopListening" -> {
                        pil.events.stopListening(eventListener)

                        result.success(null)
                    }
                }
            }
            type == "CallActions" -> {
                assertPILInitialized()

                when (method) {
                    "hold" -> pil.actions.hold()
                    "unhold" -> pil.actions.unhold()
                    "toggleHold" -> pil.actions.toggleHold()
                    "sendDtmf" -> pil.actions.sendDtmf(
                            call.arguments<String>().toCharArray().first(),
                            playToneLocally = true
                    )
                    "beginAttendedTransfer" -> pil.actions.beginAttendedTransfer(call.arguments())
                    "completeAttendedTransfer" -> pil.actions.completeAttendedTransfer()
                    "answer" -> pil.actions.answer()
                    "decline" -> pil.actions.decline()
                    "end" -> pil.actions.end()
                }

                result.success(null)
            }
            type == "AudioManager" -> {
                assertPILInitialized()

                when (method) {
                    "isMicrophoneMuted" -> {
                        result.success(pil.audio.isMicrophoneMuted)
                    }
                    "state" -> {
                        result.success(pil.audio.state.toMap())
                    }
                    "routeAudio" -> {
                        val isStandardAudioRoute = (call.arguments() as? String != null)

                        if (isStandardAudioRoute) {
                            pil.audio.routeAudio(
                                    AudioRoute.valueOf(call.arguments())
                            )
                        } else {
                            val arguments = call.arguments<Map<String, String>>()
                            pil.audio.routeAudio(BluetoothAudioRoute(
                                    arguments["displayName"]!!,
                                    arguments["identifier"]!!,
                            ))
                        }

                        result.success(null)
                    }
                    "mute" -> {
                        pil.audio.mute()
                        result.success(null)
                    }
                    "unmute" -> {
                        pil.audio.unmute()
                        result.success(null)
                    }
                    "toggleMute" -> {
                        pil.audio.toggleMute()
                        result.success(null)
                    }
                }
            }
            else -> result.notImplemented()
        }
    }

    private fun Any?.asLong(): Long {
        if (this is Int) {
            return toLong()
        }

        return this as Long
    }

    companion object {
        internal var app: Application? = null
        internal var activityClass: Class<out Activity>? = null

        // Can't access isInitialized outside of the companion object, so we have to define this
        // getter.
        internal val isPILInitialized: Boolean
            get() = ::pil.isInitialized

        internal lateinit var pil: PIL

        internal const val LOG_TAG = "FlutterPhoneLib"
    }

    internal object Keys {
        const val SHARED_PREFERENCES = "FlutterPhoneLib"
        const val AUTH = "auth"
        const val PREFERENCES = "preferences"
        const val CALLBACK_DISPATCHER = "callbackDispatcher"
        const val INITIALIZE = "initialize"
        const val LOGGER = "onLogReceived"
        const val MIDDLEWARE_RESPOND = "Middleware.respond"
        const val MIDDLEWARE_TOKEN_RECEIVED = "Middleware.tokenReceived"
        const val USER_AGENT = "userAgent"
    }
}

fun Application.startPhoneLib(
        /**
         * The activity to show when the incoming call notification is pressed. Almost always the
         * `MainActivity`.
         */
        activityClass: Class<out Activity>
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
                        activityClass,
                ),
                automaticallyLaunchCallActivity = ONLY_FROM_BACKGROUND,
                middleware = ProxyMiddleware(this@startPhoneLib),
                logger = AggregatedLogger(this@startPhoneLib),
                userAgent = userAgent
        )
    }

    Log.d(PhoneLib.LOG_TAG, "Started!")
}

/**
 * Configure the FlutterActivity to show when on the lockscreen,
 * this should be called at the end of the configureFlutterEngine
 * method when extending FlutterActivity.
 */
fun <A : Activity> A.showOnLockScreen() {
    if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O_MR1) {
        setShowWhenLocked(true)
        setTurnScreenOn(true)
    } else {
        window.addFlags(WindowManager.LayoutParams.FLAG_SHOW_WHEN_LOCKED
                or WindowManager.LayoutParams.FLAG_DISMISS_KEYGUARD
                or WindowManager.LayoutParams.FLAG_KEEP_SCREEN_ON
                or WindowManager.LayoutParams.FLAG_TURN_SCREEN_ON
                or WindowManager.LayoutParams.FLAG_ALLOW_LOCK_WHILE_SCREEN_ON)
    }
}

// Logs are sent out in groups to prevent overworking the thread, which had the result of
// making calls not work.
private class AggregatedLogger(private val context: Context) : Logger {
    private val logs = ConcurrentLinkedQueue<Pair<LogLevel, String>>()

    override fun onLogReceived(message: String, level: LogLevel) {
        logs.add(level to message)
        Log.println(
                when (level) {
                    DEBUG -> Log.DEBUG
                    INFO -> Log.INFO
                    WARNING -> Log.WARN
                    ERROR -> Log.ERROR
                },
                PhoneLib.LOG_TAG,
                message
        )

        if (logs.size == 200) {
            GlobalScope.launch(Dispatchers.Main) {
                context.invokeMethodThroughCallback(
                        PhoneLib.Keys.LOGGER,
                        logs.map { listOf(it.first.toString(), it.second) }
                )
            }
            logs.clear()
        }
    }

}

internal val Context.sharedPreferences
    get() = getSharedPreferences(PhoneLib.Keys.SHARED_PREFERENCES, Context.MODE_PRIVATE)