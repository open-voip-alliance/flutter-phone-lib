import 'package:json_annotation/json_annotation.dart';

import '../audio/codec.dart';
import '../util/equatable.dart';

part 'preferences.g.dart';

@JsonSerializable()
class Preferences extends Equatable {
  final List<Codec> codecs;
  final bool useApplicationProvidedRingtone;
  final bool showCallsInNativeRecents;

  const Preferences({
    required this.codecs,
    required this.useApplicationProvidedRingtone,
    required this.showCallsInNativeRecents,
  });

  /// Equivalent to `Preferences.DEFAULT` in the PIL.
  static const standard = Preferences(
    codecs: [Codec.opus],
    useApplicationProvidedRingtone: false,
    showCallsInNativeRecents: true,
  );

  @override
  @JsonKey(ignore: true)
  List<Object?> get props => [
        codecs,
        useApplicationProvidedRingtone,
        showCallsInNativeRecents,
      ];

  Map<String, dynamic> toJson() => _$PreferencesToJson(this);
}
