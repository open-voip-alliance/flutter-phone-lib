// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'supplementary_contact.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$SupplementaryContactImpl _$$SupplementaryContactImplFromJson(
        Map<String, dynamic> json) =>
    _$SupplementaryContactImpl(
      number: json['number'] as String,
      name: json['name'] as String,
      imageUri: json['imageUri'] == null
          ? null
          : Uri.parse(json['imageUri'] as String),
    );

Map<String, dynamic> _$$SupplementaryContactImplToJson(
        _$SupplementaryContactImpl instance) =>
    <String, dynamic>{
      'number': instance.number,
      'name': instance.name,
      'imageUri': instance.imageUri?.toString(),
    };
