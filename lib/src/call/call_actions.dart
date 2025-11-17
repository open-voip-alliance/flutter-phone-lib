import '../phone_lib.dart';

class CallActions {
  Future<void> hold() => PhoneLib.channel.invokeMethod('CallActions.hold');

  Future<void> unhold() => PhoneLib.channel.invokeMethod('CallActions.unhold');

  Future<void> toggleHold() =>
      PhoneLib.channel.invokeMethod('CallActions.toggleHold');

  Future<void> sendDtmf(String dtmf, {bool playToneLocally = true}) =>
      PhoneLib.channel.invokeMethod('CallActions.sendDtmf', {
        'dtmf': dtmf,
        'playToneLocally': playToneLocally,
      });

  Future<void> beginAttendedTransfer(String number) => PhoneLib.channel
      .invokeMethod('CallActions.beginAttendedTransfer', number);

  Future<void> completeAttendedTransfer() =>
      PhoneLib.channel.invokeMethod('CallActions.completeAttendedTransfer');

  Future<void> answer() => PhoneLib.channel.invokeMethod('CallActions.answer');

  Future<void> decline() =>
      PhoneLib.channel.invokeMethod('CallActions.decline');

  Future<void> end() => PhoneLib.channel.invokeMethod('CallActions.end');
}
