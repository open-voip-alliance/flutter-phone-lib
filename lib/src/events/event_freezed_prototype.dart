import 'package:freezed_annotation/freezed_annotation.dart';
import '../call_session_state.dart';
import '../util/upper_case_enum.dart';

part 'event_freezed_prototype.freezed.dart';

// ============================================================================
// INTERFACES - Define the inheritance structure
// ============================================================================

/// Interface for events that have CallSessionState
abstract interface class CallSessionEvent {
  CallSessionState? get state;
}

/// Interface for attended transfer events (subset of CallSessionEvent)
abstract interface class AttendedTransferEvent implements CallSessionEvent {
  @override
  CallSessionState? get state;
}

/// Interface for call setup failed events
abstract interface class CallSetupFailedEvent {
  Reason get reason;
}

// ============================================================================
// FREEZED UNION - All event types with interface implementations
// ============================================================================

@freezed
sealed class Event with _$Event {
  // Standard CallSessionEvent implementations
  @Implements<CallSessionEvent>()
  const factory Event.outgoingCallStarted({
    required CallSessionState? state,
  }) = OutgoingCallStarted;

  @Implements<CallSessionEvent>()
  const factory Event.incomingCallReceived({
    required CallSessionState? state,
  }) = IncomingCallReceived;

  @Implements<CallSessionEvent>()
  const factory Event.callEnded({
    required CallSessionState? state,
  }) = CallEnded;

  @Implements<CallSessionEvent>()
  const factory Event.callDurationUpdated({
    required CallSessionState? state,
  }) = CallDurationUpdated;

  @Implements<CallSessionEvent>()
  const factory Event.callConnected({
    required CallSessionState? state,
  }) = CallConnected;

  @Implements<CallSessionEvent>()
  const factory Event.audioStateUpdated({
    required CallSessionState? state,
  }) = AudioStateUpdated;

  @Implements<CallSessionEvent>()
  const factory Event.callStateUpdated({
    required CallSessionState? state,
  }) = CallStateUpdated;

  // AttendedTransferEvent implementations
  @Implements<AttendedTransferEvent>()
  const factory Event.attendedTransferStarted({
    required CallSessionState? state,
  }) = AttendedTransferStarted;

  @Implements<AttendedTransferEvent>()
  const factory Event.attendedTransferConnected({
    required CallSessionState? state,
  }) = AttendedTransferConnected;

  @Implements<AttendedTransferEvent>()
  const factory Event.attendedTransferAborted({
    required CallSessionState? state,
  }) = AttendedTransferAborted;

  @Implements<AttendedTransferEvent>()
  const factory Event.attendedTransferEnded({
    required CallSessionState? state,
  }) = AttendedTransferEnded;

  // CallSetupFailedEvent implementations
  @Implements<CallSetupFailedEvent>()
  const factory Event.outgoingCallSetupFailed({
    required Reason reason,
  }) = OutgoingCallSetupFailed;

  @Implements<CallSetupFailedEvent>()
  const factory Event.incomingCallSetupFailed({
    required Reason reason,
  }) = IncomingCallSetupFailed;

  const Event._();
}

// Reason enum (keeping same as original)
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
