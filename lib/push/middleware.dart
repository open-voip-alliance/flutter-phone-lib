import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';

import 'remote_message.dart';

class Middleware {
  const Middleware({
    @required this.respond,
    @required this.tokenReceived,
  });

  /// Must be a static or top level function.
  final void Function(RemoteMessage, bool available) respond;

  /// Must be a static or top level function.
  final void Function(String token) tokenReceived;
}
