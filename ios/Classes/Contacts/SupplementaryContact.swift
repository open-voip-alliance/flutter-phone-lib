import iOSPhoneLib

internal extension Contact {
    func toDictionary() -> Dictionary<String, Any?> {
        [
            "number": number,
            "name": name,
            "imageUri": nil,
        ]
    }
}
