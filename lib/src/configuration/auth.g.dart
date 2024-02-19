// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Auth _$AuthFromJson(Map<String, dynamic> json) => Auth(
      username: json['username'] as String,
      password: json['password'] as String,
      domain: json['domain'] as String,
      port: json['port'] as int,
      secure: json['secure'] as bool,
    );

Map<String, dynamic> _$AuthToJson(Auth instance) => <String, dynamic>{
      'username': instance.username,
      'password': instance.password,
      'domain': instance.domain,
      'port': instance.port,
      'secure': instance.secure,
    };
