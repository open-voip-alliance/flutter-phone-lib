import '../phone_lib.dart';
import 'audio_route.dart';
import 'audio_state.dart';
import 'codec.dart';

class AudioManager {
  Future<Iterable<Codec>> get availableCodecs => throw UnimplementedError();

  Future<bool> get isMicrophoneMuted async =>
      await PhoneLib.channel.invokeMethod('AudioManager.isMicrophoneMuted')
          as bool;

  Future<AudioState> get state async => AudioState.fromJson(
        await PhoneLib.channel
            .invokeMethod('AudioManager.state')
            .then((v) => (v as Map).cast()),
      );

  Future<void> routeAudio(AudioRoute route) =>
      PhoneLib.channel.invokeMethod('AudioManager.routeAudio', route.toJson());

  Future<void> mute() => PhoneLib.channel.invokeMethod('AudioManager.mute');

  Future<void> unmute() => PhoneLib.channel.invokeMethod('AudioManager.unmute');

  Future<void> toggleMute() =>
      PhoneLib.channel.invokeMethod('AudioManager.toggleMute');
}
