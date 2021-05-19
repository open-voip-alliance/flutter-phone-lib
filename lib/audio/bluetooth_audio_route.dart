import 'package:json_annotation/json_annotation.dart';

import '../util/equatable.dart';

part 'bluetooth_audio_route.g.dart';

@JsonSerializable(createFactory: true)
class BluetoothAudioRoute extends Equatable {
  final String displayName;
  final String identifier;

  const BluetoothAudioRoute({
    required this.displayName,
    required this.identifier,
  });

  @override
  List<Object?> get props => [
        displayName,
        identifier,
      ];

  static BluetoothAudioRoute fromJson(Map<String, dynamic> json) =>
      _$BluetoothAudioRouteFromJson(json);

  Map<String, dynamic> toJson() => _$BluetoothAudioRouteToJson(this);
}
