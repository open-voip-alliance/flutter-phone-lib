import '../fil.dart';
import 'audio_route.dart';
import 'audio_state.dart';
import 'codec.dart';

class AudioManager {
  Future<Iterable<Codec>> get availableCodecs => throw UnimplementedError();

  Future<bool> get isMicrophoneMuted =>
      Fil.channel.invokeMethod('AudioManager.isMicrophoneMuted');

  Future<AudioState> get state async => AudioState.fromJson(
        await Fil.channel
            .invokeMethod('AudioManager.state')
            .then((v) => (v as Map).cast()),
      );

  Future<void> routeAudio(AudioRoute route) =>
      Fil.channel.invokeMethod('AudioManager.routeAudio', route.toJson());

  Future<void> mute() => Fil.channel.invokeMethod('AudioManager.mute');

  Future<void> unmute() => Fil.channel.invokeMethod('AudioManager.unmute');

  Future<void> toggleMute() =>
      Fil.channel.invokeMethod('AudioManager.toggleMute');
}
