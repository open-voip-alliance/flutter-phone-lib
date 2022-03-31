import Flutter
import UIKit
import PIL
import PushKit

public typealias OnLogReceivedCallback = (String, LogLevel) -> Void
public typealias OnCallEndedCallback = (NativeCall) -> Void

public class PhoneLibPlugin: NSObject, FlutterPlugin {
    public static func register(with registrar: FlutterPluginRegistrar) {
        let channel = FlutterMethodChannel(
            name: "org.openvoipalliance.flutterphonelib/foreground",
            binaryMessenger: registrar.messenger()
        )
        let instance = PhoneLibPlugin(channel)
        registrar.addMethodCallDelegate(instance, channel: channel)
    }
    
    internal static var instance: PhoneLibPlugin? = nil

    internal let channel: FlutterMethodChannel
    private lazy var eventListener = ProxyEventListener(self)
    
    init(_ channel: FlutterMethodChannel) {
        self.channel = channel

        super.init()

        if (PhoneLibPlugin.instance == nil) {
            PhoneLibPlugin.instance = self
        } else {
            log("ERROR: PhoneLibPlugin instance already exists")
        }
    }

    public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        let hasType = call.method.contains(".")
        let type = hasType ? String(call.method.split(separator: ".")[0]) : nil
        let method = hasType ? String(call.method.split(separator: ".")[1]) : call.method

        if (!hasType && method == "initializePhoneLib") {
            let arguments = call.arguments as! Array<Any>
            let preferences = preferencesOf(arguments[0] as! Dictionary<String, Any?>)
            let auth = authOf(arguments[1] as! Dictionary<String, Any?>)
            let callbackDispatcherHandle = arguments[2] as! NSNumber
            let initializeResourcesHandle = arguments[3] as! NSNumber
            let middlewareRespondHandle = arguments[4] as! NSNumber
            let middlewareTokenReceivedHandle = arguments[5] as! NSNumber
            let middlewareInspectHandle = arguments[6] as! NSNumber
            let userAgent = arguments[7] as! String
            
            let defaults = UserDefaults.standard
            defaults.set(preferences.serialize(), forKey: Keys.PREFERENCES)
            defaults.set(auth.serialize(), forKey: Keys.AUTH)
            defaults.set(userAgent, forKey: Keys.USER_AGENT)
            
            FlutterCallback.register(key: Keys.CALLBACK_DISPATCHER, handle: callbackDispatcherHandle.int64Value)
            FlutterCallback.register(key: Keys.INITIALIZE, handle: initializeResourcesHandle.int64Value)
            FlutterCallback.register(key: Keys.MIDDLEWARE_RESPOND, handle: middlewareRespondHandle.int64Value)
            FlutterCallback.register(
                key: Keys.MIDDLEWARE_TOKEN_RECEIVED,
                handle: middlewareTokenReceivedHandle.int64Value
            )
            FlutterCallback.register(key: Keys.MIDDLEWARE_INSPECT, handle: middlewareInspectHandle.int64Value)
            
            PhoneLibPlugin.appDelegate!.startPhoneLib()
            
            result(nil)
        } else if (type == "PhoneLib") {
            if (method == "call") {
                pil.call(number: call.arguments as! String)

                result(nil)
            } else if (method == "start") {
                let arguments = call.arguments as! Array<Any>
                 pil.preferences = preferencesOf(arguments[0] as! Dictionary<String, Any?>)
                 pil.auth = authOf(arguments[1] as! Dictionary<String, Any?>)
                 pil.start(forceInitialize: false, forceReregister: true)
                 result(nil)
            } else if (method == "stop") {
                pil.stop()
                result(nil)
            } else if (method == "updatePreferences") {
                let arguments = call.arguments as! Array<Any>
                pil.preferences = preferencesOf(arguments[0] as! Dictionary<String, Any?>)
                result(nil)
            }
        } else if (type == "Calls") {
            if (method == "active") {
                result(PhoneLibPlugin.pil!.calls.activeCall?.toDictionary())
            }
        } else if (type == "EventsManager") {
            if (method == "listen") {
                pil.events.listen(delegate: eventListener)
                result(nil)
            } else if (method == "stopListening") {
                pil.events.stopListening(delegate: eventListener)
                result(nil)
            }
        } else if (type == "CallActions") {
            switch method {
                case "hold": pil.actions.hold()
                case "unhold": pil.actions.unhold()
                case "toggleHold": pil.actions.toggleHold()
                case "sendDtmf": pil.actions.sendDtmf(
                    String((call.arguments as! String).first!),
                    playToneLocally: true
                )
                case "beginAttendedTransfer": pil.actions.beginAttendedTransfer(number: call.arguments as! String)
                case "completeAttendedTransfer": pil.actions.completeAttendedTransfer()
                case "answer" : pil.actions.answer()
                case "decline": pil.actions.decline()
                case "end" : pil.actions.end()
                default:
                    result(FlutterMethodNotImplemented)
                    return
            }
            
            result(nil)
        } else if (type == "AudioManager") {
            switch method {
                case "isMicrophoneMuted":
                    result(pil.audio.isMicrophoneMuted)
                case "state":
                    result(pil.audio.state.toDictionary())
                case "routeAudio":
                    let isStandardAudioRoute = (call.arguments as? String != nil)

                    if (isStandardAudioRoute) {
                        pil.audio.routeAudio(audioRouteOf(call.arguments as! String))
                    }

                    result(nil)
                case "launchAudioRoutePicker":
                    pil.audio.launchAudioRoutePicker()
                    result(nil)
                case "mute":
                    pil.audio.mute()
                    result(nil)
                case "unmute":
                    pil.audio.unmute()
                    result(nil)
                case "toggleMute":
                    pil.audio.toggleMute()
                    result(nil)
                default: result(FlutterMethodNotImplemented)
            }
        } else {
            result(FlutterMethodNotImplemented)
        }
    }
    
    // Ease of use getter.
    private var pil: PIL {
        get { PhoneLibPlugin.pil! }
    }
    
    internal static var pil: PIL?
    internal static var appDelegate: UIApplicationDelegate?
    internal static var onLogReceived: OnLogReceivedCallback?
    internal static var logDelegate = OnLogReceivedWrapper()
    internal static var registerPlugins: ((FlutterPluginRegistry) -> Void)?
    internal static var nativeMiddleware: NativeMiddleware?
    internal static var onCallEnded: OnCallEndedCallback?
    internal static var callListener: PILEventDelegate?

    internal class Keys {
        static let SHARED_PREFERENCES = "FlutterPhoneLib"
        static let AUTH = "auth"
        static let PREFERENCES = "preferences"
        static let CALLBACK_DISPATCHER = "callbackDispatcher"
        static let INITIALIZE = "initialize"
        static let MIDDLEWARE_RESPOND = "Middleware.respond"
        static let MIDDLEWARE_TOKEN_RECEIVED = "Middleware.tokenReceived"
        static let MIDDLEWARE_INSPECT = "Middleware.inspect"
        static let USER_AGENT = "userAgent"
    }

    class OnLogReceivedWrapper: LogDelegate {
        func onLogReceived(message: String, level: LogLevel) {
            PhoneLibPlugin.onLogReceived?(message, level)
        }
    }
}

extension UIApplicationDelegate {
    public func startPhoneLib(_ registerPlugins: ((FlutterPluginRegistry) -> Void)? = nil, nativeMiddleware: NativeMiddleware? = nil, onCallEnded: OnCallEndedCallback? = nil, onLogReceived: OnLogReceivedCallback? = nil) {
        if (PIL.isInitialized) {
            log("FlutterPhoneLib is already initialized")
            return
        }

        if (PhoneLibPlugin.appDelegate == nil) {
            PhoneLibPlugin.appDelegate = self
        }
        
        if (PhoneLibPlugin.registerPlugins == nil) {
            PhoneLibPlugin.registerPlugins = registerPlugins
        }
        
        if (PhoneLibPlugin.nativeMiddleware == nil) {
            PhoneLibPlugin.nativeMiddleware = nativeMiddleware
        }

        if (PhoneLibPlugin.onCallEnded == nil) {
            PhoneLibPlugin.onCallEnded = onCallEnded
        }

        if (PhoneLibPlugin.onLogReceived == nil) {
            PhoneLibPlugin.onLogReceived = onLogReceived
        }
        
        let defaults = UserDefaults.standard
        let preferences = preferencesOf(defaults.string(forKey: PhoneLibPlugin.Keys.PREFERENCES))
        let auth = authOf(defaults.string(forKey: PhoneLibPlugin.Keys.AUTH))
        let userAgent = defaults.string(forKey: PhoneLibPlugin.Keys.USER_AGENT)
                
        if (preferences == nil || auth == nil || userAgent == nil) {
            log("Not starting yet, arguments are uninitialized")
            return
        }
        
        log("Starting..")

        do {
            PhoneLibPlugin.pil = try startIOSPIL(
                applicationSetup: ApplicationSetup(
                    middleware: NativeMiddlewareBridger(nativeMiddleware: PhoneLibPlugin.nativeMiddleware!),
                    requestCallUi: {
                        if let nav = self.window??.rootViewController as? UITabBarController {
                            nav.performSegue(withIdentifier: "LaunchCallSegue", sender: nav)
                        }
                    },
                    userAgent: userAgent!,
                    logDelegate: PhoneLibPlugin.logDelegate
                ),
                auth: auth,
                preferences: preferences
            )

            PhoneLibPlugin.callListener = CallListener()
            PhoneLibPlugin.pil?.events.listen(delegate: PhoneLibPlugin.callListener!)
        } catch {
            log("Not launching PIL: \(error)")
        }
    }

    public func addOnMissedCallNotificationPressedDelegate() {
        UNUserNotificationCenter.current().delegate = missedCallNotificationDelegate
    }
}

private let missedCallNotificationDelegate = OnMissedCallNotificationPressedDelegate()

class CallListener : PILEventDelegate {

    func onEvent(event: Event) {
        switch event {
            case .callEnded(let state):
                guard let call = state.activeCall else {
                    return
                 }

                PhoneLibPlugin.onCallEnded?(NativeCall(
                     mos: String(call.mos),
                     reason: "",
                     duration: String(call.duration),
                     direction: call.direction == .inbound ? "inbound" : "outbound"
                 ))
            default:
                return
        }
    }
}

public struct NativeCall {
    public let mos: String
    public let reason: String
    public let duration: String
    public let direction: String
}

class OnMissedCallNotificationPressedDelegate : NSObject, UNUserNotificationCenterDelegate  {
    public func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        if (response.notification.request.identifier == NotificationRequestIdentifiers.missedCalls.rawValue) {
            PhoneLibPlugin.instance!.channel.invokeMethod("onMissedCallNotificationPressed", arguments: nil)
        }
    }
}
