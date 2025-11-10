import 'package:freezed_annotation/freezed_annotation.dart';

import '../contacts/supplementary_contact.dart';

part 'preferences.freezed.dart';
part 'preferences.g.dart';

@freezed
sealed class Preferences with _$Preferences {
  const factory Preferences({
    required bool useApplicationProvidedRingtone,
    required bool showCallsInNativeRecents,
    @Default({}) Set<SupplementaryContact> supplementaryContacts,
    @Default(false) bool enableAdvancedLogging,
  }) = _Preferences;

  /// Equivalent to `Preferences.DEFAULT` in the PIL.
  static const standard = Preferences(
    useApplicationProvidedRingtone: false,
    showCallsInNativeRecents: true,
    enableAdvancedLogging: false,
  );

  factory Preferences.fromJson(Map<String, dynamic> json) =>
      _$PreferencesFromJson(json);
}
