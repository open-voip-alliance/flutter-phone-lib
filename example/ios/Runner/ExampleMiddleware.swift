import Foundation
import PushKit
import flutter_phone_lib

/// The plugin hands us the push token and every incoming call push. Registering
/// with the middleware is done from Dart, see lib/src/middleware.dart.
class ExampleMiddleware: NativeMiddleware {

    func tokenReceived(token: String) {
        // The store the shared_preferences plugin reads, so Dart can pick up the token.
        UserDefaults.standard.set(token, forKey: "flutter.push_token")
    }

    func inspect(payload: PKPushPayload, type: PKPushType) {}

    func respond(payload: PKPushPayload, available: Bool, reason: NativeMiddlewareUnavailableReason?) {
        guard let urlString = payload.dictionaryPayload["response_api"] as? String,
              let url = URL(string: urlString) else { return }

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try? JSONSerialization.data(withJSONObject: [
            "call_id": payload.dictionaryPayload["call_id"] ?? "",
            "available": available,
        ])

        print("Responding to middleware: available=\(available), reason=\(String(describing: reason))")

        URLSession.shared.dataTask(with: request) { _, response, error in
            if let error = error {
                print("Failed to respond to middleware: \(error)")
            } else if let response = response as? HTTPURLResponse {
                print("Middleware responded with \(response.statusCode)")
            }
        }.resume()
    }
}
