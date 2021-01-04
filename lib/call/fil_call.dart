import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';

import '../contacts/contact.dart';
import '../util/equatable.dart';
import 'call_direction.dart';
import 'call_state.dart';

part 'fil_call.g.dart';

@JsonSerializable(createFactory: true)
class FilCall extends Equatable {
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
  final Contact contact;
  final String remotePartyHeading;
  final String remotePartySubheading;
  final String prettyDuration;

  const FilCall({
    @required this.remoteNumber,
    @required this.displayName,
    @required this.state,
    @required this.direction,
    @required this.duration,
    @required this.isOnHold,
    @required this.uuid,
    @required this.mos,
    @required this.contact,
    @required this.remotePartyHeading,
    @required this.remotePartySubheading,
    @required this.prettyDuration,
  });

  @override
  @JsonKey(ignore: true)
  List<Object> get props => [
        remoteNumber,
        displayName,
        state,
        direction,
        duration,
        isOnHold,
        uuid,
        mos,
        contact,
        remotePartyHeading,
        remotePartySubheading,
        prettyDuration,
      ];

  static FilCall fromJson(Map<String, dynamic> json) =>
      json != null ? _$FilCallFromJson(json) : null;

  Map<String, dynamic> toJson() => _$FilCallToJson(this);
}
