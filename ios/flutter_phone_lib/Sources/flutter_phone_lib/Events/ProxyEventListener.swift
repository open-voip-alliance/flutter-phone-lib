import Foundation
import iOSPhoneLib

class ProxyEventListener : PILEventDelegate {

    func onEvent(event: Event) {
          var arguments: Dictionary<String, Any?> = [:]

          switch event {
            case .incomingCallReceived(let state),
                 .outgoingCallStarted(let state),
                 .callStateUpdated(let state),
                 .callDurationUpdated(let state),
                 .callConnected(let state),
                 .attendedTransferAborted(let state),
                 .attendedTransferEnded(let state),
                 .attendedTransferConnected(let state),
                 .attendedTransferStarted(let state),
                 .audioStateUpdated(let state),
                 .callEnded(let state):
                 arguments = event.toDictionary(state: state)
            case .outgoingCallSetupFailed(let reason),
                 .incomingCallSetupFailed(let reason):
                 arguments = event.toDictionary(reason: reason)
            default: fatalError("Unknown event: \(event) - Add event type to ProxyEventListener")
        }

        phoneLib.channel.invokeMethod("onEvent", arguments: arguments)
    }
    
    private let phoneLib: PhoneLibPlugin
    
    init(_ phoneLib: PhoneLibPlugin) {
        self.phoneLib = phoneLib
    }
}
