import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:package_info_plus/package_info_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'voipgrid.dart';

/// Registers this device with the middleware that wakes it up for incoming
/// calls with a push notification.
///
/// The push token itself is written to storage by the native side, see
/// `ExampleMiddleware` on Android and iOS, which also answers the pushes.
class Middleware extends ChangeNotifier {
  Middleware(this._storage, this._voipgrid);

  static const _baseUrl =
      'https://api.eu-production.holodeck.voys.nl/callwaker';

  final SharedPreferences _storage;
  final Voipgrid _voipgrid;

  String? get pushToken => _storage.getString('push_token');

  String? get registrationToken =>
      _storage.getString('middleware_registration_token');

  bool get isRegistered => registrationToken != null;

  Future<void> register({required String sipUserId}) async {
    // The native side writes the token, so bypass the plugin's cache.
    await _storage.reload();

    final pushToken = this.pushToken;
    if (pushToken == null) {
      throw const MiddlewareException('No push token received yet.');
    }

    if (!_voipgrid.isLoggedIn) {
      throw const MiddlewareException('Not logged in to VoIPGRID.');
    }

    final appAccountId = int.tryParse(sipUserId);
    if (appAccountId == null) {
      throw const MiddlewareException('The SIP username is not an account ID.');
    }

    final packageInfo = await PackageInfo.fromPlatform();

    debugPrint('Registering with the middleware as $appAccountId');

    final response = await _post('register', {
      'platform': Platform.isAndroid ? 'android' : 'ios',
      'app_id': packageInfo.packageName,
      'app_account_id': appAccountId,
      'push_token': pushToken,
      'os_version': _osVersion,
      'app_version': packageInfo.version,
      'installation_id': await _installationId(),
      if (Platform.isIOS) 'is_sandbox': kDebugMode,
    });

    if (response.statusCode < 200 || response.statusCode >= 300) {
      throw MiddlewareException(
        'Middleware registration failed (${response.statusCode}): '
        '${response.body}',
      );
    }

    final body = jsonDecode(response.body) as Map;
    await _storage.setString(
      'middleware_registration_token',
      body['registration_token'] as String,
    );
    debugPrint('Registered with the middleware');
    notifyListeners();
  }

  Future<void> unregister({required String sipUserId}) async {
    final registrationToken = this.registrationToken;
    if (registrationToken == null) return;

    final response = await _post('unregister', {
      'app_account_id': int.tryParse(sipUserId),
      'installation_id': await _installationId(),
      'registration_token': registrationToken,
    });

    if (response.statusCode < 200 || response.statusCode >= 300) {
      throw MiddlewareException(
        'Middleware unregistration failed (${response.statusCode}): '
        '${response.body}',
      );
    }

    await _storage.remove('middleware_registration_token');
    debugPrint('Unregistered from the middleware');
    notifyListeners();
  }

  Future<http.Response> _post(String path, Map<String, dynamic> body) async {
    final url = Uri.parse('$_baseUrl/$path');
    debugPrint('POST $url');

    final response = await http.post(
      url,
      headers: {
        'Authorization': 'Bearer ${_voipgrid.apiToken}',
        'Content-Type': 'application/json',
      },
      body: jsonEncode(body),
    );

    debugPrint('POST $url -> ${response.statusCode}');
    return response;
  }

  /// Just the version number; the middleware rejects long descriptions.
  String get _osVersion =>
      RegExp(r'\d+(\.\d+)*')
          .firstMatch(Platform.operatingSystemVersion)
          ?.group(0) ??
      'unknown';

  /// Identifies this install across registrations; generated once.
  Future<String> _installationId() async {
    final existing = _storage.getString('installation_id');
    if (existing != null) return existing;

    final random = Random.secure();
    final id = List.generate(16, (_) => random.nextInt(256))
        .map((b) => b.toRadixString(16).padLeft(2, '0'))
        .join();

    await _storage.setString('installation_id', id);
    return id;
  }
}

class MiddlewareException implements Exception {
  const MiddlewareException(this.message);

  final String message;

  @override
  String toString() => message;
}
