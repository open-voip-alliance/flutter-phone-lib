import '../configuration/application_setup.dart';

import 'remote_message.dart';

class Middleware {
  const Middleware({
    required this.respond,
    required this.tokenReceived,
  });

  /// Runs in a separate isolate, the same isolate as
  /// [ApplicationSetup.initialize], [ApplicationSetup.logger]
  /// and [tokenReceived].
  ///
  /// Must be a static or top level function.
  final void Function(RemoteMessage, bool available) respond;

  /// Runs in a separate isolate, the same isolate as
  /// [ApplicationSetup.initialize], [ApplicationSetup.logger]
  /// and [respond].
  ///
  /// Must be a static or top level function.
  final void Function(String token) tokenReceived;
}
