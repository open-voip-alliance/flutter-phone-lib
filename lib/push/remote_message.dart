import 'package:json_annotation/json_annotation.dart';

part 'remote_message.g.dart';

@JsonSerializable(createToJson: false, createFactory: true)
class RemoteMessage {
  final Map<String, dynamic> data;

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
