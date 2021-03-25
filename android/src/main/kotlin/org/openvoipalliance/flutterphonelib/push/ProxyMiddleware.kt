package org.openvoipalliance.flutterphonelib.push

import android.content.Context
import android.os.Handler
import android.os.Looper
import android.util.Log
import com.google.firebase.messaging.RemoteMessage
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.runBlocking
import kotlinx.coroutines.withContext
import org.openvoipalliance.androidphoneintegration.push.Middleware
import org.openvoipalliance.flutterphonelib.PhoneLib
import org.openvoipalliance.flutterphonelib.invokeMethodThroughCallback

/**
 * Middleware for passing through to the Dart side.
 */
internal class ProxyMiddleware(
        private val context: Context,
) : Middleware {
    override fun respond(remoteMessage: RemoteMessage, available: Boolean) {
        context.invokeMethodThroughCallback(
                PhoneLib.Keys.MIDDLEWARE_RESPOND,
                remoteMessage.toMap(),
                available
        )
    }

    override fun tokenReceived(token: String) {
        context.invokeMethodThroughCallback(PhoneLib.Keys.MIDDLEWARE_TOKEN_RECEIVED, token)
    }

}