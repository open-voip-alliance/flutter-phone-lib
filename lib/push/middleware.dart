import 'remote_message.dart';

abstract class Middleware {
  // ignore: avoid_positional_boolean_parameters
  void respond(RemoteMessage remoteMessage, bool available);

  void tokenReceived(String token);
}
