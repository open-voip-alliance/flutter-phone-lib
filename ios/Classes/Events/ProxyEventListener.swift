import Foundation
import PIL

class ProxyEventListener : PILEventDelegate {

    func onEvent(event: Event) {
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
                phoneLib.channel.invokeMethod(
                    "onEvent",
                    arguments: event.toDictionary(state: state)
                )
            default: fatalError("Unknown event: \(event) - Add event type to ProxyEventListener")
        }
    }
    
    private let phoneLib: PhoneLibPlugin
    
    init(_ phoneLib: PhoneLibPlugin) {
        self.phoneLib = phoneLib
    }
}
