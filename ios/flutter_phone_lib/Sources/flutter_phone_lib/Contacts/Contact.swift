import iOSPhoneLib

internal extension Contact {
    func toDictionary() -> Dictionary<String, Any?> {
        [
            "name": name,
            "imageUri": nil,
        ]
    }
}
