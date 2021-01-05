import 'package:meta/meta.dart';

/// We don't use an `enum` because the serialization of that is not easily
/// customizable. We need to send and receive values as uppercase.
@immutable
abstract class UpperCaseEnum {
  final String value;

  const UpperCaseEnum(this.value);

  String toJson() => value;

  static T fromJson<T extends UpperCaseEnum>(List<T> values, String json) =>
      values.firstWhere((e) => e.value == json);

  @override
  bool operator ==(Object other) =>
      other is UpperCaseEnum ? other.value == value : false;

  @override
  int get hashCode => value.hashCode;
}
