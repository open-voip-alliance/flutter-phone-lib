import Foundation
import PIL

class ProxyEventListener : PILEventDelegate {
    func onEvent(event: Event, callSessionState: CallSessionState) {
        phoneLib.channel.invokeMethod("onEvent", arguments: event.toDictionary(state: callSessionState))
    }
    
    private let phoneLib: PhoneLibPlugin
    
    init(_ phoneLib: PhoneLibPlugin) {
        self.phoneLib = phoneLib
    }
}
