// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'supplementary_contact.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_SupplementaryContact _$SupplementaryContactFromJson(
  Map<String, dynamic> json,
) => _SupplementaryContact(
  number: json['number'] as String,
  name: json['name'] as String,
  imageUri: json['imageUri'] == null
      ? null
      : Uri.parse(json['imageUri'] as String),
);

Map<String, dynamic> _$SupplementaryContactToJson(
  _SupplementaryContact instance,
) => <String, dynamic>{
  'number': instance.number,
  'name': instance.name,
  'imageUri': instance.imageUri?.toString(),
};
