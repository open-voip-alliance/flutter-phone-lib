// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'event_freezed_prototype.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$Event {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Event);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'Event()';
}


}

/// @nodoc
class $EventCopyWith<$Res>  {
$EventCopyWith(Event _, $Res Function(Event) __);
}


/// Adds pattern-matching-related methods to [Event].
extension EventPatterns on Event {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( OutgoingCallStarted value)?  outgoingCallStarted,TResult Function( IncomingCallReceived value)?  incomingCallReceived,TResult Function( CallEnded value)?  callEnded,TResult Function( CallDurationUpdated value)?  callDurationUpdated,TResult Function( CallConnected value)?  callConnected,TResult Function( AudioStateUpdated value)?  audioStateUpdated,TResult Function( CallStateUpdated value)?  callStateUpdated,TResult Function( AttendedTransferStarted value)?  attendedTransferStarted,TResult Function( AttendedTransferConnected value)?  attendedTransferConnected,TResult Function( AttendedTransferAborted value)?  attendedTransferAborted,TResult Function( AttendedTransferEnded value)?  attendedTransferEnded,TResult Function( OutgoingCallSetupFailed value)?  outgoingCallSetupFailed,TResult Function( IncomingCallSetupFailed value)?  incomingCallSetupFailed,required TResult orElse(),}){
final _that = this;
switch (_that) {
case OutgoingCallStarted() when outgoingCallStarted != null:
return outgoingCallStarted(_that);case IncomingCallReceived() when incomingCallReceived != null:
return incomingCallReceived(_that);case CallEnded() when callEnded != null:
return callEnded(_that);case CallDurationUpdated() when callDurationUpdated != null:
return callDurationUpdated(_that);case CallConnected() when callConnected != null:
return callConnected(_that);case AudioStateUpdated() when audioStateUpdated != null:
return audioStateUpdated(_that);case CallStateUpdated() when callStateUpdated != null:
return callStateUpdated(_that);case AttendedTransferStarted() when attendedTransferStarted != null:
return attendedTransferStarted(_that);case AttendedTransferConnected() when attendedTransferConnected != null:
return attendedTransferConnected(_that);case AttendedTransferAborted() when attendedTransferAborted != null:
return attendedTransferAborted(_that);case AttendedTransferEnded() when attendedTransferEnded != null:
return attendedTransferEnded(_that);case OutgoingCallSetupFailed() when outgoingCallSetupFailed != null:
return outgoingCallSetupFailed(_that);case IncomingCallSetupFailed() when incomingCallSetupFailed != null:
return incomingCallSetupFailed(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( OutgoingCallStarted value)  outgoingCallStarted,required TResult Function( IncomingCallReceived value)  incomingCallReceived,required TResult Function( CallEnded value)  callEnded,required TResult Function( CallDurationUpdated value)  callDurationUpdated,required TResult Function( CallConnected value)  callConnected,required TResult Function( AudioStateUpdated value)  audioStateUpdated,required TResult Function( CallStateUpdated value)  callStateUpdated,required TResult Function( AttendedTransferStarted value)  attendedTransferStarted,required TResult Function( AttendedTransferConnected value)  attendedTransferConnected,required TResult Function( AttendedTransferAborted value)  attendedTransferAborted,required TResult Function( AttendedTransferEnded value)  attendedTransferEnded,required TResult Function( OutgoingCallSetupFailed value)  outgoingCallSetupFailed,required TResult Function( IncomingCallSetupFailed value)  incomingCallSetupFailed,}){
final _that = this;
switch (_that) {
case OutgoingCallStarted():
return outgoingCallStarted(_that);case IncomingCallReceived():
return incomingCallReceived(_that);case CallEnded():
return callEnded(_that);case CallDurationUpdated():
return callDurationUpdated(_that);case CallConnected():
return callConnected(_that);case AudioStateUpdated():
return audioStateUpdated(_that);case CallStateUpdated():
return callStateUpdated(_that);case AttendedTransferStarted():
return attendedTransferStarted(_that);case AttendedTransferConnected():
return attendedTransferConnected(_that);case AttendedTransferAborted():
return attendedTransferAborted(_that);case AttendedTransferEnded():
return attendedTransferEnded(_that);case OutgoingCallSetupFailed():
return outgoingCallSetupFailed(_that);case IncomingCallSetupFailed():
return incomingCallSetupFailed(_that);}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( OutgoingCallStarted value)?  outgoingCallStarted,TResult? Function( IncomingCallReceived value)?  incomingCallReceived,TResult? Function( CallEnded value)?  callEnded,TResult? Function( CallDurationUpdated value)?  callDurationUpdated,TResult? Function( CallConnected value)?  callConnected,TResult? Function( AudioStateUpdated value)?  audioStateUpdated,TResult? Function( CallStateUpdated value)?  callStateUpdated,TResult? Function( AttendedTransferStarted value)?  attendedTransferStarted,TResult? Function( AttendedTransferConnected value)?  attendedTransferConnected,TResult? Function( AttendedTransferAborted value)?  attendedTransferAborted,TResult? Function( AttendedTransferEnded value)?  attendedTransferEnded,TResult? Function( OutgoingCallSetupFailed value)?  outgoingCallSetupFailed,TResult? Function( IncomingCallSetupFailed value)?  incomingCallSetupFailed,}){
final _that = this;
switch (_that) {
case OutgoingCallStarted() when outgoingCallStarted != null:
return outgoingCallStarted(_that);case IncomingCallReceived() when incomingCallReceived != null:
return incomingCallReceived(_that);case CallEnded() when callEnded != null:
return callEnded(_that);case CallDurationUpdated() when callDurationUpdated != null:
return callDurationUpdated(_that);case CallConnected() when callConnected != null:
return callConnected(_that);case AudioStateUpdated() when audioStateUpdated != null:
return audioStateUpdated(_that);case CallStateUpdated() when callStateUpdated != null:
return callStateUpdated(_that);case AttendedTransferStarted() when attendedTransferStarted != null:
return attendedTransferStarted(_that);case AttendedTransferConnected() when attendedTransferConnected != null:
return attendedTransferConnected(_that);case AttendedTransferAborted() when attendedTransferAborted != null:
return attendedTransferAborted(_that);case AttendedTransferEnded() when attendedTransferEnded != null:
return attendedTransferEnded(_that);case OutgoingCallSetupFailed() when outgoingCallSetupFailed != null:
return outgoingCallSetupFailed(_that);case IncomingCallSetupFailed() when incomingCallSetupFailed != null:
return incomingCallSetupFailed(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( CallSessionState? state)?  outgoingCallStarted,TResult Function( CallSessionState? state)?  incomingCallReceived,TResult Function( CallSessionState? state)?  callEnded,TResult Function( CallSessionState? state)?  callDurationUpdated,TResult Function( CallSessionState? state)?  callConnected,TResult Function( CallSessionState? state)?  audioStateUpdated,TResult Function( CallSessionState? state)?  callStateUpdated,TResult Function( CallSessionState? state)?  attendedTransferStarted,TResult Function( CallSessionState? state)?  attendedTransferConnected,TResult Function( CallSessionState? state)?  attendedTransferAborted,TResult Function( CallSessionState? state)?  attendedTransferEnded,TResult Function( Reason reason)?  outgoingCallSetupFailed,TResult Function( Reason reason)?  incomingCallSetupFailed,required TResult orElse(),}) {final _that = this;
switch (_that) {
case OutgoingCallStarted() when outgoingCallStarted != null:
return outgoingCallStarted(_that.state);case IncomingCallReceived() when incomingCallReceived != null:
return incomingCallReceived(_that.state);case CallEnded() when callEnded != null:
return callEnded(_that.state);case CallDurationUpdated() when callDurationUpdated != null:
return callDurationUpdated(_that.state);case CallConnected() when callConnected != null:
return callConnected(_that.state);case AudioStateUpdated() when audioStateUpdated != null:
return audioStateUpdated(_that.state);case CallStateUpdated() when callStateUpdated != null:
return callStateUpdated(_that.state);case AttendedTransferStarted() when attendedTransferStarted != null:
return attendedTransferStarted(_that.state);case AttendedTransferConnected() when attendedTransferConnected != null:
return attendedTransferConnected(_that.state);case AttendedTransferAborted() when attendedTransferAborted != null:
return attendedTransferAborted(_that.state);case AttendedTransferEnded() when attendedTransferEnded != null:
return attendedTransferEnded(_that.state);case OutgoingCallSetupFailed() when outgoingCallSetupFailed != null:
return outgoingCallSetupFailed(_that.reason);case IncomingCallSetupFailed() when incomingCallSetupFailed != null:
return incomingCallSetupFailed(_that.reason);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( CallSessionState? state)  outgoingCallStarted,required TResult Function( CallSessionState? state)  incomingCallReceived,required TResult Function( CallSessionState? state)  callEnded,required TResult Function( CallSessionState? state)  callDurationUpdated,required TResult Function( CallSessionState? state)  callConnected,required TResult Function( CallSessionState? state)  audioStateUpdated,required TResult Function( CallSessionState? state)  callStateUpdated,required TResult Function( CallSessionState? state)  attendedTransferStarted,required TResult Function( CallSessionState? state)  attendedTransferConnected,required TResult Function( CallSessionState? state)  attendedTransferAborted,required TResult Function( CallSessionState? state)  attendedTransferEnded,required TResult Function( Reason reason)  outgoingCallSetupFailed,required TResult Function( Reason reason)  incomingCallSetupFailed,}) {final _that = this;
switch (_that) {
case OutgoingCallStarted():
return outgoingCallStarted(_that.state);case IncomingCallReceived():
return incomingCallReceived(_that.state);case CallEnded():
return callEnded(_that.state);case CallDurationUpdated():
return callDurationUpdated(_that.state);case CallConnected():
return callConnected(_that.state);case AudioStateUpdated():
return audioStateUpdated(_that.state);case CallStateUpdated():
return callStateUpdated(_that.state);case AttendedTransferStarted():
return attendedTransferStarted(_that.state);case AttendedTransferConnected():
return attendedTransferConnected(_that.state);case AttendedTransferAborted():
return attendedTransferAborted(_that.state);case AttendedTransferEnded():
return attendedTransferEnded(_that.state);case OutgoingCallSetupFailed():
return outgoingCallSetupFailed(_that.reason);case IncomingCallSetupFailed():
return incomingCallSetupFailed(_that.reason);}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( CallSessionState? state)?  outgoingCallStarted,TResult? Function( CallSessionState? state)?  incomingCallReceived,TResult? Function( CallSessionState? state)?  callEnded,TResult? Function( CallSessionState? state)?  callDurationUpdated,TResult? Function( CallSessionState? state)?  callConnected,TResult? Function( CallSessionState? state)?  audioStateUpdated,TResult? Function( CallSessionState? state)?  callStateUpdated,TResult? Function( CallSessionState? state)?  attendedTransferStarted,TResult? Function( CallSessionState? state)?  attendedTransferConnected,TResult? Function( CallSessionState? state)?  attendedTransferAborted,TResult? Function( CallSessionState? state)?  attendedTransferEnded,TResult? Function( Reason reason)?  outgoingCallSetupFailed,TResult? Function( Reason reason)?  incomingCallSetupFailed,}) {final _that = this;
switch (_that) {
case OutgoingCallStarted() when outgoingCallStarted != null:
return outgoingCallStarted(_that.state);case IncomingCallReceived() when incomingCallReceived != null:
return incomingCallReceived(_that.state);case CallEnded() when callEnded != null:
return callEnded(_that.state);case CallDurationUpdated() when callDurationUpdated != null:
return callDurationUpdated(_that.state);case CallConnected() when callConnected != null:
return callConnected(_that.state);case AudioStateUpdated() when audioStateUpdated != null:
return audioStateUpdated(_that.state);case CallStateUpdated() when callStateUpdated != null:
return callStateUpdated(_that.state);case AttendedTransferStarted() when attendedTransferStarted != null:
return attendedTransferStarted(_that.state);case AttendedTransferConnected() when attendedTransferConnected != null:
return attendedTransferConnected(_that.state);case AttendedTransferAborted() when attendedTransferAborted != null:
return attendedTransferAborted(_that.state);case AttendedTransferEnded() when attendedTransferEnded != null:
return attendedTransferEnded(_that.state);case OutgoingCallSetupFailed() when outgoingCallSetupFailed != null:
return outgoingCallSetupFailed(_that.reason);case IncomingCallSetupFailed() when incomingCallSetupFailed != null:
return incomingCallSetupFailed(_that.reason);case _:
  return null;

}
}

}

/// @nodoc


class OutgoingCallStarted extends Event implements CallSessionEvent {
  const OutgoingCallStarted({required this.state}): super._();
  

 final  CallSessionState? state;

/// Create a copy of Event
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$OutgoingCallStartedCopyWith<OutgoingCallStarted> get copyWith => _$OutgoingCallStartedCopyWithImpl<OutgoingCallStarted>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is OutgoingCallStarted&&(identical(other.state, state) || other.state == state));
}


@override
int get hashCode => Object.hash(runtimeType,state);

@override
String toString() {
  return 'Event.outgoingCallStarted(state: $state)';
}


}

/// @nodoc
abstract mixin class $OutgoingCallStartedCopyWith<$Res> implements $EventCopyWith<$Res> {
  factory $OutgoingCallStartedCopyWith(OutgoingCallStarted value, $Res Function(OutgoingCallStarted) _then) = _$OutgoingCallStartedCopyWithImpl;
@useResult
$Res call({
 CallSessionState? state
});




}
/// @nodoc
class _$OutgoingCallStartedCopyWithImpl<$Res>
    implements $OutgoingCallStartedCopyWith<$Res> {
  _$OutgoingCallStartedCopyWithImpl(this._self, this._then);

  final OutgoingCallStarted _self;
  final $Res Function(OutgoingCallStarted) _then;

/// Create a copy of Event
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? state = freezed,}) {
  return _then(OutgoingCallStarted(
state: freezed == state ? _self.state : state // ignore: cast_nullable_to_non_nullable
as CallSessionState?,
  ));
}


}

/// @nodoc


class IncomingCallReceived extends Event implements CallSessionEvent {
  const IncomingCallReceived({required this.state}): super._();
  

 final  CallSessionState? state;

/// Create a copy of Event
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$IncomingCallReceivedCopyWith<IncomingCallReceived> get copyWith => _$IncomingCallReceivedCopyWithImpl<IncomingCallReceived>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is IncomingCallReceived&&(identical(other.state, state) || other.state == state));
}


@override
int get hashCode => Object.hash(runtimeType,state);

@override
String toString() {
  return 'Event.incomingCallReceived(state: $state)';
}


}

/// @nodoc
abstract mixin class $IncomingCallReceivedCopyWith<$Res> implements $EventCopyWith<$Res> {
  factory $IncomingCallReceivedCopyWith(IncomingCallReceived value, $Res Function(IncomingCallReceived) _then) = _$IncomingCallReceivedCopyWithImpl;
@useResult
$Res call({
 CallSessionState? state
});




}
/// @nodoc
class _$IncomingCallReceivedCopyWithImpl<$Res>
    implements $IncomingCallReceivedCopyWith<$Res> {
  _$IncomingCallReceivedCopyWithImpl(this._self, this._then);

  final IncomingCallReceived _self;
  final $Res Function(IncomingCallReceived) _then;

/// Create a copy of Event
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? state = freezed,}) {
  return _then(IncomingCallReceived(
state: freezed == state ? _self.state : state // ignore: cast_nullable_to_non_nullable
as CallSessionState?,
  ));
}


}

/// @nodoc


class CallEnded extends Event implements CallSessionEvent {
  const CallEnded({required this.state}): super._();
  

 final  CallSessionState? state;

/// Create a copy of Event
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CallEndedCopyWith<CallEnded> get copyWith => _$CallEndedCopyWithImpl<CallEnded>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CallEnded&&(identical(other.state, state) || other.state == state));
}


@override
int get hashCode => Object.hash(runtimeType,state);

@override
String toString() {
  return 'Event.callEnded(state: $state)';
}


}

/// @nodoc
abstract mixin class $CallEndedCopyWith<$Res> implements $EventCopyWith<$Res> {
  factory $CallEndedCopyWith(CallEnded value, $Res Function(CallEnded) _then) = _$CallEndedCopyWithImpl;
@useResult
$Res call({
 CallSessionState? state
});




}
/// @nodoc
class _$CallEndedCopyWithImpl<$Res>
    implements $CallEndedCopyWith<$Res> {
  _$CallEndedCopyWithImpl(this._self, this._then);

  final CallEnded _self;
  final $Res Function(CallEnded) _then;

/// Create a copy of Event
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? state = freezed,}) {
  return _then(CallEnded(
state: freezed == state ? _self.state : state // ignore: cast_nullable_to_non_nullable
as CallSessionState?,
  ));
}


}

/// @nodoc


class CallDurationUpdated extends Event implements CallSessionEvent {
  const CallDurationUpdated({required this.state}): super._();
  

 final  CallSessionState? state;

/// Create a copy of Event
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CallDurationUpdatedCopyWith<CallDurationUpdated> get copyWith => _$CallDurationUpdatedCopyWithImpl<CallDurationUpdated>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CallDurationUpdated&&(identical(other.state, state) || other.state == state));
}


@override
int get hashCode => Object.hash(runtimeType,state);

@override
String toString() {
  return 'Event.callDurationUpdated(state: $state)';
}


}

/// @nodoc
abstract mixin class $CallDurationUpdatedCopyWith<$Res> implements $EventCopyWith<$Res> {
  factory $CallDurationUpdatedCopyWith(CallDurationUpdated value, $Res Function(CallDurationUpdated) _then) = _$CallDurationUpdatedCopyWithImpl;
@useResult
$Res call({
 CallSessionState? state
});




}
/// @nodoc
class _$CallDurationUpdatedCopyWithImpl<$Res>
    implements $CallDurationUpdatedCopyWith<$Res> {
  _$CallDurationUpdatedCopyWithImpl(this._self, this._then);

  final CallDurationUpdated _self;
  final $Res Function(CallDurationUpdated) _then;

/// Create a copy of Event
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? state = freezed,}) {
  return _then(CallDurationUpdated(
state: freezed == state ? _self.state : state // ignore: cast_nullable_to_non_nullable
as CallSessionState?,
  ));
}


}

/// @nodoc


class CallConnected extends Event implements CallSessionEvent {
  const CallConnected({required this.state}): super._();
  

 final  CallSessionState? state;

/// Create a copy of Event
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CallConnectedCopyWith<CallConnected> get copyWith => _$CallConnectedCopyWithImpl<CallConnected>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CallConnected&&(identical(other.state, state) || other.state == state));
}


@override
int get hashCode => Object.hash(runtimeType,state);

@override
String toString() {
  return 'Event.callConnected(state: $state)';
}


}

/// @nodoc
abstract mixin class $CallConnectedCopyWith<$Res> implements $EventCopyWith<$Res> {
  factory $CallConnectedCopyWith(CallConnected value, $Res Function(CallConnected) _then) = _$CallConnectedCopyWithImpl;
@useResult
$Res call({
 CallSessionState? state
});




}
/// @nodoc
class _$CallConnectedCopyWithImpl<$Res>
    implements $CallConnectedCopyWith<$Res> {
  _$CallConnectedCopyWithImpl(this._self, this._then);

  final CallConnected _self;
  final $Res Function(CallConnected) _then;

/// Create a copy of Event
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? state = freezed,}) {
  return _then(CallConnected(
state: freezed == state ? _self.state : state // ignore: cast_nullable_to_non_nullable
as CallSessionState?,
  ));
}


}

/// @nodoc


class AudioStateUpdated extends Event implements CallSessionEvent {
  const AudioStateUpdated({required this.state}): super._();
  

 final  CallSessionState? state;

/// Create a copy of Event
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AudioStateUpdatedCopyWith<AudioStateUpdated> get copyWith => _$AudioStateUpdatedCopyWithImpl<AudioStateUpdated>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AudioStateUpdated&&(identical(other.state, state) || other.state == state));
}


@override
int get hashCode => Object.hash(runtimeType,state);

@override
String toString() {
  return 'Event.audioStateUpdated(state: $state)';
}


}

/// @nodoc
abstract mixin class $AudioStateUpdatedCopyWith<$Res> implements $EventCopyWith<$Res> {
  factory $AudioStateUpdatedCopyWith(AudioStateUpdated value, $Res Function(AudioStateUpdated) _then) = _$AudioStateUpdatedCopyWithImpl;
@useResult
$Res call({
 CallSessionState? state
});




}
/// @nodoc
class _$AudioStateUpdatedCopyWithImpl<$Res>
    implements $AudioStateUpdatedCopyWith<$Res> {
  _$AudioStateUpdatedCopyWithImpl(this._self, this._then);

  final AudioStateUpdated _self;
  final $Res Function(AudioStateUpdated) _then;

/// Create a copy of Event
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? state = freezed,}) {
  return _then(AudioStateUpdated(
state: freezed == state ? _self.state : state // ignore: cast_nullable_to_non_nullable
as CallSessionState?,
  ));
}


}

/// @nodoc


class CallStateUpdated extends Event implements CallSessionEvent {
  const CallStateUpdated({required this.state}): super._();
  

 final  CallSessionState? state;

/// Create a copy of Event
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CallStateUpdatedCopyWith<CallStateUpdated> get copyWith => _$CallStateUpdatedCopyWithImpl<CallStateUpdated>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CallStateUpdated&&(identical(other.state, state) || other.state == state));
}


@override
int get hashCode => Object.hash(runtimeType,state);

@override
String toString() {
  return 'Event.callStateUpdated(state: $state)';
}


}

/// @nodoc
abstract mixin class $CallStateUpdatedCopyWith<$Res> implements $EventCopyWith<$Res> {
  factory $CallStateUpdatedCopyWith(CallStateUpdated value, $Res Function(CallStateUpdated) _then) = _$CallStateUpdatedCopyWithImpl;
@useResult
$Res call({
 CallSessionState? state
});




}
/// @nodoc
class _$CallStateUpdatedCopyWithImpl<$Res>
    implements $CallStateUpdatedCopyWith<$Res> {
  _$CallStateUpdatedCopyWithImpl(this._self, this._then);

  final CallStateUpdated _self;
  final $Res Function(CallStateUpdated) _then;

/// Create a copy of Event
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? state = freezed,}) {
  return _then(CallStateUpdated(
state: freezed == state ? _self.state : state // ignore: cast_nullable_to_non_nullable
as CallSessionState?,
  ));
}


}

/// @nodoc


class AttendedTransferStarted extends Event implements AttendedTransferEvent {
  const AttendedTransferStarted({required this.state}): super._();
  

 final  CallSessionState? state;

/// Create a copy of Event
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AttendedTransferStartedCopyWith<AttendedTransferStarted> get copyWith => _$AttendedTransferStartedCopyWithImpl<AttendedTransferStarted>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AttendedTransferStarted&&(identical(other.state, state) || other.state == state));
}


@override
int get hashCode => Object.hash(runtimeType,state);

@override
String toString() {
  return 'Event.attendedTransferStarted(state: $state)';
}


}

/// @nodoc
abstract mixin class $AttendedTransferStartedCopyWith<$Res> implements $EventCopyWith<$Res> {
  factory $AttendedTransferStartedCopyWith(AttendedTransferStarted value, $Res Function(AttendedTransferStarted) _then) = _$AttendedTransferStartedCopyWithImpl;
@useResult
$Res call({
 CallSessionState? state
});




}
/// @nodoc
class _$AttendedTransferStartedCopyWithImpl<$Res>
    implements $AttendedTransferStartedCopyWith<$Res> {
  _$AttendedTransferStartedCopyWithImpl(this._self, this._then);

  final AttendedTransferStarted _self;
  final $Res Function(AttendedTransferStarted) _then;

/// Create a copy of Event
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? state = freezed,}) {
  return _then(AttendedTransferStarted(
state: freezed == state ? _self.state : state // ignore: cast_nullable_to_non_nullable
as CallSessionState?,
  ));
}


}

/// @nodoc


class AttendedTransferConnected extends Event implements AttendedTransferEvent {
  const AttendedTransferConnected({required this.state}): super._();
  

 final  CallSessionState? state;

/// Create a copy of Event
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AttendedTransferConnectedCopyWith<AttendedTransferConnected> get copyWith => _$AttendedTransferConnectedCopyWithImpl<AttendedTransferConnected>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AttendedTransferConnected&&(identical(other.state, state) || other.state == state));
}


@override
int get hashCode => Object.hash(runtimeType,state);

@override
String toString() {
  return 'Event.attendedTransferConnected(state: $state)';
}


}

/// @nodoc
abstract mixin class $AttendedTransferConnectedCopyWith<$Res> implements $EventCopyWith<$Res> {
  factory $AttendedTransferConnectedCopyWith(AttendedTransferConnected value, $Res Function(AttendedTransferConnected) _then) = _$AttendedTransferConnectedCopyWithImpl;
@useResult
$Res call({
 CallSessionState? state
});




}
/// @nodoc
class _$AttendedTransferConnectedCopyWithImpl<$Res>
    implements $AttendedTransferConnectedCopyWith<$Res> {
  _$AttendedTransferConnectedCopyWithImpl(this._self, this._then);

  final AttendedTransferConnected _self;
  final $Res Function(AttendedTransferConnected) _then;

/// Create a copy of Event
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? state = freezed,}) {
  return _then(AttendedTransferConnected(
state: freezed == state ? _self.state : state // ignore: cast_nullable_to_non_nullable
as CallSessionState?,
  ));
}


}

/// @nodoc


class AttendedTransferAborted extends Event implements AttendedTransferEvent {
  const AttendedTransferAborted({required this.state}): super._();
  

 final  CallSessionState? state;

/// Create a copy of Event
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AttendedTransferAbortedCopyWith<AttendedTransferAborted> get copyWith => _$AttendedTransferAbortedCopyWithImpl<AttendedTransferAborted>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AttendedTransferAborted&&(identical(other.state, state) || other.state == state));
}


@override
int get hashCode => Object.hash(runtimeType,state);

@override
String toString() {
  return 'Event.attendedTransferAborted(state: $state)';
}


}

/// @nodoc
abstract mixin class $AttendedTransferAbortedCopyWith<$Res> implements $EventCopyWith<$Res> {
  factory $AttendedTransferAbortedCopyWith(AttendedTransferAborted value, $Res Function(AttendedTransferAborted) _then) = _$AttendedTransferAbortedCopyWithImpl;
@useResult
$Res call({
 CallSessionState? state
});




}
/// @nodoc
class _$AttendedTransferAbortedCopyWithImpl<$Res>
    implements $AttendedTransferAbortedCopyWith<$Res> {
  _$AttendedTransferAbortedCopyWithImpl(this._self, this._then);

  final AttendedTransferAborted _self;
  final $Res Function(AttendedTransferAborted) _then;

/// Create a copy of Event
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? state = freezed,}) {
  return _then(AttendedTransferAborted(
state: freezed == state ? _self.state : state // ignore: cast_nullable_to_non_nullable
as CallSessionState?,
  ));
}


}

/// @nodoc


class AttendedTransferEnded extends Event implements AttendedTransferEvent {
  const AttendedTransferEnded({required this.state}): super._();
  

 final  CallSessionState? state;

/// Create a copy of Event
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AttendedTransferEndedCopyWith<AttendedTransferEnded> get copyWith => _$AttendedTransferEndedCopyWithImpl<AttendedTransferEnded>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AttendedTransferEnded&&(identical(other.state, state) || other.state == state));
}


@override
int get hashCode => Object.hash(runtimeType,state);

@override
String toString() {
  return 'Event.attendedTransferEnded(state: $state)';
}


}

/// @nodoc
abstract mixin class $AttendedTransferEndedCopyWith<$Res> implements $EventCopyWith<$Res> {
  factory $AttendedTransferEndedCopyWith(AttendedTransferEnded value, $Res Function(AttendedTransferEnded) _then) = _$AttendedTransferEndedCopyWithImpl;
@useResult
$Res call({
 CallSessionState? state
});




}
/// @nodoc
class _$AttendedTransferEndedCopyWithImpl<$Res>
    implements $AttendedTransferEndedCopyWith<$Res> {
  _$AttendedTransferEndedCopyWithImpl(this._self, this._then);

  final AttendedTransferEnded _self;
  final $Res Function(AttendedTransferEnded) _then;

/// Create a copy of Event
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? state = freezed,}) {
  return _then(AttendedTransferEnded(
state: freezed == state ? _self.state : state // ignore: cast_nullable_to_non_nullable
as CallSessionState?,
  ));
}


}

/// @nodoc


class OutgoingCallSetupFailed extends Event implements CallSetupFailedEvent {
  const OutgoingCallSetupFailed({required this.reason}): super._();
  

 final  Reason reason;

/// Create a copy of Event
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$OutgoingCallSetupFailedCopyWith<OutgoingCallSetupFailed> get copyWith => _$OutgoingCallSetupFailedCopyWithImpl<OutgoingCallSetupFailed>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is OutgoingCallSetupFailed&&(identical(other.reason, reason) || other.reason == reason));
}


@override
int get hashCode => Object.hash(runtimeType,reason);

@override
String toString() {
  return 'Event.outgoingCallSetupFailed(reason: $reason)';
}


}

/// @nodoc
abstract mixin class $OutgoingCallSetupFailedCopyWith<$Res> implements $EventCopyWith<$Res> {
  factory $OutgoingCallSetupFailedCopyWith(OutgoingCallSetupFailed value, $Res Function(OutgoingCallSetupFailed) _then) = _$OutgoingCallSetupFailedCopyWithImpl;
@useResult
$Res call({
 Reason reason
});




}
/// @nodoc
class _$OutgoingCallSetupFailedCopyWithImpl<$Res>
    implements $OutgoingCallSetupFailedCopyWith<$Res> {
  _$OutgoingCallSetupFailedCopyWithImpl(this._self, this._then);

  final OutgoingCallSetupFailed _self;
  final $Res Function(OutgoingCallSetupFailed) _then;

/// Create a copy of Event
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? reason = null,}) {
  return _then(OutgoingCallSetupFailed(
reason: null == reason ? _self.reason : reason // ignore: cast_nullable_to_non_nullable
as Reason,
  ));
}


}

/// @nodoc


class IncomingCallSetupFailed extends Event implements CallSetupFailedEvent {
  const IncomingCallSetupFailed({required this.reason}): super._();
  

 final  Reason reason;

/// Create a copy of Event
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$IncomingCallSetupFailedCopyWith<IncomingCallSetupFailed> get copyWith => _$IncomingCallSetupFailedCopyWithImpl<IncomingCallSetupFailed>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is IncomingCallSetupFailed&&(identical(other.reason, reason) || other.reason == reason));
}


@override
int get hashCode => Object.hash(runtimeType,reason);

@override
String toString() {
  return 'Event.incomingCallSetupFailed(reason: $reason)';
}


}

/// @nodoc
abstract mixin class $IncomingCallSetupFailedCopyWith<$Res> implements $EventCopyWith<$Res> {
  factory $IncomingCallSetupFailedCopyWith(IncomingCallSetupFailed value, $Res Function(IncomingCallSetupFailed) _then) = _$IncomingCallSetupFailedCopyWithImpl;
@useResult
$Res call({
 Reason reason
});




}
/// @nodoc
class _$IncomingCallSetupFailedCopyWithImpl<$Res>
    implements $IncomingCallSetupFailedCopyWith<$Res> {
  _$IncomingCallSetupFailedCopyWithImpl(this._self, this._then);

  final IncomingCallSetupFailed _self;
  final $Res Function(IncomingCallSetupFailed) _then;

/// Create a copy of Event
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? reason = null,}) {
  return _then(IncomingCallSetupFailed(
reason: null == reason ? _self.reason : reason // ignore: cast_nullable_to_non_nullable
as Reason,
  ));
}


}

// dart format on
