package org.openvoipalliance.flutterphonelib.push

import android.os.Handler
import android.os.Looper
import com.google.firebase.messaging.RemoteMessage
import org.openvoipalliance.androidphoneintegration.push.Middleware
import org.openvoipalliance.flutterphonelib.PhoneLib

/**
 * Middleware for passing through to the Dart side.
 */
internal class ProxyMiddleware(private val phoneLib: PhoneLib) : Middleware {
    private val handler = Handler(Looper.getMainLooper());

    override fun respond(remoteMessage: RemoteMessage, available: Boolean) {
        handler.post {
            phoneLib.channel.invokeMethod(
                    "Middleware.respond",
                    listOf(remoteMessage.toMap(), available)
            )
        }
    }

    override fun tokenReceived(token: String) {
        handler.post {
            phoneLib.channel.invokeMethod("Middleware.tokenReceived", token)
        }
    }

}