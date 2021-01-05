import 'package:json_annotation/json_annotation.dart';

part 'remote_message.g.dart';

// NOTE: This is not a class from the PIL, but from Firebase.
@JsonSerializable(createToJson: false, createFactory: true)
class RemoteMessage {
  final Map<String, String> data;

  const RemoteMessage(this.data);

  // Not called fromJson because it accepts a Map instead of
  // Map<String, dynamic> (which is considered 'json' in Dart).
  static RemoteMessage fromMap(Map map) {
    // Cast is not nested, so cast data too.
    final castMap = map.cast<String, dynamic>();
    castMap['data'] = castMap['data']?.cast<String, dynamic>() ?? {};

    return _$RemoteMessageFromJson(castMap);
  }
}
