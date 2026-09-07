import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_phone_lib/flutter_phone_lib.dart';

import '../phone.dart';
import '../widgets/keypad.dart';

class CallPage extends StatefulWidget {
  const CallPage({super.key});

  @override
  State<CallPage> createState() => _CallPageState();
}

class _CallPageState extends State<CallPage> {
  final _phone = Phone.instance;

  CallSessionState? _sessionState;
  String? _eventStatus;

  StreamSubscription<Event>? _eventsSubscription;

  Call? get _activeCall => _sessionState?.activeCall;
  Call? get _inactiveCall => _sessionState?.inactiveCall;
  AudioState? get _audioState => _sessionState?.audioState;

  @override
  void initState() {
    super.initState();

    _eventsSubscription = _phone.events.listen(_onEvent);

    _phone.phoneLib.sessionState.then((state) {
      if (mounted) setState(() => _sessionState = state);
    });
  }

  @override
  void dispose() {
    _eventsSubscription?.cancel();
    super.dispose();
  }

  void _onEvent(Event event) {
    if (event is CallSessionEvent && event.state != null) {
      setState(() => _sessionState = event.state);
    }

    final status = switch (event) {
      CallConnected() => 'Call connected',
      AttendedTransferStarted() => 'Transfer started',
      AttendedTransferConnected() => 'Transfer connected',
      AttendedTransferAborted() => 'Transfer aborted',
      _ => null,
    };

    if (status != null) {
      setState(() => _eventStatus = status);
    }

    if (event is AttendedTransferEnded) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Call transfer complete!')),
      );
    }
  }

  Future<void> _routeAudioToBluetooth() async {
    final bluetoothRoutes = _audioState?.bluetoothRoutes.toList() ?? [];

    if (bluetoothRoutes.length > 1) {
      final route = await showModalBottomSheet<BluetoothAudioRoute>(
        context: context,
        builder: (context) => SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              for (final route in bluetoothRoutes)
                ListTile(
                  leading: const Icon(Icons.bluetooth),
                  title: Text(route.displayName),
                  onTap: () => Navigator.pop(context, route),
                ),
            ],
          ),
        ),
      );

      if (route != null) {
        await _phone.phoneLib.audio.routeAudioToBluetoothDevice(route);
      }

      return;
    }

    await _phone.phoneLib.audio.routeAudio(AudioRoute.bluetooth);
  }

  Future<void> _transfer() async {
    if (_inactiveCall != null) {
      await _phone.phoneLib.actions.completeAttendedTransfer();
      return;
    }

    await _phone.phoneLib.actions.hold();

    final number = await showDialog<String>(
      context: context,
      builder: (context) => const _TransferNumberDialog(),
    );

    if (number != null && number.isNotEmpty) {
      await _phone.phoneLib.actions.beginAttendedTransfer(number);
    }
  }

  void _showDtmfKeypad() {
    var sent = '';

    showModalBottomSheet<void>(
      context: context,
      builder: (context) => SafeArea(
        child: StatefulBuilder(
          builder: (context, setSheetState) => Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 16),
              Text(
                sent.isEmpty ? 'Send DTMF' : sent,
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              const SizedBox(height: 8),
              Keypad(
                onKeyPressed: (key) {
                  _phone.phoneLib.actions.sendDtmf(key);
                  setSheetState(() => sent += key);
                },
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final call = _activeCall;
    final audioState = _audioState;

    return PopScope(
      canPop: false,
      child: Scaffold(
        body: SafeArea(
          child: call == null
              ? const Center(child: CircularProgressIndicator())
              : Column(
                  children: [
                    const Spacer(),
                    Text(
                      call.remotePartyHeading,
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                    Text(call.remotePartySubheading),
                    const SizedBox(height: 8),
                    Text(
                      call.prettyDuration,
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    Text(call.state.name),
                    if (_eventStatus != null) ...[
                      const SizedBox(height: 8),
                      Text(
                        _eventStatus!,
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ],
                    if (_inactiveCall != null) ...[
                      const SizedBox(height: 8),
                      Text(
                        'Transferring to: '
                        '${_inactiveCall!.remotePartyHeading} '
                        '${_inactiveCall!.remotePartySubheading}',
                      ),
                    ],
                    const Spacer(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        _CallActionButton(
                          icon: audioState?.isMicrophoneMuted ?? false
                              ? Icons.mic_off
                              : Icons.mic,
                          label: audioState?.isMicrophoneMuted ?? false
                              ? 'Unmute'
                              : 'Mute',
                          selected: audioState?.isMicrophoneMuted ?? false,
                          onPressed: () => _phone.phoneLib.audio.toggleMute(),
                        ),
                        _CallActionButton(
                          icon: Icons.pause,
                          label: call.isOnHold ? 'Unhold' : 'Hold',
                          selected: call.isOnHold,
                          onPressed: () => _phone.phoneLib.actions.toggleHold(),
                        ),
                        _CallActionButton(
                          icon: Icons.dialpad,
                          label: 'Keypad',
                          onPressed: _showDtmfKeypad,
                        ),
                        _CallActionButton(
                          icon: _inactiveCall != null
                              ? Icons.call_merge
                              : Icons.phone_forwarded,
                          label: _inactiveCall != null ? 'Merge' : 'Transfer',
                          onPressed: _transfer,
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        _CallActionButton(
                          icon: Icons.phone_in_talk,
                          label: 'Earpiece',
                          selected:
                              audioState?.currentRoute == AudioRoute.phone,
                          onPressed: audioState?.availableRoutes
                                      .contains(AudioRoute.phone) ??
                                  false
                              ? () => _phone.phoneLib.audio
                                  .routeAudio(AudioRoute.phone)
                              : null,
                        ),
                        _CallActionButton(
                          icon: Icons.volume_up,
                          label: 'Speaker',
                          selected:
                              audioState?.currentRoute == AudioRoute.speaker,
                          onPressed: audioState?.availableRoutes
                                      .contains(AudioRoute.speaker) ??
                                  false
                              ? () => _phone.phoneLib.audio
                                  .routeAudio(AudioRoute.speaker)
                              : null,
                        ),
                        _CallActionButton(
                          icon: Icons.bluetooth,
                          label: audioState?.bluetoothDeviceName ?? 'Bluetooth',
                          selected:
                              audioState?.currentRoute == AudioRoute.bluetooth,
                          onPressed: audioState?.availableRoutes
                                      .contains(AudioRoute.bluetooth) ??
                                  false
                              ? _routeAudioToBluetooth
                              : null,
                        ),
                      ],
                    ),
                    const SizedBox(height: 32),
                    FloatingActionButton(
                      onPressed: () => _phone.phoneLib.actions.end(),
                      backgroundColor: Colors.red,
                      foregroundColor: Colors.white,
                      child: const Icon(Icons.call_end),
                    ),
                    const SizedBox(height: 32),
                  ],
                ),
        ),
      ),
    );
  }
}

class _CallActionButton extends StatelessWidget {
  const _CallActionButton({
    required this.icon,
    required this.label,
    this.selected = false,
    this.onPressed,
  });

  final IconData icon;
  final String label;
  final bool selected;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 88,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton.filledTonal(
            isSelected: selected,
            iconSize: 28,
            onPressed: onPressed,
            icon: Icon(icon),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.bodySmall,
          ),
        ],
      ),
    );
  }
}

class _TransferNumberDialog extends StatefulWidget {
  const _TransferNumberDialog();

  @override
  State<_TransferNumberDialog> createState() => _TransferNumberDialogState();
}

class _TransferNumberDialogState extends State<_TransferNumberDialog> {
  final _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Call Transfer'),
      content: TextField(
        controller: _controller,
        autofocus: true,
        keyboardType: TextInputType.phone,
        decoration: const InputDecoration(
          hintText: 'Enter the number to transfer to',
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: () => Navigator.pop(context, _controller.text),
          child: const Text('Transfer'),
        ),
      ],
    );
  }
}
