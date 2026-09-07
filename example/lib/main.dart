import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_phone_lib/flutter_phone_lib.dart';

import 'src/pages/call_page.dart';
import 'src/pages/dialer_page.dart';
import 'src/pages/incoming_call_page.dart';
import 'src/pages/settings_page.dart';
import 'src/phone.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Phone.instance.load();

  unawaited(
    Phone.instance
        .start()
        .catchError((Object e) => debugPrint('Failed to start: $e')),
  );

  runApp(const ExampleApp());
}

class ExampleApp extends StatelessWidget {
  const ExampleApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Phone Lib Example',
      theme: ThemeData(colorSchemeSeed: Colors.green),
      home: const HomePage(),
    );
  }
}

enum _CallUi { incoming, active }

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var _selectedTab = 0;

  _CallUi? _callUi;

  StreamSubscription<Event>? _eventsSubscription;

  @override
  void initState() {
    super.initState();
    _eventsSubscription = Phone.instance.events.listen(_onEvent);
  }

  @override
  void dispose() {
    _eventsSubscription?.cancel();
    super.dispose();
  }

  void _onEvent(Event event) {
    if (event is IncomingCallReceived && _callUi == null) {
      _callUi = _CallUi.incoming;
      Navigator.push(
        context,
        MaterialPageRoute<void>(builder: (_) => const IncomingCallPage()),
      );
    } else if (event is OutgoingCallStarted && _callUi == null) {
      _callUi = _CallUi.active;
      Navigator.push(
        context,
        MaterialPageRoute<void>(builder: (_) => const CallPage()),
      );
    } else if (event is CallConnected && _callUi == _CallUi.incoming) {
      _callUi = _CallUi.active;
      Navigator.pushReplacement(
        context,
        MaterialPageRoute<void>(builder: (_) => const CallPage()),
      );
    } else if (event is CallEnded && _callUi != null) {
      _callUi = null;
      Navigator.popUntil(context, (route) => route.isFirst);
    } else if (event is CallSetupFailedEvent) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Call setup failed: ${event.reason.name}')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_selectedTab == 0 ? 'Dialer' : 'Settings'),
      ),
      body: IndexedStack(
        index: _selectedTab,
        children: const [
          DialerPage(),
          SettingsPage(),
        ],
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _selectedTab,
        onDestinationSelected: (index) => setState(() => _selectedTab = index),
        destinations: const [
          NavigationDestination(icon: Icon(Icons.dialpad), label: 'Dialer'),
          NavigationDestination(icon: Icon(Icons.settings), label: 'Settings'),
        ],
      ),
    );
  }
}
