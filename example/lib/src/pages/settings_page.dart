import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../phone.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  final _phone = Phone.instance;

  late final _username = TextEditingController(text: _phone.username);
  late final _password = TextEditingController(text: _phone.password);
  late final _domain = TextEditingController(text: _phone.domain);
  late final _port = TextEditingController(
    text: _phone.port == 0 ? '' : '${_phone.port}',
  );
  late var _secure = _phone.secure;

  late final _voipgridUsername =
      TextEditingController(text: _phone.voipgrid.username);
  late final _voipgridPassword =
      TextEditingController(text: _phone.voipgrid.password);

  var _applying = false;
  var _loggingIn = false;
  var _registering = false;

  final _voipSection = GlobalKey();
  final _voipgridSection = GlobalKey();
  final _middlewareSection = GlobalKey();

  void _scrollTo(GlobalKey section) {
    final context = section.currentContext;
    if (context == null) return;

    Scrollable.ensureVisible(
      context,
      duration: const Duration(milliseconds: 300),
      alignment: 0,
    );
  }

  @override
  void initState() {
    super.initState();
    _phone.middleware.refresh();
  }

  @override
  void dispose() {
    _username.dispose();
    _password.dispose();
    _domain.dispose();
    _port.dispose();
    _voipgridUsername.dispose();
    _voipgridPassword.dispose();
    super.dispose();
  }

  Future<void> _login() async {
    setState(() => _loggingIn = true);

    try {
      await _phone.voipgrid.saveLogin(
        username: _voipgridUsername.text.trim(),
        password: _voipgridPassword.text,
      );
      await _phone.voipgrid.login();
    } on Exception catch (e) {
      _showSnackBar('$e');
    } finally {
      if (mounted) setState(() => _loggingIn = false);
    }
  }

  Future<void> _register() => _withMiddleware(
        () => _phone.middleware.register(sipUserId: _phone.username),
      );

  Future<void> _unregister() => _withMiddleware(
        () => _phone.middleware.unregister(sipUserId: _phone.username),
      );

  Future<void> _withMiddleware(Future<void> Function() action) async {
    setState(() => _registering = true);

    try {
      await action();
    } on Exception catch (e) {
      _showSnackBar('$e');
    } finally {
      if (mounted) setState(() => _registering = false);
    }
  }

  Future<void> _logout() => _phone.voipgrid.logout();

  Future<void> _stop() => _phone.stop();

  Future<void> _saveAndApply() async {
    setState(() => _applying = true);

    try {
      await _phone.saveCredentials(
        username: _username.text.trim(),
        password: _password.text,
        domain: _domain.text.trim(),
        port: int.tryParse(_port.text.trim()) ?? 0,
        secure: _secure,
      );

      final started = await _phone.start();

      if (!started) {
        _showSnackBar('Credentials are incomplete, phone lib not started.');
      }
    } on Exception catch (e) {
      _showSnackBar('Failed to start: $e');
    } finally {
      if (mounted) setState(() => _applying = false);
    }
  }

  void _showSnackBar(String message) {
    if (!mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  @override
  Widget build(BuildContext context) {
    final voipgrid = _phone.voipgrid;
    final middleware = _phone.middleware;

    return ListenableBuilder(
      listenable: Listenable.merge([_phone, voipgrid, middleware]),
      builder: (context, _) => Column(
        children: [
          _StatusBar(
            items: [
              _Status(
                'Phone lib',
                onTap: () => _scrollTo(_voipSection),
                _phone.isRunning,
                'Running',
                'Not running',
              ),
              _Status(
                'VoIPGRID',
                onTap: () => _scrollTo(_voipgridSection),
                voipgrid.isLoggedIn,
                'Logged in',
                'Not logged in',
              ),
              _Status(
                'Middleware',
                onTap: () => _scrollTo(_middlewareSection),
                middleware.isRegistered,
                'Registered',
                'Not registered',
              ),
            ],
          ),
          const Divider(height: 1),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    'VoIP authentication',
                    key: _voipSection,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(height: 8),
                  if (kDebugMode && _phone.username.isEmpty) ...[
                    Card(
                      child: Padding(
                        padding: const EdgeInsets.all(12),
                        child: Text(
                          'Tip: debug builds can pre-fill these fields from the '
                          '.env file, see .env.example.',
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                  ],
                  TextField(
                    controller: _username,
                    decoration: const InputDecoration(labelText: 'Username'),
                  ),
                  TextField(
                    controller: _password,
                    obscureText: true,
                    decoration: const InputDecoration(labelText: 'Password'),
                  ),
                  TextField(
                    controller: _domain,
                    keyboardType: TextInputType.url,
                    decoration: const InputDecoration(labelText: 'Domain'),
                  ),
                  TextField(
                    controller: _port,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(labelText: 'Port'),
                  ),
                  SwitchListTile(
                    contentPadding: EdgeInsets.zero,
                    title: const Text('Encryption (TLS)'),
                    value: _secure,
                    onChanged: (value) => setState(() => _secure = value),
                  ),
                  const SizedBox(height: 8),
                  _Actions(
                    busy: _applying,
                    primaryLabel: 'Start',
                    onPrimary: _saveAndApply,
                    secondaryLabel: 'Stop',
                    onSecondary: _phone.isRunning ? _stop : null,
                  ),
                  const Divider(height: 32),
                  Text(
                    'VoIPGRID authentication',
                    key: _voipgridSection,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(height: 8),
                  TextField(
                    controller: _voipgridUsername,
                    keyboardType: TextInputType.emailAddress,
                    decoration: const InputDecoration(labelText: 'Email'),
                  ),
                  TextField(
                    controller: _voipgridPassword,
                    obscureText: true,
                    decoration: const InputDecoration(labelText: 'Password'),
                  ),
                  const SizedBox(height: 8),
                  _Actions(
                    busy: _loggingIn,
                    primaryLabel: 'Log in',
                    onPrimary: _login,
                    secondaryLabel: 'Log out',
                    onSecondary: voipgrid.isLoggedIn ? _logout : null,
                  ),
                  const Divider(height: 32),
                  Text(
                    'Middleware registration',
                    key: _middlewareSection,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  ListTile(
                    contentPadding: EdgeInsets.zero,
                    title: const Text('Push token'),
                    subtitle: middleware.pushToken == null
                        ? const Text('Not received yet')
                        : SelectableText(
                            middleware.pushToken!,
                            style: const TextStyle(fontFamily: 'monospace'),
                          ),
                  ),
                  _Actions(
                    busy: _registering,
                    primaryLabel: 'Register',
                    onPrimary: voipgrid.isLoggedIn ? _register : null,
                    secondaryLabel: 'Unregister',
                    onSecondary: middleware.isRegistered ? _unregister : null,
                  ),
                  const Divider(height: 32),
                  Text(
                    'Preferences',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  SwitchListTile(
                    contentPadding: EdgeInsets.zero,
                    title: const Text('Use application provided ringtone'),
                    value: _phone.useApplicationProvidedRingtone,
                    onChanged: (value) =>
                        _phone.setUseApplicationProvidedRingtone(value),
                  ),
                  SwitchListTile(
                    contentPadding: EdgeInsets.zero,
                    title: const Text('Show calls in native recents'),
                    value: _phone.showCallsInNativeRecents,
                    onChanged: (value) =>
                        _phone.setShowCallsInNativeRecents(value),
                  ),
                  SwitchListTile(
                    contentPadding: EdgeInsets.zero,
                    title: const Text('Advanced logging'),
                    value: _phone.enableAdvancedLogging,
                    onChanged: (value) =>
                        _phone.setEnableAdvancedLogging(value),
                  ),
                  const Divider(height: 32),
                  Text(
                    'Advanced',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  ListTile(
                    contentPadding: EdgeInsets.zero,
                    title: const Text('Echo cancellation calibration'),
                    enabled: _phone.isRunning,
                    onTap: () {
                      _phone.phoneLib.performEchoCancellationCalibration();
                      _showSnackBar(
                          'Performing echo cancellation calibration...');
                    },
                  ),
                  const Divider(height: 32),
                  ListTile(
                    contentPadding: EdgeInsets.zero,
                    title: const Text('Linphone version'),
                    subtitle: Text(_phone.linphoneVersion ?? 'Unknown'),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _Actions extends StatelessWidget {
  const _Actions({
    required this.busy,
    required this.primaryLabel,
    required this.onPrimary,
    required this.secondaryLabel,
    required this.onSecondary,
  });

  final bool busy;
  final String primaryLabel;
  final VoidCallback? onPrimary;
  final String secondaryLabel;
  final VoidCallback? onSecondary;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: FilledButton(
            onPressed: busy ? null : onPrimary,
            child: Text(primaryLabel),
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: OutlinedButton(
            onPressed: busy ? null : onSecondary,
            child: Text(secondaryLabel),
          ),
        ),
      ],
    );
  }
}

class _Status {
  const _Status(
    this.title,
    this.active,
    this.activeText,
    this.inactiveText, {
    required this.onTap,
  });

  final String title;
  final bool active;
  final String activeText;
  final String inactiveText;
  final VoidCallback onTap;
}

class _StatusBar extends StatelessWidget {
  const _StatusBar({required this.items});

  final List<_Status> items;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Material(
      color: theme.colorScheme.surfaceContainerLow,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Row(
          children: [
            for (final item in items)
              Expanded(
                child: InkWell(
                  onTap: item.onTap,
                  borderRadius: BorderRadius.circular(8),
                  child: Column(
                    children: [
                      Icon(
                        item.active
                            ? Icons.check_circle
                            : Icons.radio_button_unchecked,
                        size: 20,
                        color: item.active
                            ? Colors.green
                            : theme.colorScheme.outline,
                      ),
                      const SizedBox(height: 4),
                      Text(item.title, style: theme.textTheme.labelMedium),
                      Text(
                        item.active ? item.activeText : item.inactiveText,
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: theme.colorScheme.onSurfaceVariant,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
