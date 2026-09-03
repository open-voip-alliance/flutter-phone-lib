// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'preferences.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Preferences _$PreferencesFromJson(Map<String, dynamic> json) => _Preferences(
  useApplicationProvidedRingtone:
      json['useApplicationProvidedRingtone'] as bool,
  showCallsInNativeRecents: json['showCallsInNativeRecents'] as bool,
  enableAdvancedLogging: json['enableAdvancedLogging'] as bool? ?? false,
);

Map<String, dynamic> _$PreferencesToJson(_Preferences instance) =>
    <String, dynamic>{
      'useApplicationProvidedRingtone': instance.useApplicationProvidedRingtone,
      'showCallsInNativeRecents': instance.showCallsInNativeRecents,
      'enableAdvancedLogging': instance.enableAdvancedLogging,
    };
