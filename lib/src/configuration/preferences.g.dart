// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'preferences.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Preferences _$PreferencesFromJson(Map<String, dynamic> json) => _Preferences(
  useApplicationProvidedRingtone:
      json['useApplicationProvidedRingtone'] as bool,
  showCallsInNativeRecents: json['showCallsInNativeRecents'] as bool,
  supplementaryContacts:
      (json['supplementaryContacts'] as List<dynamic>?)
          ?.map((e) => SupplementaryContact.fromJson(e as Map<String, dynamic>))
          .toSet() ??
      const {},
  enableAdvancedLogging: json['enableAdvancedLogging'] as bool? ?? false,
);

Map<String, dynamic> _$PreferencesToJson(_Preferences instance) =>
    <String, dynamic>{
      'useApplicationProvidedRingtone': instance.useApplicationProvidedRingtone,
      'showCallsInNativeRecents': instance.showCallsInNativeRecents,
      'supplementaryContacts': instance.supplementaryContacts
          .map((e) => e.toJson())
          .toList(),
      'enableAdvancedLogging': instance.enableAdvancedLogging,
    };
