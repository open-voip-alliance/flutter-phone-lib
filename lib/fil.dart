import 'dart:async';

import 'package:flutter/services.dart';

import 'call/call_actions.dart';
import 'call/fil_call.dart';
import 'configuration/application_setup.dart';
import 'events/event.dart';
import 'logging/log_level.dart';

class Fil {
  /// For internal use only.
  static const MethodChannel channel =
      MethodChannel('voip_flutter_integration');

  static Fil _instance;

  static Fil get instance => _instance;

  final ApplicationSetup _app;

  final CallActions actions = CallActions();

  // True if we added a listener to the EventsManager on the Kotlin side. We
  // only need one listener there, and propagate the events to all listeners
  // here.
  bool _addedListenerToPil = false;

  StreamController<Event> _eventsController;

  // This is a type of `EventManager` in the PIL. Since it's nicer to
  // use Streams in Dart, and no future functionality in that class
  // is expected, this is a Stream on the Dart side.
  Stream<Event> get events => _eventsController.stream;

  // Is `call` in the PIL. Can't be named that here, because Dart does not
  // support having 2 identifiers with the same name if they're different
  // (method vs getter), unlike Kotlin.
  Future<FilCall> get currentCall => channel.invokeMethod('FIL.getCall').then(
        (map) => FilCall.fromJson((map as Map)?.cast<String, dynamic>()),
      );

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
          LogLevel.values[arguments[1] as int],
        );
        return;
      case 'onEvent':
        final argument = call.arguments as String;
        _onEvent(Event.fromJson(argument));
        return;
    }
  }

  Future<void> call(String number) => channel.invokeMethod('FIL.call', number);

  void _onLogReceived(String message, LogLevel level) =>
      _app.logger?.call(message, level);

  void _onEvent(Event event) => _eventsController.add(event);
}
