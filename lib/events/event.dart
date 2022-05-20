import '../call_session_state.dart';
import '../util/equatable.dart';
import '../util/upper_case_enum.dart';

class Event extends Equatable {
  const Event._();

  static Event fromJson(Map<String, dynamic> json) {
    if (json.containsKey('type')) {
      if (json.containsKey('state')) {
        final state = CallSessionState.fromJson((json['state'] as Map).cast());
        final type = json['type'];

        if (type == (OutgoingCallStarted).toString()) {
          return OutgoingCallStarted._(state);
        } else if (type == (IncomingCallReceived).toString()) {
          return IncomingCallReceived._(state);
        } else if (type == (CallEnded).toString()) {
          return CallEnded._(state);
        } else if (type == (CallConnected).toString()) {
          return CallConnected._(state);
        } else if (type == (CallDurationUpdated).toString()) {
          return CallDurationUpdated._(state);
        } else if (type == (AudioStateUpdated).toString()) {
          return AudioStateUpdated._(state);
        } else if (type == (CallStateUpdated).toString()) {
          return CallStateUpdated._(state);
        } else if (type == (AttendedTransferConnected).toString()) {
          return AttendedTransferConnected._(state);
        } else if (type == (AttendedTransferAborted).toString()) {
          return AttendedTransferAborted._(state);
        } else if (type == (AttendedTransferStarted).toString()) {
          return AttendedTransferStarted._(state);
        } else if (type == (AttendedTransferEnded).toString()) {
          return AttendedTransferEnded._(state);
        }
      } else if (json.containsKey('reason')) {
        final reason = Reason.fromJson((json['reason'] as String));
        final type = json['type'];

        if (type == (OutgoingCallSetupFailed).toString()) {
          return OutgoingCallSetupFailed._(reason);
        } else if (type == (IncomingCallSetupFailed).toString()) {
          return IncomingCallSetupFailed._(reason);
        }
      }
    }

    throw UnsupportedError('Unsupported Event: $json');
  }

  // @JsonKey(ignore: true) is not needed because we don't serialize
  // this class, only deserialize.
  @override
  List<Object?> get props => [];
}

class CallSessionEvent extends Event {
  final CallSessionState? state;

  const CallSessionEvent._(this.state) : super._();

  @override
  List<Object?> get props => [...super.props, state];
}

abstract class AttendedTransferEvent extends CallSessionEvent {
  const AttendedTransferEvent._(CallSessionState state) : super._(state);
}

class OutgoingCallStarted extends CallSessionEvent {
  const OutgoingCallStarted._(CallSessionState state) : super._(state);
}

class IncomingCallReceived extends CallSessionEvent {
  const IncomingCallReceived._(CallSessionState state) : super._(state);
}

class CallEnded extends CallSessionEvent {
  const CallEnded._(CallSessionState state) : super._(state);
}

class CallDurationUpdated extends CallSessionEvent {
  const CallDurationUpdated._(CallSessionState state) : super._(state);
}

class CallConnected extends CallSessionEvent {
  const CallConnected._(CallSessionState state) : super._(state);
}

class AudioStateUpdated extends CallSessionEvent {
  const AudioStateUpdated._(CallSessionState state) : super._(state);
}

class CallStateUpdated extends CallSessionEvent {
  const CallStateUpdated._(CallSessionState state) : super._(state);
}

class AttendedTransferStarted extends AttendedTransferEvent {
  const AttendedTransferStarted._(CallSessionState state) : super._(state);
}

class AttendedTransferConnected extends AttendedTransferEvent {
  const AttendedTransferConnected._(CallSessionState state) : super._(state);
}

class AttendedTransferAborted extends AttendedTransferEvent {
  const AttendedTransferAborted._(CallSessionState state) : super._(state);
}

class AttendedTransferEnded extends AttendedTransferEvent {
  const AttendedTransferEnded._(CallSessionState state) : super._(state);
}

abstract class CallSetupFailedEvent extends Event {
  final Reason reason;

  const CallSetupFailedEvent._(this.reason) : super._();

  @override
  List<Object?> get props => [...super.props, reason];
}

class OutgoingCallSetupFailed extends CallSetupFailedEvent {
  const OutgoingCallSetupFailed._(Reason reason) : super._(reason);
}

class IncomingCallSetupFailed extends CallSetupFailedEvent {
  const IncomingCallSetupFailed._(Reason reason) : super._(reason);
}

class Reason extends UpperCaseEnum {
  const Reason._(String value) : super(value);

  static const unknown = Reason._('UNKNOWN');
  static const inCall = Reason._('IN_CALL');
  static const rejectedByAndroidTelecomFramework = Reason._(
    'REJECTED_BY_ANDROID_TELECOM_FRAMEWORK',
  );
  static const unableToRegister = Reason._('UNABLE_TO_REGISTER');
  static const rejectedByCallKit = Reason._('REJECTED_BY_CALL_KIT');

  static const List<Reason> values = [
    unknown,
    inCall,
    rejectedByAndroidTelecomFramework,
    unableToRegister,
    rejectedByCallKit,
  ];

  static Reason fromJson(String json) => UpperCaseEnum.fromJson(values, json);
}
