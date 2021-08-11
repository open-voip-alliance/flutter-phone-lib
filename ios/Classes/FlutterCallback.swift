
import Foundation
import Flutter
import os

internal class FlutterCallback {
    private static var flutterEngine: FlutterEngine? = nil
    private static var methodChannel: FlutterMethodChannel? = nil
    
    private static let methodQueue = DispatchQueue(label: "methodQueue")

    static func register(key: String, handle: Int64) {
        UserDefaults.standard.set(handle, forKey: key)
    }
    
    static private func handleOf(_ key: String) throws -> Int64  {
        let callbackHandle = Int64(UserDefaults.standard.integer(forKey: key))

        if (callbackHandle == 0) {
            throw CallbackNotRegisteredError(callbackKey: key)
        }

        return callbackHandle
    }
    
    static func invokeMethodThroughCallback(method: String, arguments: Any..., result: FlutterResult? = nil) {
        let invokeMethod = {
            methodQueue.async {
                let initialize = try! handleOf(PhoneLibPlugin.Keys.INITIALIZE)
                let methodCallbackHandle = try! handleOf(method)

                var methodArgs = [Any]()
                methodArgs.append(contentsOf: [initialize, methodCallbackHandle])
                methodArgs.append(contentsOf: arguments)

                log("Invoking method through callback dispatcher: \(method)")
                methodChannel!.invokeMethod(method, arguments: methodArgs, result: result)
            }
        }
        
        if (flutterEngine == nil) {
            methodQueue.suspend()
            log("Suspending method queue")

            // We invoke the method here already, it will not be actually run since the queue is suspended. We
            // do this so it's still in (mostly) proper order of execution.
            invokeMethod()

            flutterEngine = FlutterEngine(
                name: "FlutterPhoneLib",
                project: nil,
                allowHeadlessExecution: true
            )

            methodChannel = FlutterMethodChannel(
                name: "org.openvoipalliance.flutterphonelib/background",
                binaryMessenger: flutterEngine!.binaryMessenger
            )

            let callbackDispatcherHandle = try! handleOf(PhoneLibPlugin.Keys.CALLBACK_DISPATCHER)
            let callbackDispatcherInfo = FlutterCallbackCache.lookupCallbackInformation(callbackDispatcherHandle)!
            
            log("Executing callback dispatcher")
            flutterEngine!.run(
                withEntrypoint: callbackDispatcherInfo.callbackName,
                libraryURI: callbackDispatcherInfo.callbackLibraryPath
            )

            PhoneLibPlugin.registerPlugins!(flutterEngine!)

            methodChannel!.setMethodCallHandler() { call, result in
                if (call.method == "callbackDispatcherIsInitialized") {
                    log("Callback dispatcher is ready to receive methods")

                    result(nil)
                    methodQueue.resume()
                    log("Resuming method queue")
                }
            }

            log("Waiting until callback dispatcher is ready to receive method calls")
        } else {
            invokeMethod()
        }
    }
}

class CallbackNotRegisteredError : Error {
    let callbackKey: String

    init(callbackKey: String) {
        self.callbackKey = callbackKey
    }
}
