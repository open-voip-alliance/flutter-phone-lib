import '../call/call.dart';
import '../util/equatable.dart';

class Event extends Equatable {
  const Event._();

  static Event fromJson(Map<String, dynamic> json) {
    if (json.containsKey('type')) {
      if (json.containsKey('call')) {
        final call = json['call'] != null
            ? Call.fromJson((json['call'] as Map).cast())
            : null;
        final type = json['type'];

        if (type == (OutgoingCallStarted).toString()) {
          return OutgoingCallStarted._(call);
        } else if (type == (IncomingCallReceived).toString()) {
          return IncomingCallReceived._(call);
        } else if (type == (CallEnded).toString()) {
          return CallEnded._(call);
        } else if (type == (CallUpdated).toString()) {
          return CallUpdated._(call);
        } else if (type == (CallConnected).toString()) {
          return CallConnected._(call);
        }
      }
    }

    throw UnsupportedError('Unsupported Event: $json');
  }

  // @JsonKey(ignore: true) is not needed because we don't serialize
  // this class, only deserialize.
  @override
  List<Object> get props => [];
}

class CallEvent extends Event {
  final Call call;

  const CallEvent._(this.call) : super._();

  @override
  List<Object> get props => [...super.props, call];
}

class OutgoingCallStarted extends CallEvent {
  const OutgoingCallStarted._(Call call) : super._(call);
}

class IncomingCallReceived extends CallEvent {
  const IncomingCallReceived._(Call call) : super._(call);
}

class CallEnded extends CallEvent {
  const CallEnded._(Call call) : super._(call);
}

class CallUpdated extends CallEvent {
  const CallUpdated._(Call call) : super._(call);
}

class CallConnected extends CallEvent {
  const CallConnected._(Call call) : super._(call);
}
