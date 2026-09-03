import 'dart:io';

import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

import '../phone.dart';
import '../widgets/keypad.dart';

class DialerPage extends StatefulWidget {
  const DialerPage({super.key});

  @override
  State<DialerPage> createState() => _DialerPageState();
}

class _DialerPageState extends State<DialerPage> {
  final _phone = Phone.instance;

  var _digits = '';

  void _onKeyPressed(String key) {
    if (_phone.isRunning) {
      _phone.phoneLib.playToneLocally(key);
    }

    setState(() => _digits += key);
  }

  void _backspace() {
    if (_digits.isEmpty) return;

    setState(() => _digits = _digits.substring(0, _digits.length - 1));
  }

  Future<void> _call() async {
    if (_digits.isEmpty) return;

    if (!_phone.isRunning) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Configure your SIP credentials in Settings first.'),
        ),
      );
      return;
    }

    if (!await _requestCallingPermissions()) return;

    await _phone.phoneLib.call(_digits);
  }

  Future<bool> _requestCallingPermissions() async {
    final permissions = Platform.isAndroid
        ? [
            Permission.microphone,
            Permission.phone,
            Permission.bluetoothConnect,
            Permission.contacts,
          ]
        : [Permission.microphone];

    final statuses = await permissions.request();

    return statuses[Permission.microphone]?.isGranted ?? false;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListenableBuilder(
          listenable: _phone,
          builder: (context, _) => _phone.isRunning
              ? const SizedBox.shrink()
              : const Padding(
                  padding: EdgeInsets.all(16),
                  child: Text(
                    'Not started, configure your SIP credentials in Settings.',
                    textAlign: TextAlign.center,
                  ),
                ),
        ),
        Expanded(
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    children: [
                      const SizedBox(width: 64),
                      Expanded(
                        child: Text(
                          _digits,
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.headlineMedium,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      SizedBox(
                        width: 64,
                        child: _digits.isEmpty
                            ? null
                            : GestureDetector(
                                onLongPress: () => setState(() => _digits = ''),
                                child: IconButton(
                                  icon: const Icon(Icons.backspace_outlined),
                                  onPressed: _backspace,
                                ),
                              ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Keypad(onKeyPressed: _onKeyPressed),
                  const SizedBox(height: 24),
                  FloatingActionButton(
                    onPressed: _call,
                    backgroundColor: Colors.green,
                    foregroundColor: Colors.white,
                    child: const Icon(Icons.phone),
                  ),
                  const SizedBox(height: 16),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
