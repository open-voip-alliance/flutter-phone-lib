import Foundation
import iOSPhoneLib

internal func preferencesOf(_ dict: Dictionary<String, Any?>) -> Preferences {
    NSLog(String(describing: dict))

    return Preferences(
        useApplicationRingtone: dict["useApplicationProvidedRingtone"] as? Bool ?? false,
        includesCallsInRecents: dict["showCallsInNativeRecents"] as? Bool ?? true,
        supplementaryContacts: Set((dict["supplementaryContacts"] as? Array<Dictionary<String, String?>> ?? []).map {
            (item) in  SupplementaryContact(
                number: (item["number"] ?? "") ?? "",
                name: (item["name"] ?? "") ?? ""
            )
        }
        enableAdvancedLogging: dict["enableAdvancedLogging"] as? Bool ?? false,
    ))
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
            "supplementaryContacts": supplementaryContacts.map { item in ["name": item.name, "number": item.number]},
        ])
    }
}
