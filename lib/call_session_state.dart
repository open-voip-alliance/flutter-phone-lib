import 'package:json_annotation/json_annotation.dart';

import 'audio/audio_state.dart';
import 'call/call.dart';
import 'util/equatable.dart';

part 'call_session_state.g.dart';

@JsonSerializable(createFactory: true)
class CallSessionState extends Equatable {
  final Call? activeCall;
  final Call? inactiveCall;
  final AudioState audioState;

  const CallSessionState({
    this.activeCall,
    this.inactiveCall,
    required this.audioState,
  });

  @override
  @JsonKey(ignore: true)
  List<Object?> get props => [
        activeCall,
        inactiveCall,
        audioState,
      ];

  static CallSessionState fromJson(Map<String, dynamic> json) =>
      CallSessionState(
        activeCall: json['activeCall'] == null
            ? null
            : Call.fromJson(json['activeCall'] as Map<String, dynamic>),
        inactiveCall: json['inactiveCall'] == null
            ? null
            : Call.fromJson(json['inactiveCall'] as Map<String, dynamic>),
        audioState: AudioState.fromJson(
          (json['audioState'] as Map).cast<String, dynamic>(),
        ),
      );

  Map<String, dynamic> toJson() => _$CallSessionStateToJson(this);
}
