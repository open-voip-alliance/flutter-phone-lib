// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'call.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Call _$CallFromJson(Map<String, dynamic> json) => _Call(
  remoteNumber: json['remoteNumber'] as String,
  displayName: json['displayName'] as String,
  state: const CallStateConverter().fromJson(json['state'] as String),
  direction: const CallDirectionConverter().fromJson(
    json['direction'] as String,
  ),
  duration: (json['duration'] as num).toInt(),
  isOnHold: json['isOnHold'] as bool,
  uuid: json['uuid'] as String,
  mos: (json['mos'] as num).toDouble(),
  currentMos: (json['currentMos'] as num).toDouble(),
  contact: json['contact'] == null
      ? null
      : Contact.fromJson(json['contact'] as Map<String, dynamic>),
  remotePartyHeading: json['remotePartyHeading'] as String,
  remotePartySubheading: json['remotePartySubheading'] as String,
  prettyDuration: json['prettyDuration'] as String,
  callId: json['callId'] as String,
  reason: json['reason'] as String,
);

Map<String, dynamic> _$CallToJson(_Call instance) => <String, dynamic>{
  'remoteNumber': instance.remoteNumber,
  'displayName': instance.displayName,
  'state': const CallStateConverter().toJson(instance.state),
  'direction': const CallDirectionConverter().toJson(instance.direction),
  'duration': instance.duration,
  'isOnHold': instance.isOnHold,
  'uuid': instance.uuid,
  'mos': instance.mos,
  'currentMos': instance.currentMos,
  'contact': instance.contact?.toJson(),
  'remotePartyHeading': instance.remotePartyHeading,
  'remotePartySubheading': instance.remotePartySubheading,
  'prettyDuration': instance.prettyDuration,
  'callId': instance.callId,
  'reason': instance.reason,
};
