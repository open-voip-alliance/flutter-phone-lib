package org.openvoipalliance.flutterphonelib

import android.content.Context
import android.os.Handler
import android.os.Looper
import android.util.Log
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.embedding.engine.dart.DartExecutor
import io.flutter.plugin.common.MethodChannel
import io.flutter.view.FlutterCallbackInformation
import io.flutter.view.FlutterMain
import kotlinx.coroutines.*
import kotlinx.coroutines.channels.Channel
import kotlin.coroutines.resume
import kotlin.coroutines.suspendCoroutine

private object FlutterCallback {
    private lateinit var flutterEngine: FlutterEngine
    private lateinit var methodChannel: MethodChannel

    private val jobExecutor = QueuedJobExecutor()

    fun register(context: Context, key: String, handle: Long) {
        context.sharedPreferences
            .edit()
            .putLong(key, handle)
            .apply()
    }

    private fun handleOf(context: Context, key: String): Long {
        val callbackHandle = context.sharedPreferences.getLong(key, 0)

        if (callbackHandle == 0L) {
            throw IllegalStateException("Callback is not registered: $callbackHandle")
        }

        return callbackHandle
    }

    fun optionalHandleOf(context: Context, key: String): Long? = try {
        handleOf(context, key)
    } catch (e: IllegalStateException) {
        null
    }

    /**
     * Invokes a method through the callback dispatcher.
     */
    fun invokeMethodThroughCallback(context: Context, method: String, vararg arguments: Any?, result: MethodChannel.Result? = null) {
        GlobalScope.launch(Dispatchers.Main) {
            if (!::flutterEngine.isInitialized) {
                FlutterMain.startInitialization(context)
                FlutterMain.ensureInitializationComplete(context, null)

                flutterEngine = FlutterEngine(context)
                methodChannel = MethodChannel(
                    flutterEngine.dartExecutor.binaryMessenger,
                    "org.openvoipalliance.flutterphonelib/background"
                )
            }

            launch {
                if (!jobExecutor.isRunning) {
                    jobExecutor.start()
                }

                jobExecutor.add(
                    // Job has to be lazy, since it should be started by the executor and
                    // not immediately.
                    GlobalScope.launch(start = CoroutineStart.LAZY) {
                        if (!flutterEngine.dartExecutor.isExecutingDart) {
                            // We wait until the callback dispatcher isolate is initialized on the Dart side
                            // and we can send methods.
                            suspendCoroutine<Unit> { continuation ->
                                // This needs to happen on the main thread.
                                launch(Dispatchers.Main) {
                                    val callbackHandle =
                                        handleOf(context, PhoneLib.Keys.CALLBACK_DISPATCHER)
                                    val callbackInfo = FlutterCallbackInformation
                                        .lookupCallbackInformation(callbackHandle)

                                    val callback = DartExecutor.DartCallback(
                                        context.assets,
                                        FlutterMain.findAppBundlePath(),
                                        callbackInfo
                                    )

                                    methodChannel.setMethodCallHandler { call, result ->
                                        if (call.method == "callbackDispatcherIsInitialized") {
                                            Log.d(
                                                PhoneLib.LOG_TAG,
                                                "Callback dispatcher is ready to receive methods"
                                            )
                                            continuation.resume(Unit)
                                            result.success(null)
                                        }
                                    }

                                    Log.d(PhoneLib.LOG_TAG, "Executing callback dispatcher")
                                    flutterEngine.dartExecutor.executeDartCallback(callback)
                                    Log.d(
                                        PhoneLib.LOG_TAG,
                                        "Waiting until callback dispatcher is ready to receive method calls"
                                    )
                                }
                            }
                        }

                        val initialize = handleOf(context, PhoneLib.Keys.INITIALIZE)
                        val methodCallbackHandle = handleOf(context, method)

                        Handler(Looper.getMainLooper()).post {
                            Log.d(
                                PhoneLib.LOG_TAG,
                                "Invoking method through callback dispatcher: $method"
                            )
                            methodChannel.invokeMethod(
                                method,
                                listOf(initialize, methodCallbackHandle, *arguments),
                                result
                            )
                        }
                    }
                )
            }
        }
    }
}

fun Context.registerFlutterCallback(key: String, handle: Long) =
    FlutterCallback.register(this, key, handle)

fun Context.invokeMethodThroughCallback(method: String, vararg arguments: Any?, result: MethodChannel.Result? = null) =
    FlutterCallback.invokeMethodThroughCallback(
        this@invokeMethodThroughCallback,
        method,
        *arguments,
        result = result,
    )

private class QueuedJobExecutor {
    private val channel = Channel<Job>()

    var isRunning = false
        private set

    suspend fun add(job: Job) {
        if (job.isActive) {
            Log.e(
                PhoneLib.LOG_TAG,
                "Job added to queue is already active, this should never happen!"
            )
            return
        }

        channel.send(job)
    }

    fun start() {
        isRunning = true

        // We don't want to block, so run jobs in a coroutine.
        GlobalScope.launch {
            while (isRunning) {
                channel.receive().join()
            }
        }
    }

    fun stop() {
        isRunning = false
    }
}