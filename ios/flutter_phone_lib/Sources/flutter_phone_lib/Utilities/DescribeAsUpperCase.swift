import Foundation

/**
 Converts a name like `outgoingCallStarted` to `OUTGOING_CALL_STARTED`.
 */
internal func describeAsUpperSnakeCase(_ obj: Any) -> String {
    let str = String(describing: obj)
    let regex = try! NSRegularExpression(pattern: "([A-Z])")
    
    return regex.stringByReplacingMatches(
        in: str,
        options: [],
        range: NSRange(location: 0, length: str.count),
        withTemplate: "_$1"
    ).uppercased()
}
