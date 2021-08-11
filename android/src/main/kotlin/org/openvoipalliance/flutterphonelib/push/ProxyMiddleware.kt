package org.openvoipalliance.flutterphonelib.push

import android.content.Context
import android.os.Handler
import android.os.Looper
import android.util.Log
import com.google.firebase.messaging.RemoteMessage
import io.flutter.plugin.common.MethodChannel
import kotlinx.coroutines.*
import org.openvoipalliance.androidphoneintegration.push.Middleware
import org.openvoipalliance.flutterphonelib.PhoneLib
import org.openvoipalliance.flutterphonelib.invokeMethodThroughCallback
import kotlin.coroutines.resume
import kotlin.coroutines.suspendCoroutine

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

    override suspend fun inspect(remoteMessage: RemoteMessage): Boolean =
        suspendCoroutine { continuation ->
            context.invokeMethodThroughCallback(
                PhoneLib.Keys.MIDDLEWARE_INSPECT,
                remoteMessage.toMap(),
                result = object : MethodChannel.Result {
                    override fun success(result: Any?) = continuation.resume(result as Boolean)

                    override fun error(
                        errorCode: String?,
                        errorMessage: String?,
                        errorDetails: Any?
                    ) = continuation.resume(false)

                    override fun notImplemented() = continuation.resume(false)
                }
            )
        }
}