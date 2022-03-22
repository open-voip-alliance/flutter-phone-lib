import Flutter
import PIL
import PushKit

public protocol NativeMiddleware {
    func respond(payload: PKPushPayload, available: Bool)
    
    func tokenReceived(token: String)
    
    func inspect(payload: PKPushPayload, type: PKPushType)
    
    func extractCallDetail(from payload: PKPushPayload) -> CallDetail
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
    
    func respond(payload: PKPushPayload, available: Bool) {
        self.nativeMiddleware.respond(payload: payload, available: available)
    }
    
    func tokenReceived(token: String) {
        self.nativeMiddleware.tokenReceived(token: token)
    }
    
    func extractCallDetail(from payload: PKPushPayload) -> IncomingPayloadCallDetail {
        let callDetail = self.nativeMiddleware.extractCallDetail(from: payload)
        
        return IncomingPayloadCallDetail(
            phoneNumber: callDetail.phoneNumber,
            callerId: callDetail.callId
        )
    }
    
    func inspect(payload: PKPushPayload, type: PKPushType) {
        self.nativeMiddleware.inspect(payload: payload, type: type)
    }
}
