import 'package:freezed_annotation/freezed_annotation.dart';

part 'auth.freezed.dart';
part 'auth.g.dart';

@freezed
sealed class Auth with _$Auth {
  const factory Auth({
    required String username,
    required String password,
    required String domain,
    required int port,
    required bool secure,
  }) = _Auth;

  factory Auth.fromJson(Map<String, dynamic> json) => _$AuthFromJson(json);
}
