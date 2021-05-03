import 'package:json_annotation/json_annotation.dart';

import '../util/equatable.dart';

part 'contact.g.dart';

@JsonSerializable(createFactory: true)
class Contact extends Equatable {
  final String name;
  final Uri? imageUri;

  Contact({required this.name, this.imageUri});

  @override
  @JsonKey(ignore: true)
  List<Object?> get props => [name, imageUri];

  static Contact fromJson(Map<String, dynamic> json) {
    // Invalid image URIs are set to null.
    final jsonImageUri = json['imageUri'];
    if (jsonImageUri != null &&
        (jsonImageUri is! String || jsonImageUri.isEmpty)) {
      json['imageUri'] = null;
    }

    return _$ContactFromJson(json);
  }

  Map<String, dynamic> toJson() => _$ContactToJson(this);
}
