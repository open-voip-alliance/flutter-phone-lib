import 'package:flutter/services.dart';

import 'configuration/application_setup.dart';
import 'logging/log_level.dart';

class Fil {
  /// For internal use only.
  static const MethodChannel channel =
      MethodChannel('voip_flutter_integration');

  static Fil _instance;

  static Fil get instance => _instance;

  final ApplicationSetup _app;

  Fil(this._app) {
    if (instance == null) {
      _instance = this;
    } else {
      throw StateError('Only one instance of the Fil is supported.');
    }

    channel.setMethodCallHandler(_onMethodCall);
  }

  Future<dynamic> _onMethodCall(MethodCall call) async {
    switch (call.method) {
      case 'onLogReceived':
        final arguments = call.arguments as List;
        _onLogReceived(
          arguments[0] as String,
          LogLevel.values[arguments[1] as int],
        );
        return;
    }
  }

  Future<void> call(String number) => channel.invokeMethod('FIL.call', number);

  void _onLogReceived(String message, LogLevel level) =>
      _app.logger?.call(message, level);
}
