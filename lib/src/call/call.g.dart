// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'call.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Call _$CallFromJson(Map<String, dynamic> json) => Call(
      remoteNumber: json['remoteNumber'] as String,
      displayName: json['displayName'] as String,
      state: CallState.fromJson(json['state'] as String),
      direction: CallDirection.fromJson(json['direction'] as String),
      duration: json['duration'] as int,
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

Map<String, dynamic> _$CallToJson(Call instance) => <String, dynamic>{
      'remoteNumber': instance.remoteNumber,
      'displayName': instance.displayName,
      'state': instance.state.toJson(),
      'direction': instance.direction.toJson(),
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
