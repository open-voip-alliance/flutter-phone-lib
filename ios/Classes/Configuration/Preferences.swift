import Foundation
import iOSPhoneLib

internal func preferencesOf(_ dict: Dictionary<String, Any?>) -> Preferences {
    NSLog(String(describing: dict))
    
    return Preferences(
        useApplicationRingtone: dict["useApplicationProvidedRingtone"] as? Bool ?? false,
        codecs: (dict["codecs"] as? Array<String> ?? []).map { Codec(rawValue: $0)! },
        includesCallsInRecents: dict["showCallsInNativeRecents"] as? Bool ?? true
    )
}

internal func preferencesOf(_ json: String?) -> Preferences? {
    if (json == nil) { return nil }
    
    return preferencesOf(deserializeFromJSON(json!))
}

internal extension Preferences {
    func serialize() -> String {
        return serializeToJSON([
            "useApplicationRingtone": useApplicationRingtone,
            "showCallsInNativeRecents": includesCallsInRecents,
            "codecs": codecs.map { $0.rawValue }
        ])
    }
}
