import '../util/upper_case_enum.dart';

class CallState extends UpperCaseEnum {
  const CallState._(String value) : super(value);

  static const initializing = CallState._('INITIALIZING');
  static const ringing = CallState._('RINGING');
  static const connected = CallState._('CONNECTED');
  static const heldByLocal = CallState._('HELD_BY_LOCAL');
  static const heldByRemote = CallState._('HELD_BY_REMOTE');
  static const ended = CallState._('ENDED');
  static const error = CallState._('ERROR');

  static const List<CallState> values = [
    initializing,
    ringing,
    connected,
    heldByLocal,
    heldByRemote,
    ended,
    error,
  ];

  static CallState fromJson(String json) =>
      UpperCaseEnum.fromJson(values, json);
}
