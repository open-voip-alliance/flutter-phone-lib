import 'package:freezed_annotation/freezed_annotation.dart';

part 'supplementary_contact.freezed.dart';
part 'supplementary_contact.g.dart';

@freezed
class SupplementaryContact with _$SupplementaryContact {
  const factory SupplementaryContact({
    required String number,
    required String name,
    // @Default(null) Uri? imageUri,
  }) = _SupplementaryContact;

  factory SupplementaryContact.fromJson(Map<String, dynamic> json) =>
      _$SupplementaryContactFromJson(json);
}
