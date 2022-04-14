import Flutter
import iOSPhoneLib
import PushKit

public protocol NativeMiddleware {
    func respond(payload: PKPushPayload, available: Bool, reason: NativeMiddlewareUnavailableReason?)
    
    func tokenReceived(token: String)
    
    func inspect(payload: PKPushPayload, type: PKPushType)
}

public struct CallDetail {
    public var phoneNumber: String
    public var callId: String
    
    public init(phoneNumber: String, callId: String) {
        self.phoneNumber = phoneNumber
        self.callId = callId
    }
}

class NativeMiddlewareBridger: Middleware {
    let nativeMiddleware: NativeMiddleware
    
    init(nativeMiddleware: NativeMiddleware) {
        self.nativeMiddleware = nativeMiddleware
    }
    
    func respond(payload: PKPushPayload, available: Bool, reason: UnavailableReason?) {
        let nativeUnavailableReason: NativeMiddlewareUnavailableReason? = {
            switch reason {
                case .inCall: return NativeMiddlewareUnavailableReason.inCall
                case .unableToRegister: return NativeMiddlewareUnavailableReason.unableToRegister
                default: return nil
            }
        }()

        self.nativeMiddleware.respond(payload: payload, available: available, reason: nativeUnavailableReason)
    }
    
    func tokenReceived(token: String) {
        self.nativeMiddleware.tokenReceived(token: token)
    }
    
    func inspect(payload: PKPushPayload, type: PKPushType) {
        self.nativeMiddleware.inspect(payload: payload, type: type)
    }
}

public enum NativeMiddlewareUnavailableReason {
    case inCall
    case unableToRegister
}
