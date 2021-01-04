import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';

import '../util/equatable.dart';

part 'contact.g.dart';

@JsonSerializable(createFactory: true)
class Contact extends Equatable {
  final String name;
  final Uri imageUri;

  Contact({@required this.name, this.imageUri});

  @override
  @JsonKey(ignore: true)
  List<Object> get props => [];

  static Contact fromJson(Map<String, dynamic> json) => _$ContactFromJson(json);

  Map<String, dynamic> toJson() => _$ContactToJson(this);
}
