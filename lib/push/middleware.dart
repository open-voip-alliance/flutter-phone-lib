import '../configuration/application_setup.dart';

import 'remote_message.dart';

class Middleware {
  const Middleware({
    required this.respond,
    required this.tokenReceived,
    required this.inspect,
  });

  /// Runs in a separate isolate, the same isolate as
  /// [ApplicationSetup.initialize] and [tokenReceived].
  ///
  /// Must be a static or top level function.
  final void Function(RemoteMessage, bool available) respond;

  /// Runs in a separate isolate, the same isolate as
  /// [ApplicationSetup.initialize] and [respond].
  ///
  /// Must be a static or top level function.
  final void Function(String token) tokenReceived;

  /// Inspect remote messages to determine if they're VoIP related or not.
  ///
  /// On Android, returning `true` means the remote message is VoIP related
  /// and will not be ignored. If the remote message is not VoIP related,
  /// `false` should be returned.
  ///
  /// On iOS the return value is ignored.
  ///
  /// Runs in a separate isolate, the same isolate as
  /// [ApplicationSetup.initialize], [respond] and [tokenReceived].
  ///
  /// Must be a static or top level function.
  final bool Function(RemoteMessage) inspect;
}
