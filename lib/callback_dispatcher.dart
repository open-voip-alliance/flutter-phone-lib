import 'dart:async';
import 'dart:ui';

import 'package:flutter/widgets.dart';

import 'logging/log_level.dart';
import 'phone_lib.dart';
import 'push/remote_message.dart';

void callbackDispatcher() async {
  await WidgetsFlutterBinding.ensureInitialized();
  final stayAliveCompleter = Completer();

  var initialized = false;

  PhoneLib.backgroundChannel.setMethodCallHandler((call) async {
    final arguments = call.arguments as List;

    if (!initialized) {
      final initializeResources = PluginUtilities.getCallbackFromHandle(
        CallbackHandle.fromRawHandle(arguments[0] as int),
      ) as Future<void> Function();
      await initializeResources();
      initialized = true;
    }

    final callback = PluginUtilities.getCallbackFromHandle(
      CallbackHandle.fromRawHandle(arguments[1] as int),
    );

    switch (call.method) {
      case 'onLogReceived':
        final onLogReceived = callback as void Function(LogLevel, String);
        final logs = arguments[2] as List;

        for (var log in logs) {
          final level = LogLevel.fromJson(log[0] as String);
          final message = log[1] as String;

          onLogReceived(level, message);
        }

        return;
      case 'Middleware.respond':
        final respond = callback as void Function(RemoteMessage, bool);
        final remoteMessage = RemoteMessage.fromMap(arguments[2] as Map);
        final available = arguments[3] as bool;

        respond(remoteMessage, available);
        return;
      case 'Middleware.tokenReceived':
        final tokenReceived = callback as void Function(String);
        final token = arguments[2] as String;

        tokenReceived(token);
        return;
    }
  });
  print(
    'FlutterPhoneLib: '
    'Notifying that the callback dispatcher is ready '
    'to receive method calls',
  );
  PhoneLib.backgroundChannel.invokeMethod('callbackDispatcherIsInitialized');
  await stayAliveCompleter.future;
}
