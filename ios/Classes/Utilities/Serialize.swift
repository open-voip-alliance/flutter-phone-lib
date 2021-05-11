import Foundation

internal func serializeToJSON(_ dict: Dictionary<String, Any?>) -> String {
    return String(
        data: try! JSONSerialization.data(withJSONObject: dict),
        encoding: String.Encoding.utf8
    )!
}

internal func deserializeFromJSON(_ string: String) -> Dictionary<String, Any?> {
    return try! JSONSerialization.jsonObject(
        with: string.data(using: .utf8)!,
        options: []
    ) as! Dictionary<String, Any?>
}
