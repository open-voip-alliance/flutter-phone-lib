import '../fil.dart';
import 'fil_call.dart';

class Calls {
  Future<FilCall> get active => Fil.channel.invokeMethod('Calls.active').then(
        (map) => FilCall.fromJson((map as Map)?.cast<String, dynamic>()),
      );
}
