import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_phone_lib/flutter_phone_lib.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'middleware.dart';
import 'voipgrid.dart';

class Phone extends ChangeNotifier {
  Phone._();

  static final Phone instance = Phone._();

  late final SharedPreferences _storage;

  late final Voipgrid voipgrid;

  late final Middleware middleware;

  PhoneLib? _phoneLib;

  PhoneLib get phoneLib => _phoneLib!;

  bool _running = false;

  bool get isRunning => _running;

  String? _linphoneVersion;

  String? get linphoneVersion => _linphoneVersion;

  final _eventsController = StreamController<Event>.broadcast();

  Stream<Event> get events => _eventsController.stream;

  String get username => _storage.getString('username') ?? '';
  String get password => _storage.getString('password') ?? '';
  String get domain => _storage.getString('domain') ?? '';
  int get port => _storage.getInt('port') ?? 0;
  bool get secure => _storage.getBool('secure') ?? true;

  bool get useApplicationProvidedRingtone =>
      _storage.getBool('use_application_provided_ringtone') ?? false;

  bool get showCallsInNativeRecents =>
      _storage.getBool('show_calls_in_native_recents') ?? true;

  bool get enableAdvancedLogging =>
      _storage.getBool('enable_advanced_logging') ?? false;

  bool get hasValidCredentials =>
      username.isNotEmpty &&
      password.isNotEmpty &&
      domain.isNotEmpty &&
      port != 0;

  Auth get _auth => Auth(
        username: username,
        password: password,
        domain: domain,
        port: port,
        secure: secure,
      );

  Preferences get _preferences => Preferences.standard.copyWith(
        useApplicationProvidedRingtone: useApplicationProvidedRingtone,
        showCallsInNativeRecents: showCallsInNativeRecents,
        enableAdvancedLogging: enableAdvancedLogging,
      );

  Future<void> load() async {
    _storage = await SharedPreferences.getInstance();
    voipgrid = Voipgrid(_storage);
    middleware = Middleware(_storage, voipgrid);

    if (kDebugMode && username.isEmpty) await _prefillCredentials();
  }

  /// Seeds the stored credentials from .env, see .env.example.
  Future<void> _prefillCredentials() async {
    await dotenv.load();

    final username = dotenv.env['VOIP_ACCOUNT_ID'] ?? '';

    if (username.isEmpty) {
      debugPrint(
        'No SIP credentials saved. To pre-fill them in debug builds, set '
        'VOIP_ACCOUNT_ID and VOIP_ACCOUNT_PASSWORD in .env '
        '(see .env.example).',
      );
      return;
    }

    await saveCredentials(
      username: username,
      password: dotenv.env['VOIP_ACCOUNT_PASSWORD'] ?? '',
      domain: dotenv.env['SIP_DOMAIN'] ?? '',
      port: int.tryParse(dotenv.env['SIP_PORT'] ?? '') ?? 0,
      secure: secure,
    );
    await voipgrid.saveLogin(
      username: dotenv.env['VOIPGRID_USERNAME'] ?? '',
      password: dotenv.env['VOIPGRID_PASSWORD'] ?? '',
    );
  }

  Future<void> saveCredentials({
    required String username,
    required String password,
    required String domain,
    required int port,
    required bool secure,
  }) async {
    await _storage.setString('username', username);
    await _storage.setString('password', password);
    await _storage.setString('domain', domain);
    await _storage.setInt('port', port);
    await _storage.setBool('secure', secure);
    notifyListeners();
  }

  Future<void> setUseApplicationProvidedRingtone(bool value) async {
    await _storage.setBool('use_application_provided_ringtone', value);
    await _phoneLib?.updatePreferences(_preferences);
    notifyListeners();
  }

  Future<void> setShowCallsInNativeRecents(bool value) async {
    await _storage.setBool('show_calls_in_native_recents', value);
    await _phoneLib?.updatePreferences(_preferences);
    notifyListeners();
  }

  Future<void> setEnableAdvancedLogging(bool value) async {
    await _storage.setBool('enable_advanced_logging', value);
    await _phoneLib?.updatePreferences(_preferences);
    notifyListeners();
  }

  Future<bool> start() async {
    if (!hasValidCredentials) return false;

    if (_phoneLib == null) {
      final phoneLib = await initializePhoneLib((builder) {
        builder
          ..preferences = _preferences
          ..auth = _auth;

        return const ApplicationSetup(
          userAgent: 'Flutter Phone Lib Example',
        );
      });

      _phoneLib = phoneLib;
      _eventsController.addStream(phoneLib.events);
    }

    await _phoneLib!.start(_preferences, _auth);
    _running = true;
    _linphoneVersion = await _phoneLib!.linphoneVersion;
    notifyListeners();

    unawaited(registerWithMiddleware());

    return true;
  }

  /// Logs in to VoIPGRID if needed and registers for incoming call pushes.
  /// Failures are only logged; the app is usable for outgoing calls without.
  Future<void> registerWithMiddleware() async {
    if (!voipgrid.hasLogin) return;

    try {
      if (!voipgrid.isLoggedIn) await voipgrid.login();
      await middleware.register(sipUserId: username);
    } on Exception catch (e) {
      debugPrint('Middleware registration skipped: $e');
    }
  }

  Future<void> stop() async {
    await _phoneLib?.stop();
    _running = false;
    notifyListeners();
  }
}
