import Foundation
import PIL

internal func authOf(_ dict: Dictionary<String, Any?>) -> Auth {
    return Auth(
        username: dict["username"] as! String,
        password: dict["password"] as! String,
        domain: dict["domain"] as! String,
        port: dict["port"] as! Int,
        secure: dict["secure"] as! Bool
    )
}

internal func authOf(_ json: String?) -> Auth? {
    if (json == nil) { return nil }
    
    return authOf(deserializeFromJSON(json!))
}

internal extension Auth {
    func serialize() -> String {
        return serializeToJSON([
            "username": username,
            "password": password,
            "domain": domain,
            "port": port,
            "secure": secure
        ])
    }
}
