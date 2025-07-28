import iOSPhoneLib

internal extension SupplementaryContact {
    func toDictionary() -> Dictionary<String, Any?> {
        [
            "number": number,
            "name": name,
            "imageUri": nil,
        ]
    }
}
