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
import org.openvoipalliance.androidplatformintegration.Builder

import org.openvoipalliance.androidplatformintegration.PIL
import org.openvoipalliance.androidplatformintegration.configuration.ApplicationSetup
import org.openvoipalliance.androidplatformintegration.logging.LogLevel
import org.openvoipalliance.androidplatformintegration.startAndroidPIL

class FIL : FlutterPlugin, MethodCallHandler {
    private lateinit var channel: MethodChannel

    private lateinit var pil: PIL

    /**
     * Must be set to use this plugin.
     */
    lateinit var application: Application

    /**
     * The activity to show when the incoming call notification is pressed. Almost always the
     * `MainActivity`.
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

        when {
            !hasType && method == "startFil" -> {
                val arguments = call.arguments<List<*>>()
                val builder = (arguments[0]!! as Map<String, Any>).toObject<Builder>()
                val applicationSetup = (arguments[1]!! as Map<String, Any>).toObject<ApplicationSetup>()

                Log.i(tag, arguments[0].toString())
                Log.i(tag, builder.preferences.codecs.map { c -> c?.name ?: "null" }.toString())

                startFil(builder, applicationSetup, result)
            }
            type == "FIL" -> {
                if (BuildConfig.DEBUG && !::pil.isInitialized) {
                    error("FIL not initialized. Create an instance using startFil.")
                };

                when (method) {
                    "call" -> {
                        val number = call.arguments<String>()

                        pil.call(number)

                        result.success(null)
                    }
                }
            }
            else -> result.notImplemented()
        }
    }

    private fun startFil(builder: Builder, applicationSetup: ApplicationSetup, result: Result) {
        Log.i(tag, "startFil")

        pil = startAndroidPIL {
            auth = builder.auth
            preferences = builder.preferences

            ApplicationSetup(
                    application = application,
                    activities = ApplicationSetup.Activities(activityClass, activityClass),
                    automaticallyStartCallActivity = false,
                    logger = ::onLogReceived,
                    userAgent = applicationSetup.userAgent
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
}
