// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'audio_state.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AudioState _$AudioStateFromJson(Map<String, dynamic> json) => AudioState(
      currentRoute: AudioRoute.fromJson(json['currentRoute'] as String),
      availableRoutes: _audioRoutesFromJson(json['availableRoutes'] as List),
      bluetoothDeviceName: json['bluetoothDeviceName'] as String?,
      isMicrophoneMuted: json['isMicrophoneMuted'] as bool,
      bluetoothRoutes:
          _bluetoothAudioRoutesFromJson(json['bluetoothRoutes'] as List),
    );

Map<String, dynamic> _$AudioStateToJson(AudioState instance) =>
    <String, dynamic>{
      'currentRoute': instance.currentRoute.toJson(),
      'availableRoutes':
          instance.availableRoutes.map((e) => e.toJson()).toList(),
      'bluetoothDeviceName': instance.bluetoothDeviceName,
      'isMicrophoneMuted': instance.isMicrophoneMuted,
      'bluetoothRoutes':
          instance.bluetoothRoutes.map((e) => e.toJson()).toList(),
    };
