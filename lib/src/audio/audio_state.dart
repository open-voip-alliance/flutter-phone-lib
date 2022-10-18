import 'package:json_annotation/json_annotation.dart';

import '../util/equatable.dart';
import 'audio_route.dart';
import 'bluetooth_audio_route.dart';

part 'audio_state.g.dart';

@JsonSerializable(createFactory: true)
class AudioState extends Equatable {
  @JsonKey(fromJson: AudioRoute.fromJson)
  final AudioRoute currentRoute;

  @JsonKey(fromJson: _audioRoutesFromJson)
  final Iterable<AudioRoute> availableRoutes;
  final String? bluetoothDeviceName;
  final bool isMicrophoneMuted;

  @JsonKey(fromJson: _bluetoothAudioRoutesFromJson)
  final Iterable<BluetoothAudioRoute> bluetoothRoutes;

  const AudioState({
    required this.currentRoute,
    required this.availableRoutes,
    this.bluetoothDeviceName,
    required this.isMicrophoneMuted,
    required this.bluetoothRoutes,
  });

  @override
  @JsonKey(ignore: true)
  List<Object?> get props => [
        currentRoute,
        availableRoutes,
        bluetoothDeviceName,
        isMicrophoneMuted,
        bluetoothRoutes,
      ];

  static AudioState fromJson(Map<String, dynamic> json) =>
      _$AudioStateFromJson(json);

  Map<String, dynamic> toJson() => _$AudioStateToJson(this);
}

List<AudioRoute> _audioRoutesFromJson(List<dynamic> values) =>
    values.map((v) => AudioRoute.fromJson(v as String)).toList();

List<BluetoothAudioRoute> _bluetoothAudioRoutesFromJson(List<dynamic> values) =>
    values
        .map(
          (v) => BluetoothAudioRoute.fromJson(
            (v as Map).cast<String, dynamic>(),
          ),
        )
        .toList();
