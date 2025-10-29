import 'package:json_annotation/json_annotation.dart';
import 'call_state.dart';

class CallStateConverter implements JsonConverter<CallState, String> {
  const CallStateConverter();

  @override
  CallState fromJson(String json) => CallState.fromJson(json);

  @override
  String toJson(CallState object) => object.toJson();
}