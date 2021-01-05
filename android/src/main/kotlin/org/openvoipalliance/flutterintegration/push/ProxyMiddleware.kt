package org.openvoipalliance.flutterintegration.push

import android.os.Handler
import android.os.Looper
import android.util.Log
import com.google.firebase.messaging.RemoteMessage
import org.openvoipalliance.androidplatformintegration.push.Middleware
import org.openvoipalliance.flutterintegration.FIL

/**
 * Middleware for passing through to the Dart side.
 */
internal class ProxyMiddleware(private val fil: FIL) : Middleware {
    private val handler = Handler(Looper.getMainLooper());

    override fun respond(remoteMessage: RemoteMessage, available: Boolean) {
        handler.post {
            fil.channel.invokeMethod(
                    "Middleware.respond",
                    listOf(remoteMessage.toMap(), available)
            )
        }
    }

    override fun tokenReceived(token: String) {
        handler.post {
            fil.channel.invokeMethod("Middleware.tokenReceived", token)
        }
    }

}