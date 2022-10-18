import 'package:equatable/equatable.dart' as equatable;
import 'package:json_annotation/json_annotation.dart';

/// Class that does not serialize unnecessary properties.
abstract class Equatable extends equatable.Equatable {
  const Equatable();

  @override
  @JsonKey(ignore: true)
  bool? get stringify => super.stringify;

  @override
  @JsonKey(ignore: true)
  // ignore: hash_and_equals
  int get hashCode => super.hashCode;
}
