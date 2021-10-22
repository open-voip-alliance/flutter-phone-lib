import 'dart:async';
import 'dart:ui';

import 'package:flutter/widgets.dart';

import 'phone_lib.dart';
import 'push/remote_message.dart';

void callbackDispatcher() async {
  await WidgetsFlutterBinding.ensureInitialized();
  final stayAliveCompleter = Completer();

  var initializing = false;
  final initializeCompleter = Completer();

  PhoneLib.backgroundChannel.setMethodCallHandler((call) async {
    final arguments = call.arguments as List;

    if (!initializing && !initializeCompleter.isCompleted) {
      initializing = true;

      final initializeResources = PluginUtilities.getCallbackFromHandle(
        CallbackHandle.fromRawHandle(arguments[0] as int),
      ) as Future<void> Function();
      await initializeResources();
      initializing = false;
      initializeCompleter.complete();
    } else if (initializing) {
      await initializeCompleter.future;
    }

    final callback = PluginUtilities.getCallbackFromHandle(
      CallbackHandle.fromRawHandle(arguments[1] as int),
    );

    switch (call.method) {
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
      case 'Middleware.inspect':
        final inspect = callback as void Function(RemoteMessage);
        final remoteMessage = RemoteMessage.fromMap(arguments[2] as Map);

        return inspect(remoteMessage);
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
