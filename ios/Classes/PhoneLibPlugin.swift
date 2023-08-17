import Flutter
import UIKit
import iOSPhoneLib
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
    
    public func call(number: String) {
        pil.call(number: number)
    }

    public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        do {
            let hasType = call.method.contains(".")
            let type = hasType ? String(call.method.split(separator: ".")[0]) : nil
            let method = hasType ? String(call.method.split(separator: ".")[1]) : call.method

            if (!hasType && method == "initializePhoneLib") {
                withSuccess(result) {
                    let arguments = call.arguments as! Array<Any>
                    let preferences = preferencesOf(arguments[0] as! Dictionary<String, Any?>)
                    let auth = authOf(arguments[1] as! Dictionary<String, Any?>)
                    let userAgent = arguments[7] as! String

                    let defaults = UserDefaults.standard
                    defaults.set(preferences.serialize(), forKey: Keys.PREFERENCES)
                    defaults.set(auth.serialize(), forKey: Keys.AUTH)
                    defaults.set(userAgent, forKey: Keys.USER_AGENT)

                    PhoneLibPlugin.appDelegate!.startPhoneLib()
                }
            } else {
                switch type {
                    case "PhoneLib": switch method {
                        case "call": withSuccess(result) {
                            pil.call(number: call.arguments as! String)
                        }
                        case "start": withSuccess(result) {
                            let arguments = call.arguments as! Array<Any>
                            pil.preferences = preferencesOf(arguments[0] as! Dictionary<String, Any?>)
                            pil.auth = authOf(arguments[1] as! Dictionary<String, Any?>)
                            pil.start(forceInitialize: false, forceReregister: true)
                        }
                        case "stop": withSuccess(result) {
                            pil.stop()
                        }
                        case "updatePreferences": withSuccess(result) {
                            let arguments = call.arguments as! Array<Any>
                            pil.preferences = preferencesOf(arguments[0] as! Dictionary<String, Any?>)
                        }
                        case "sessionState": withSuccess(result) {
                            result(pil.sessionState.toDictionary())
                        }
                        case "performEchoCancellationCalibration": withSuccess(result) {
                            pil.performEchoCancellationCalibration()
                        }
                        default: result(FlutterMethodNotImplemented)
                    }
                    case "Calls": switch method {
                        case "active": result(PhoneLibPlugin.pil!.calls.activeCall?.toDictionary())
                        default: result(FlutterMethodNotImplemented)
                    }
                    case "EventsManager": switch method {
                        case "listen": withSuccess(result) {
                            pil.events.listen(delegate: eventListener)
                        }
                        case "stopListening": withSuccess(result) {
                            pil.events.stopListening(delegate: eventListener)
                        }
                        default: result(FlutterMethodNotImplemented)
                    }
                    case "CallActions": switch method {
                        case "hold": withSuccess(result) { pil.actions.hold() }
                        case "unhold": withSuccess(result) { pil.actions.unhold() }
                        case "toggleHold": withSuccess(result) { pil.actions.toggleHold() }
                        case "sendDtmf": withSuccess(result) {
                            pil.actions.sendDtmf(String((call.arguments as! String).first!))
                        }
                        case "beginAttendedTransfer": withSuccess(result) {
                            pil.actions.beginAttendedTransfer(number: call.arguments as! String)
                        }
                        case "completeAttendedTransfer": withSuccess(result) { pil.actions.completeAttendedTransfer() }
                        case "answer" : withSuccess(result) { pil.actions.answer() }
                        case "decline": withSuccess(result) { pil.actions.decline() }
                        case "end": withSuccess(result) { pil.actions.end() }
                        default: result(FlutterMethodNotImplemented)
                    }
                    case "AudioManager": switch method {
                        case "isMicrophoneMuted": result(pil.audio.isMicrophoneMuted)
                        case "state": result(pil.audio.state.toDictionary())
                        case "routeAudio": withSuccess(result) {
                            let isStandardAudioRoute = (call.arguments as? String != nil)

                            if (isStandardAudioRoute) {
                                pil.audio.routeAudio(audioRouteOf(call.arguments as! String))
                            }
                        }
                        case "launchAudioRoutePicker": withSuccess(result) { pil.audio.launchAudioRoutePicker() }
                        case "mute": withSuccess(result) { pil.audio.mute() }
                        case "unmute": withSuccess(result) { pil.audio.unmute() }
                        case "toggleMute": withSuccess(result) { pil.audio.toggleMute() }
                        default: result(FlutterMethodNotImplemented)
                    }
                    default: result(FlutterMethodNotImplemented)
                }
            }
        } catch {
            result(
                FlutterError(
                    code: String(describing: type(of: error)),
                    message: error.localizedDescription,
                    details: Thread.callStackSymbols.joined(separator: "\n")
                )
            )
        }
    }

    // Ease of use getter.
    private var pil: PIL {
        get { PhoneLibPlugin.pil! }
    }

    internal static var pil: PIL?
    internal static var appDelegate: UIApplicationDelegate?
    internal static var onLogReceived: OnLogReceivedCallback?
    internal static var ringtonePath: String?
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

    /**
     Assumes that the [block] runs successfully.
     */
    private func withSuccess(_ result: FlutterResult, _ block: () -> Void) {
        block()
        result(nil)
    }
}

extension UIApplicationDelegate {
    public func startPhoneLib(_ registerPlugins: ((FlutterPluginRegistry) -> Void)? = nil, nativeMiddleware: NativeMiddleware? = nil, onCallEnded: OnCallEndedCallback? = nil, onLogReceived: OnLogReceivedCallback? = nil, ringtonePath: String? = nil) {
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
        
        if (PhoneLibPlugin.ringtonePath == nil) {
            PhoneLibPlugin.ringtonePath = ringtonePath
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
                    logDelegate: PhoneLibPlugin.logDelegate,
                    ringtonePath: PhoneLibPlugin.ringtonePath ?? ""
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
    
    public func startCall(number: String) {
        PhoneLibPlugin.pil?.call(number: number)
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
