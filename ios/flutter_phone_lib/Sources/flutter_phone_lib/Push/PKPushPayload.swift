import Foundation
import PushKit

internal extension PKPushPayload {
    func toDictionary() -> Dictionary<String, Any?> {
        ["data": dictionaryPayload]
    }
}
