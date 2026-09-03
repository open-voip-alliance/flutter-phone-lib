import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_phone_lib/flutter_phone_lib.dart';
import 'package:permission_handler/permission_handler.dart';

import '../phone.dart';

class IncomingCallPage extends StatefulWidget {
  const IncomingCallPage({super.key});

  @override
  State<IncomingCallPage> createState() => _IncomingCallPageState();
}

class _IncomingCallPageState extends State<IncomingCallPage> {
  final _phone = Phone.instance;

  Call? _call;

  StreamSubscription<Event>? _eventsSubscription;

  @override
  void initState() {
    super.initState();

    _eventsSubscription = _phone.events.listen(_onEvent);

    _phone.phoneLib.sessionState.then((state) {
      if (mounted) setState(() => _call = state.activeCall);
    });
  }

  @override
  void dispose() {
    _eventsSubscription?.cancel();
    super.dispose();
  }

  void _onEvent(Event event) {
    if (event is CallSessionEvent && event.state?.activeCall != null) {
      setState(() => _call = event.state!.activeCall);
    }
  }

  Future<void> _answer() async {
    if (Platform.isAndroid || Platform.isIOS) {
      final status = await Permission.microphone.request();
      if (!status.isGranted) return;
    }

    await _phone.phoneLib.actions.answer();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
        body: SafeArea(
          child: Column(
            children: [
              const Spacer(),
              Text(
                'Incoming call',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: 16),
              Text(
                _call?.remotePartyHeading ?? '',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              Text(_call?.remotePartySubheading ?? ''),
              const Spacer(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  FloatingActionButton.large(
                    heroTag: 'decline',
                    onPressed: () => _phone.phoneLib.actions.decline(),
                    backgroundColor: Colors.red,
                    foregroundColor: Colors.white,
                    child: const Icon(Icons.call_end),
                  ),
                  FloatingActionButton.large(
                    heroTag: 'answer',
                    onPressed: _answer,
                    backgroundColor: Colors.green,
                    foregroundColor: Colors.white,
                    child: const Icon(Icons.phone),
                  ),
                ],
              ),
              const SizedBox(height: 48),
            ],
          ),
        ),
      ),
    );
  }
}
