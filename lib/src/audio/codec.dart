import '../util/upper_case_enum.dart';

class Codec extends UpperCaseEnum {
  const Codec._(String value) : super(value);

  static const gsm = Codec._('GSM');
  static const g722 = Codec._('G722');
  static const g729 = Codec._('G729');
  static const ilbc = Codec._('ILBC');
  static const isac = Codec._('ISAC');
  static const l16 = Codec._('L16');
  static const opus = Codec._('OPUS');
  static const pcmu = Codec._('PCMU');
  static const pcma = Codec._('PCMA');
  static const speex = Codec._('SPEEX');

  static const List<Codec> values = [
    gsm,
    g722,
    g729,
    ilbc,
    isac,
    l16,
    opus,
    pcmu,
    pcma,
    speex,
  ];
}
