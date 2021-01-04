import '../util/upper_case_enum.dart';

class Event extends UpperCaseEnum {
  const Event._(String value) : super(value);

  static const outgoingCallStarted = Event._('OUTGOING_CALL_STARTED');
  static const incomingCallReceived = Event._('INCOMING_CALL_RECEIVED');
  static const callEnded = Event._('CALL_ENDED');
  static const callUpdated = Event._('CALL_UPDATED');
  static const callConnected = Event._('CALL_CONNECTED');

  static const List<Event> values = [
    outgoingCallStarted,
    incomingCallReceived,
    callEnded,
    callUpdated,
    callConnected,
  ];

  static Event fromJson(String json) => UpperCaseEnum.fromJson(values, json);
}
