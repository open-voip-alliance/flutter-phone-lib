import '../util/upper_case_enum.dart';

class CallDirection extends UpperCaseEnum {
  const CallDirection._(String value) : super(value);

  static const inbound = CallDirection._('INBOUND');
  static const outbound = CallDirection._('OUTBOUND');

  static const List<CallDirection> values = [
    inbound,
    outbound,
  ];

  static CallDirection fromJson(String json) =>
      UpperCaseEnum.fromJson(values, json);

  bool get isInbound => this == inbound;

  bool get isOutbound => this == outbound;
}
