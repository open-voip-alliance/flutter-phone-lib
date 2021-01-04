import '../fil.dart';

class CallActions {
  Future<void> hold() => Fil.channel.invokeMethod('CallActions.hold');

  Future<void> unhold() => Fil.channel.invokeMethod('CallActions.unhold');

  Future<void> toggleHold() =>
      Fil.channel.invokeMethod('CallActions.toggleHold');

  Future<void> sendDtmf(String dtmf) =>
      Fil.channel.invokeMethod('CallActions.sendDtmf', dtmf);

  Future<void> beginAttendedTransfer(String number) =>
      Fil.channel.invokeMethod('CallActions.beginAttendedTransfer', number);

  Future<void> completeAttendedTransfer() =>
      Fil.channel.invokeMethod('CallActions.completeAttendedTransfer');

  Future<void> answer() => Fil.channel.invokeMethod('CallActions.answer');

  Future<void> decline() => Fil.channel.invokeMethod('CallActions.decline');

  Future<void> end() => Fil.channel.invokeMethod('CallActions.end');
}
