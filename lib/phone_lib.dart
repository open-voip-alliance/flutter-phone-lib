import 'dart:async';

import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

import 'audio/audio_manager.dart';
import 'call/call_actions.dart';
import 'call/calls.dart';
import 'call_session_state.dart';
import 'configuration/auth.dart';
import 'configuration/preferences.dart';
import 'events/event.dart';
import 'util/cast_recursive.dart';

// ignore: prefer_mixin
class PhoneLib with WidgetsBindingObserver {
  /// For internal use only.
  static const MethodChannel channel =
      MethodChannel('org.openvoipalliance.flutterphonelib/foreground');

  /// For internal use only.
  static const MethodChannel backgroundChannel =
      MethodChannel('org.openvoipalliance.flutterphonelib/background');

  static PhoneLib? _instance;

  static PhoneLib get instance => _instance!;

  final CallActions actions = CallActions();

  final Calls calls = Calls();

  final AudioManager audio = AudioManager();

  final void Function()? _onMissedCallNotificationPressed;

  // True if we added a listener to the EventsManager on the Kotlin side. We
  // only need one listener there, and propagate the events to all listeners
  // here.
  bool _addedListenerToPil = false;

  late StreamController<Event> _eventsController;

  // This is a type of `EventManager` in the PIL. Since it's nicer to
  // use Streams in Dart, and no future functionality in that class
  // is expected, this is a Stream on the Dart side.
  Stream<Event> get events => _eventsController.stream;

  PhoneLib(this._onMissedCallNotificationPressed) {
    if (_instance == null) {
      _instance = this;
    } else {
      throw StateError('Only one instance of the PhoneLib is supported.');
    }

    WidgetsBinding.instance.addObserver(this);

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
      case 'onEvent':
        final argument = (call.arguments as Map).castRecursively();
        _onEvent(Event.fromJson(argument));
        return;
      case 'onMissedCallNotificationPressed':
        _onMissedCallNotificationPressed?.call();
        return;
    }
  }

  Future<void> start(Preferences preferences, Auth auth) =>
      channel.invokeMethod('PhoneLib.start', [
        preferences.toJson(),
        auth.toJson(),
      ]);

  Future<void> stop() => channel.invokeMethod('PhoneLib.stop');

  /// Closes this [PhoneLib] instance for good. As opposed to [stop], [start]
  /// should not be called again, instead you should create a new instance.
  ///
  /// You don't need to call [stop] before closing, it's handled here.
  Future<void> close() async {
    await stop();
    WidgetsBinding.instance.removeObserver(this);
    channel.setMethodCallHandler(null);
    _instance = null;
  }

  Future<void> updatePreferences(Preferences preferences) =>
      channel.invokeMethod('PhoneLib.updatePreferences', [
        preferences.toJson(),
      ]);

  Future<void> call(String number) =>
      channel.invokeMethod('PhoneLib.call', number);

  Future<CallSessionState> get sessionState async => CallSessionState.fromJson(
        await channel
            .invokeMethod('PhoneLib.sessionState')
            .then((v) => (v as Map).cast()),
      );

  void _onEvent(Event event) => _eventsController.add(event);
}
