import 'dart:async';

import 'package:flutter/services.dart';

import 'audio/audio_manager.dart';
import 'call/call_actions.dart';
import 'call/calls.dart';
import 'events/event.dart';

class PhoneLib {
  /// For internal use only.
  static const MethodChannel channel =
      MethodChannel('org.openvoipalliance.flutterphonelib/foreground');

  /// For internal use only.
  static const MethodChannel backgroundChannel =
      MethodChannel('org.openvoipalliance.flutterphonelib/background');

  static PhoneLib _instance;

  static PhoneLib get instance => _instance;

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

  PhoneLib() {
    if (instance == null) {
      _instance = this;
    } else {
      throw StateError('Only one instance of the PhoneLib is supported.');
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
      case 'onEvent':
        final argument = (call.arguments as Map).castRecursively();
        _onEvent(Event.fromJson(argument));
        return;
    }
  }

  Future<void> call(String number) =>
      channel.invokeMethod('PhoneLib.call', number);

  void _onEvent(Event event) => _eventsController.add(event);
}

extension _CastRecursive on Map {
  Map<String, dynamic> castRecursively([List<Map> cache]) {
    // The cache is used to keep track of references to maps that have
    // already been cast. This is to prevent stack overflows.
    cache ??= [];

    cache.add(this);

    for (final key in keys) {
      if (this[key] is Map && !cache.any((m) => identical(m, this[key]))) {
        this[key] = (this[key] as Map).castRecursively(cache);
      }
    }

    return cast<String, dynamic>();
  }
}
