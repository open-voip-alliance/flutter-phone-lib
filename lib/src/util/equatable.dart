import 'package:equatable/equatable.dart' as equatable;
import 'package:json_annotation/json_annotation.dart';

/// Class that does not serialize unnecessary properties.
abstract class Equatable extends equatable.Equatable {
  const Equatable();

  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  bool? get stringify => super.stringify;

  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  // ignore: hash_and_equals
  int get hashCode => super.hashCode;
}
