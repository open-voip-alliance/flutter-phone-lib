import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

/// Exchanges a VoIPGRID portal login for the API token the middleware needs.
class Voipgrid extends ChangeNotifier {
  Voipgrid(this._storage);

  static final _apiTokenUrl =
      Uri.parse('https://partner.voipgrid.nl/api/permission/apitoken/');

  final SharedPreferences _storage;

  String get username => _storage.getString('voipgrid_username') ?? '';
  String get password => _storage.getString('voipgrid_password') ?? '';
  String get apiToken => _storage.getString('voipgrid_api_token') ?? '';

  bool get hasLogin => username.isNotEmpty && password.isNotEmpty;
  bool get isLoggedIn => apiToken.isNotEmpty;

  Future<void> saveLogin({
    required String username,
    required String password,
  }) async {
    await _storage.setString('voipgrid_username', username);
    await _storage.setString('voipgrid_password', password);
    notifyListeners();
  }

  Future<void> login() async {
    debugPrint('Logging in to VoIPGRID as $username: POST $_apiTokenUrl');

    final response = await http.post(
      _apiTokenUrl,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'email': username, 'password': password}),
    );

    debugPrint('POST $_apiTokenUrl -> ${response.statusCode}');

    if (response.statusCode < 200 || response.statusCode >= 300) {
      await logout();
      throw VoipgridException(
        'VoIPGRID login failed (${response.statusCode}): ${response.body}',
      );
    }

    final token = (jsonDecode(response.body) as Map)['api_token'] as String?;

    if (token == null || token.isEmpty) {
      await logout();
      throw VoipgridException(
        'VoIPGRID login returned no API token: ${response.body}',
      );
    }

    await _storage.setString('voipgrid_api_token', token);
    debugPrint('Logged in to VoIPGRID');
    notifyListeners();
  }

  Future<void> logout() async {
    await _storage.remove('voipgrid_api_token');
    notifyListeners();
  }
}

class VoipgridException implements Exception {
  const VoipgridException(this.message);

  final String message;

  @override
  String toString() => message;
}
