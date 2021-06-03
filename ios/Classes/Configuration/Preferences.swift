import Foundation
import PIL
import iOSVoIPLib

internal func preferencesOf(_ dict: Dictionary<String, Any?>) -> Preferences {
    NSLog(String(describing: dict))
    
    return Preferences(
        useApplicationRingtone: dict["useApplicationRingtone"] as? Bool ?? false,
        codecs: (dict["codecs"] as? Array<String> ?? []).map { Codec(rawValue: $0)! }
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
            "codecs": codecs.map { $0.rawValue }
        ])
    }
}
