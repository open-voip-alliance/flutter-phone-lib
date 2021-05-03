import 'package:json_annotation/json_annotation.dart';
import '../util/equatable.dart';
import 'audio_route.dart';

part 'audio_state.g.dart';

@JsonSerializable(createToJson: false, createFactory: true)
class AudioState extends Equatable {
  @JsonKey(fromJson: AudioRoute.fromJson)
  final AudioRoute currentRoute;

  @JsonKey(fromJson: _audioRoutesFromJson)
  final Iterable<AudioRoute> availableRoutes;
  final String? bluetoothDeviceName;

  const AudioState({
    required this.currentRoute,
    required this.availableRoutes,
    this.bluetoothDeviceName,
  });

  @override
  @JsonKey(ignore: true)
  List<Object?> get props => [
        currentRoute,
        availableRoutes,
        bluetoothDeviceName,
      ];

  static AudioState fromJson(Map<String, dynamic> json) =>
      _$AudioStateFromJson(json);
}

List<AudioRoute> _audioRoutesFromJson(List<dynamic> values) => values
    .map((v) => AudioRoute.fromJson(v as String))
    .toList(); // Generated code casts to List.
