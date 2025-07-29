import iOSPhoneLib
import Flutter

internal extension CallSessionState {
    func toDictionary() -> Dictionary<String, Any?> {
        [
            "activeCall": activeCall?.toDictionary(),
            "inactiveCall": inactiveCall?.toDictionary(),
            "audioState": audioState.toDictionary(),
        ]
    }
}
