import Foundation

internal func log(_ obj: Any?) {
    let str = obj is String ? obj as! String : String(describing: obj)
    
    NSLog("PhoneLib: " + str)
}
