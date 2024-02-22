import 'package:freezed_annotation/freezed_annotation.dart';

import '../contacts/supplementary_contact.dart';

part 'preferences.freezed.dart';
part 'preferences.g.dart';

@freezed
class Preferences with _$Preferences {
  const factory Preferences({
    required bool useApplicationProvidedRingtone,
    required bool showCallsInNativeRecents,
    @Default({}) Set<SupplementaryContact> supplementaryContacts,
  }) = _Preferences;

  /// Equivalent to `Preferences.DEFAULT` in the PIL.
  static const standard = Preferences(
    useApplicationProvidedRingtone: false,
    showCallsInNativeRecents: true,
  );

  factory Preferences.fromJson(Map<String, dynamic> json) =>
      _$PreferencesFromJson(json);
}
