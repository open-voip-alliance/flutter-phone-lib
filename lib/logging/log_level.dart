import '../util/upper_case_enum.dart';

class LogLevel extends UpperCaseEnum {
  const LogLevel._(String value) : super(value);

  static const debug = LogLevel._('DEBUG');
  static const info = LogLevel._('INFO');
  static const warning = LogLevel._('WARNING');
  static const error = LogLevel._('ERROR');

  static const List<LogLevel> values = [
    debug,
    info,
    warning,
    error,
  ];

  static LogLevel fromJson(String json) => UpperCaseEnum.fromJson(values, json);
}
