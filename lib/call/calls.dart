import '../phone_lib.dart';
import 'call.dart';

class Calls {
  Future<Call> get active =>
      PhoneLib.channel.invokeMethod('Calls.active').then(
            (map) => Call.fromJson((map as Map)?.cast<String, dynamic>()),
          );
}
