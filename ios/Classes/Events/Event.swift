import iOSPhoneLib
import Flutter

internal extension Event {

    private func formatEventType() -> String {
        var type = String(describing: self).components(separatedBy: "(")[0]
        return type.prefix(1).capitalized + type.dropFirst(1)
    }

    func toDictionary(state: CallSessionState) -> Dictionary<String, Any?> {
        return [
            "type": formatEventType(),
            "state": state.toDictionary()
        ]
    }

    func toDictionary(reason: CallSetupFailedReason) -> Dictionary<String, Any?> {
        var stringReason = "UNKNOWN"

        switch reason {
            case .inCall: stringReason = "IN_CALL"
            case .unableToRegister: stringReason = "UNABLE_TO_REGISTER"
            case .rejectedByCallKit: stringReason = "REJECTED_BY_CALL_KIT"
        }

        return [
            "type": formatEventType(),
            "reason": stringReason
        ]
    }
}
