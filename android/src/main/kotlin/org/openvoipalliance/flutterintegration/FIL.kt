package org.openvoipalliance.flutterintegration

import android.app.Activity
import android.app.Application
import android.os.Handler
import android.os.Looper
import android.util.Log
import androidx.annotation.NonNull

import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result

import org.koin.android.BuildConfig

import org.openvoipalliance.androidplatformintegration.PIL
import org.openvoipalliance.androidplatformintegration.configuration.ApplicationSetup
import org.openvoipalliance.androidplatformintegration.configuration.Auth
import org.openvoipalliance.androidplatformintegration.configuration.Preferences
import org.openvoipalliance.androidplatformintegration.events.Event
import org.openvoipalliance.androidplatformintegration.events.PILEventListener
import org.openvoipalliance.androidplatformintegration.logging.LogLevel
import org.openvoipalliance.androidplatformintegration.startAndroidPIL
import org.openvoipalliance.flutterintegration.call.toMap
import org.openvoipalliance.flutterintegration.configuration.authOf
import org.openvoipalliance.flutterintegration.configuration.preferencesOf

class FIL : FlutterPlugin, MethodCallHandler, PILEventListener {
    private lateinit var channel: MethodChannel

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

    override fun onAttachedToEngine(@NonNull flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
        channel = MethodChannel(flutterPluginBinding.binaryMessenger, "voip_flutter_integration")
        channel.setMethodCallHandler(this)

        instance = this
    }

    override fun onDetachedFromEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {
        channel.setMethodCallHandler(null)
    }

    @Suppress("UNCHECKED_CAST")
    override fun onMethodCall(@NonNull call: MethodCall, @NonNull result: Result) {
        val hasType = call.method.contains('.')
        val type = if (hasType) call.method.split('.')[0] else null
        val method = if (hasType) call.method.split('.')[1] else call.method

        fun assertPILInitialized() {
            if (BuildConfig.DEBUG && !::pil.isInitialized) {
                error("FIL not initialized. Create an instance using startFIL.")
            }
        }
        
        when {
            !hasType && method == "startFIL" -> {
                val arguments = call.arguments<List<*>>()
                val preferences = preferencesOf(arguments[0]!! as Map<String, Any>)
                val auth = authOf(arguments[1]!! as Map<String, Any>)
                val userAgent = arguments[2]!! as String

                startFIL(preferences, auth, userAgent, result)
            }
            type == "FIL" -> {
                assertPILInitialized()

                when (method) {
                    "call" -> {
                        val number = call.arguments<String>()

                        pil.call(number)

                        result.success(null)
                    }
                    "getCall" -> {
                        result.success(pil.call?.toMap())
                    }
                }
            }
            type == "EventsManager" -> {
                assertPILInitialized()
                
                when (method) {
                    "listen" -> {
                        pil.events.listen(this)

                        result.success(null)
                    }
                    "stopListening" -> {
                        pil.events.stopListening(this)

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
            else -> result.notImplemented()
        }
    }

    private fun startFIL(
            preferences: Preferences,
            auth: Auth,
            userAgent: String,
            result: Result
    ) {
        Log.i(tag, "startFIL called")

        pil = startAndroidPIL {
            this.preferences = preferences
            this.auth = auth

            ApplicationSetup(
                    application = application,
                    activities = ApplicationSetup.Activities(activityClass, activityClass),
                    automaticallyStartCallActivity = false,
                    logger = ::onLogReceived,
                    userAgent = userAgent
            )
        }

        result.success(null)
    }

    private fun onLogReceived(message: String, level: LogLevel) {
        Handler(Looper.getMainLooper()) {
            channel.invokeMethod("onLogReceived", listOf(message, level.ordinal))
            true
        }
    }

    companion object {
        lateinit var instance: FIL
            private set

        private val tag = "FIL"
    }

    override fun onEvent(event: Event) = channel.invokeMethod("onEvent", event.toString())
}
