import '../util/upper_case_enum.dart';

class AudioRoute extends UpperCaseEnum {
  const AudioRoute._(String value) : super(value);

  static const speaker = AudioRoute._('SPEAKER');
  static const phone = AudioRoute._('PHONE');
  static const bluetooth = AudioRoute._('BLUETOOTH');

  static const List<AudioRoute> values = [speaker, phone, bluetooth];

  static AudioRoute fromJson(String json) =>
      UpperCaseEnum.fromJson(values, json);
}
