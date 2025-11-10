import 'package:json_annotation/json_annotation.dart';
import 'call_direction.dart';

class CallDirectionConverter implements JsonConverter<CallDirection, String> {
  const CallDirectionConverter();

  @override
  CallDirection fromJson(String json) => CallDirection.fromJson(json);

  @override
  String toJson(CallDirection object) => object.toJson();
}