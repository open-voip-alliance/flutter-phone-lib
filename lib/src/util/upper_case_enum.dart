import 'package:meta/meta.dart';

/// We don't use an `enum` because the serialization of that is not easily
/// customizable. We need to send and receive values as uppercase.
@immutable
abstract class UpperCaseEnum {
  final String name;

  const UpperCaseEnum(this.name);

  String toJson() => name;

  static T fromJson<T extends UpperCaseEnum>(List<T> values, String json) =>
      values.firstWhere((e) => e.name == json);

  @override
  bool operator ==(Object other) =>
      other is UpperCaseEnum ? other.name == name : false;

  @override
  int get hashCode => name.hashCode;

  @override
  String toString() => '$runtimeType(\'$name\')';
}
