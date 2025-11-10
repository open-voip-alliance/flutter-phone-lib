import 'package:freezed_annotation/freezed_annotation.dart';

part 'bluetooth_audio_route.freezed.dart';
part 'bluetooth_audio_route.g.dart';

@freezed
sealed class BluetoothAudioRoute with _$BluetoothAudioRoute {
  const factory BluetoothAudioRoute({
    required String displayName,
    required String identifier,
  }) = _BluetoothAudioRoute;

  factory BluetoothAudioRoute.fromJson(Map<String, dynamic> json) =>
      _$BluetoothAudioRouteFromJson(json);
}
