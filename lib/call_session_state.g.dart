// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'call_session_state.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CallSessionState _$CallSessionStateFromJson(Map<String, dynamic> json) =>
    CallSessionState(
      activeCall: json['activeCall'] == null
          ? null
          : Call.fromJson(json['activeCall'] as Map<String, dynamic>),
      inactiveCall: json['inactiveCall'] == null
          ? null
          : Call.fromJson(json['inactiveCall'] as Map<String, dynamic>),
      audioState:
          AudioState.fromJson(json['audioState'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$CallSessionStateToJson(CallSessionState instance) =>
    <String, dynamic>{
      'activeCall': instance.activeCall?.toJson(),
      'inactiveCall': instance.inactiveCall?.toJson(),
      'audioState': instance.audioState.toJson(),
    };
