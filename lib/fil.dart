import 'dart:async';

import 'package:flutter/services.dart';

import 'audio/audio_manager.dart';
import 'call/call_actions.dart';
import 'call/calls.dart';
import 'configuration/application_setup.dart';
import 'events/event.dart';
import 'logging/log_level.dart';
import 'push/remote_message.dart';

class Fil {
  /// For internal use only.
  static const MethodChannel channel =
      MethodChannel('voip_flutter_integration');

  static Fil _instance;

  static Fil get instance => _instance;

  final ApplicationSetup _app;

  final CallActions actions = CallActions();

  final Calls calls = Calls();

  final AudioManager audio = AudioManager();

  // True if we added a listener to the EventsManager on the Kotlin side. We
  // only need one listener there, and propagate the events to all listeners
  // here.
  bool _addedListenerToPil = false;

  StreamController<Event> _eventsController;

  // This is a type of `EventManager` in the PIL. Since it's nicer to
  // use Streams in Dart, and no future functionality in that class
  // is expected, this is a Stream on the Dart side.
  Stream<Event> get events => _eventsController.stream;

  Fil(this._app) {
    if (instance == null) {
      _instance = this;
    } else {
      throw StateError('Only one instance of the Fil is supported.');
    }

    channel.setMethodCallHandler(_onMethodCall);

    _eventsController = StreamController.broadcast(
      onListen: () async {
        if (!_addedListenerToPil) {
          _addedListenerToPil = true;
          await channel.invokeMethod('EventsManager.listen');
        }
      },
      onCancel: () async {
        if (_addedListenerToPil && !_eventsController.hasListener) {
          _addedListenerToPil = false;
          await channel.invokeMethod('EventsManager.stopListening');
        }
      },
    );
  }

  Future<dynamic> _onMethodCall(MethodCall call) async {
    switch (call.method) {
      case 'onLogReceived':
        final arguments = call.arguments as List;
        _onLogReceived(
          arguments[0] as String,
          LogLevel.fromJson(arguments[1] as String),
        );
        return;
      case 'onEvent':
        final argument = (call.arguments as Map).cast<String, dynamic>();
        _onEvent(Event.fromJson(argument));
        return;
      case 'Middleware.respond':
        final arguments = call.arguments as List;
        _app.middleware.respond(
          RemoteMessage.fromMap(arguments[0] as Map),
          arguments[1] as bool,
        );
        return;
      case 'Middleware.tokenReceived':
        final argument = call.arguments as String;
        _app.middleware.tokenReceived(argument);
        return;
    }
  }

  Future<void> call(String number) => channel.invokeMethod('FIL.call', number);

  void _onLogReceived(String message, LogLevel level) =>
      _app.logger?.call(message, level);

  void _onEvent(Event event) => _eventsController.add(event);
}
