import 'package:freezed_annotation/freezed_annotation.dart';

import '../contacts/contact.dart';
import 'call_direction.dart';
import 'call_direction_converter.dart';
import 'call_state.dart';
import 'call_state_converter.dart';

part 'call.freezed.dart';
part 'call.g.dart';

@freezed
sealed class Call with _$Call {
  const factory Call({
    required String remoteNumber,
    required String displayName,
    @CallStateConverter() required CallState state,
    @CallDirectionConverter() required CallDirection direction,
    required int duration,
    required bool isOnHold,
    required String uuid,
    required double mos,
    required double currentMos,
    Contact? contact,
    required String remotePartyHeading,
    required String remotePartySubheading,
    required String prettyDuration,
    required String callId,
    required String reason,
  }) = _Call;

  factory Call.fromJson(Map<String, dynamic> json) => _$CallFromJson(json);
}
