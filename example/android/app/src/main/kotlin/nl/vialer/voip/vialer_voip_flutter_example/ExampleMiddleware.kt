package nl.vialer.voip.vialer_voip_flutter_example

import android.content.Context
import android.util.Log
import com.google.firebase.messaging.RemoteMessage
import org.json.JSONObject
import org.openvoipalliance.flutterphonelib.NativeMiddleware
import org.openvoipalliance.flutterphonelib.NativeMiddlewareUnavailableReason
import java.net.HttpURLConnection
import java.net.URL
import kotlin.concurrent.thread

/**
 * The plugin hands us the push token and every incoming call push. Registering
 * with the middleware is done from Dart, see lib/src/middleware.dart.
 */
class ExampleMiddleware(private val context: Context) : NativeMiddleware {

    // The store the shared_preferences plugin reads, so Dart can pick up the token.
    private val prefs
        get() = context.getSharedPreferences("FlutterSharedPreferences", Context.MODE_PRIVATE)

    override fun tokenReceived(token: String) {
        prefs.edit().putString("flutter.push_token", token).apply()
    }

    override fun respond(
        remoteMessage: RemoteMessage,
        available: Boolean,
        reason: NativeMiddlewareUnavailableReason?,
    ) {
        val url = remoteMessage.data["response_api"] ?: return

        val body = JSONObject()
            .put("call_id", remoteMessage.data["call_id"])
            .put("available", available)

        Log.d(TAG, "Responding to middleware: available=$available, reason=$reason")

        thread {
            try {
                (URL(url).openConnection() as HttpURLConnection).run {
                    requestMethod = "POST"
                    setRequestProperty("Content-Type", "application/json")
                    doOutput = true
                    outputStream.use { it.write(body.toString().toByteArray()) }
                    Log.d(TAG, "Middleware responded with $responseCode")
                    disconnect()
                }
            } catch (e: Exception) {
                Log.e(TAG, "Failed to respond to middleware", e)
            }
        }
    }

    companion object {
        private const val TAG = "FPL-Example"
    }
}
