package org.openvoipalliance.flutterphonelib

import android.app.Activity
import android.app.Application
import android.os.Handler
import android.os.Looper
import androidx.annotation.NonNull

import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler

import org.koin.android.BuildConfig

import org.openvoipalliance.androidphoneintegration.PIL
import org.openvoipalliance.androidphoneintegration.audio.AudioRoute
import org.openvoipalliance.androidphoneintegration.configuration.ApplicationSetup
import org.openvoipalliance.androidphoneintegration.configuration.Auth
import org.openvoipalliance.androidphoneintegration.configuration.Preferences
import org.openvoipalliance.androidphoneintegration.logging.LogLevel
import org.openvoipalliance.androidphoneintegration.startAndroidPIL

import org.openvoipalliance.flutterphonelib.audio.toMap
import org.openvoipalliance.flutterphonelib.call.toMap
import org.openvoipalliance.flutterphonelib.configuration.authOf
import org.openvoipalliance.flutterphonelib.configuration.preferencesOf
import org.openvoipalliance.flutterphonelib.events.ProxyEventListener
import org.openvoipalliance.flutterphonelib.push.ProxyMiddleware

class PhoneLib : FlutterPlugin, MethodCallHandler {
    internal lateinit var channel: MethodChannel

    private lateinit var pil: PIL

    /**
     * Must be set to use this plugin.
     */
    lateinit var application: Application

    /**
     * The activity to show when the incoming call notification is pressed. Almost always the
     * `MainActivity`. Must be set to use this plugin.
     */
    lateinit var activityClass: Class<out Activity>

    private val eventListener = ProxyEventListener(this)

    override fun onAttachedToEngine(@NonNull flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
        channel = MethodChannel(flutterPluginBinding.binaryMessenger, "flutter_phone_lib")
        channel.setMethodCallHandler(this)

        instance = this
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
            if (BuildConfig.DEBUG && !::pil.isInitialized) {
                error("PhoneLib not initialized. Create an instance using startPhoneLib.")
            }
        }

        when {
            !hasType && method == "startPhoneLib" -> {
                val arguments = call.arguments<List<*>>()
                val preferences = preferencesOf(arguments[0]!! as Map<String, Any>)
                val auth = authOf(arguments[1]!! as Map<String, Any>)
                val hasMiddleware = arguments[2]!! as Boolean
                val userAgent = arguments[3]!! as String

                startPhoneLib(preferences, auth, hasMiddleware, userAgent, result)
            }
            type == "PhoneLib" -> {
                assertPILInitialized()

                when (method) {
                    "call" -> {
                        val number = call.arguments<String>()

                        pil.call(number)

                        result.success(null)
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
                    "hold" -> {
                        pil.actions.hold()
                    }
                    "unhold" -> {
                        pil.actions.unhold()
                    }
                    "toggleHold" -> {
                        pil.actions.toggleHold()
                    }
                    "sendDtmf" -> {
                        pil.actions.sendDtmf(call.arguments())
                    }
                    "beginAttendedTransfer" -> {
                        pil.actions.beginAttendedTransfer(call.arguments())
                    }
                    "completeAttendedTransfer" -> {
                        pil.actions.completeAttendedTransfer()
                    }
                    "answer" -> {
                        pil.actions.answer()
                    }
                    "decline" -> {
                        pil.actions.decline()
                    }
                    "end" -> {
                        pil.actions.end()
                    }
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
                        val route = AudioRoute.valueOf(call.arguments())
                        pil.audio.routeAudio(route)
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

    private fun startPhoneLib(
            preferences: Preferences,
            auth: Auth,
            hasMiddleware: Boolean,
            userAgent: String,
            result: MethodChannel.Result
    ) {
        pil = startAndroidPIL {
            this.preferences = preferences
            this.auth = auth

            ApplicationSetup(
                    application = application,
                    activities = ApplicationSetup.Activities(activityClass, activityClass),
                    automaticallyStartCallActivity = false,
                    middleware = if (hasMiddleware) ProxyMiddleware(this@PhoneLib) else null,
                    logger = ::onLogReceived,
                    userAgent = userAgent
            )
        }

        result.success(null)
    }

    private fun onLogReceived(message: String, level: LogLevel) {
        Handler(Looper.getMainLooper()) {
            channel.invokeMethod("onLogReceived", listOf(message, level.toString()))
            true
        }
    }

    companion object {
        lateinit var instance: PhoneLib
            private set

        private const val tag = "FIL"
    }
}
