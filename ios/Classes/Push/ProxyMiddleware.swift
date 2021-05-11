import Foundation
import PIL
import PushKit

/**
 * Middleware for passing through to the Dart side.
 */
internal class ProxyMiddleware : Middleware {
    func respond(payload: PKPushPayload, available: Bool) {
        FlutterCallback.invokeMethodThroughCallback(
            method: "Middleware.respond",
            arguments: payload.toDictionary(), available
        )
    }
    
    func tokenReceived(token: String) {
        FlutterCallback.invokeMethodThroughCallback(method: "Middleware.tokenReceived", arguments: token)
    }
    
    func extractCallDetail(from payload: PKPushPayload) -> IncomingPayloadCallDetail {
        return IncomingPayloadCallDetail(
            phoneNumber: payload.dictionaryPayload["phonenumber"] as? String ?? "",
            callerId: payload.dictionaryPayload["caller_id"] as? String ?? ""
        )
    }
    
    func handleNonVoIPPush(payload: PKPushPayload, type: PKPushType) {}
}
