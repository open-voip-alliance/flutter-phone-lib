import iOSPhoneLib
import Flutter

internal extension Event {

    private func formatEventType() -> String {
        let type = String(describing: self).components(separatedBy: "(")[0]
        return type.prefix(1).capitalized + type.dropFirst(1)
    }

    func toDictionary(state: CallSessionState) -> Dictionary<String, Any?> {
        return [
            "type": formatEventType(),
            "state": state.toDictionary()
        ]
    }

    func toDictionary(reason: CallSetupFailedReason) -> Dictionary<String, Any?> {
        return [
            "type": formatEventType(),
            "reason": reason.asReasonString()
        ]
    }
}

internal extension CallSetupFailedReason {
    func asReasonString() -> String {
        switch self {
            case .unknown: return "UNKNOWN"
            case .inCall: return "IN_CALL"
            case .unableToRegister: return "UNABLE_TO_REGISTER"
            case .rejectedByCallKit: return "REJECTED_BY_CALL_KIT"
        }
    }
}
