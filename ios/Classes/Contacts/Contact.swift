import PIL

internal extension Contact {
    func toDictionary() -> Dictionary<String, Any?> {
        [
            "name": name,
            "imageUri": nil,
        ]
    }
}
