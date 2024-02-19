import 'package:json_annotation/json_annotation.dart';

import '../contacts/contact.dart';
import '../util/equatable.dart';
import 'call_direction.dart';
import 'call_state.dart';

part 'call.g.dart';

@JsonSerializable(createFactory: true)
class Call extends Equatable {
  final String remoteNumber;
  final String displayName;

  @JsonKey(fromJson: CallState.fromJson)
  final CallState state;

  @JsonKey(fromJson: CallDirection.fromJson)
  final CallDirection direction;
  final int duration;
  final bool isOnHold;
  final String uuid;
  final double mos;
  final double currentMos;
  final Contact? contact;
  final String remotePartyHeading;
  final String remotePartySubheading;
  final String prettyDuration;
  final String callId;
  final String reason;

  const Call({
    required this.remoteNumber,
    required this.displayName,
    required this.state,
    required this.direction,
    required this.duration,
    required this.isOnHold,
    required this.uuid,
    required this.mos,
    required this.currentMos,
    this.contact,
    required this.remotePartyHeading,
    required this.remotePartySubheading,
    required this.prettyDuration,
    required this.callId,
    required this.reason,
  });

  Call copyWith({
    String? remoteNumber,
    String? displayName,
    CallState? state,
    CallDirection? direction,
    int? duration,
    bool? isOnHold,
    String? uuid,
    double? mos,
    double? currentMos,
    Contact? contact,
    String? remotePartyHeading,
    String? remotePartySubheading,
    String? prettyDuration,
    String? callId,
    String? reason,
  }) {
    return Call(
      remoteNumber: remoteNumber ?? this.remoteNumber,
      displayName: displayName ?? this.displayName,
      state: state ?? this.state,
      direction: direction ?? this.direction,
      duration: duration ?? this.duration,
      isOnHold: isOnHold ?? this.isOnHold,
      uuid: uuid ?? this.uuid,
      mos: mos ?? this.mos,
      currentMos: currentMos ?? this.currentMos,
      contact: contact ?? this.contact,
      remotePartyHeading: remotePartyHeading ?? this.remotePartyHeading,
      remotePartySubheading:
          remotePartySubheading ?? this.remotePartySubheading,
      prettyDuration: prettyDuration ?? this.prettyDuration,
      callId: callId ?? this.callId,
      reason: reason ?? this.reason,
    );
  }

  @override
  @JsonKey(ignore: true)
  List<Object?> get props => [
        remoteNumber,
        displayName,
        state,
        direction,
        duration,
        isOnHold,
        uuid,
        mos,
        currentMos,
        contact,
        remotePartyHeading,
        remotePartySubheading,
        prettyDuration,
        callId,
        reason,
      ];

  static Call fromJson(Map<String, dynamic> json) => _$CallFromJson(json);

  Map<String, dynamic> toJson() => _$CallToJson(this);
}

///This will compare two Call objects while ignoring duration, prettyDuration,
///uuid, mos and currentMos properties.
extension CallComparison on Call {
  bool compareCalls(Call other) {
    final thisCall = copyWith(
      duration: 0,
      prettyDuration: '',
      uuid: '',
      mos: 0,
      currentMos: 0,
    );

    final otherCall = other.copyWith(
      duration: 0,
      prettyDuration: '',
      uuid: '',
      mos: 0,
      currentMos: 0,
    );

    return thisCall == otherCall;
  }
}
