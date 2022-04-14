import iOSPhoneLib
import Flutter

internal extension Event {
    func toDictionary(state: CallSessionState) -> Dictionary<String, Any?> {
        var type = String(describing: self).components(separatedBy: "(")[0]
        type = type.prefix(1).capitalized + type.dropFirst(1)

        return [
            "type": type,
            "state": state.toDictionary()
        ]
    }
}
