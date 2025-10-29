// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'call.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Call {

 String get remoteNumber; String get displayName;@CallStateConverter() CallState get state;@CallDirectionConverter() CallDirection get direction; int get duration; bool get isOnHold; String get uuid; double get mos; double get currentMos; Contact? get contact; String get remotePartyHeading; String get remotePartySubheading; String get prettyDuration; String get callId; String get reason;
/// Create a copy of Call
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CallCopyWith<Call> get copyWith => _$CallCopyWithImpl<Call>(this as Call, _$identity);

  /// Serializes this Call to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Call&&(identical(other.remoteNumber, remoteNumber) || other.remoteNumber == remoteNumber)&&(identical(other.displayName, displayName) || other.displayName == displayName)&&(identical(other.state, state) || other.state == state)&&(identical(other.direction, direction) || other.direction == direction)&&(identical(other.duration, duration) || other.duration == duration)&&(identical(other.isOnHold, isOnHold) || other.isOnHold == isOnHold)&&(identical(other.uuid, uuid) || other.uuid == uuid)&&(identical(other.mos, mos) || other.mos == mos)&&(identical(other.currentMos, currentMos) || other.currentMos == currentMos)&&(identical(other.contact, contact) || other.contact == contact)&&(identical(other.remotePartyHeading, remotePartyHeading) || other.remotePartyHeading == remotePartyHeading)&&(identical(other.remotePartySubheading, remotePartySubheading) || other.remotePartySubheading == remotePartySubheading)&&(identical(other.prettyDuration, prettyDuration) || other.prettyDuration == prettyDuration)&&(identical(other.callId, callId) || other.callId == callId)&&(identical(other.reason, reason) || other.reason == reason));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,remoteNumber,displayName,state,direction,duration,isOnHold,uuid,mos,currentMos,contact,remotePartyHeading,remotePartySubheading,prettyDuration,callId,reason);

@override
String toString() {
  return 'Call(remoteNumber: $remoteNumber, displayName: $displayName, state: $state, direction: $direction, duration: $duration, isOnHold: $isOnHold, uuid: $uuid, mos: $mos, currentMos: $currentMos, contact: $contact, remotePartyHeading: $remotePartyHeading, remotePartySubheading: $remotePartySubheading, prettyDuration: $prettyDuration, callId: $callId, reason: $reason)';
}


}

/// @nodoc
abstract mixin class $CallCopyWith<$Res>  {
  factory $CallCopyWith(Call value, $Res Function(Call) _then) = _$CallCopyWithImpl;
@useResult
$Res call({
 String remoteNumber, String displayName,@CallStateConverter() CallState state,@CallDirectionConverter() CallDirection direction, int duration, bool isOnHold, String uuid, double mos, double currentMos, Contact? contact, String remotePartyHeading, String remotePartySubheading, String prettyDuration, String callId, String reason
});




}
/// @nodoc
class _$CallCopyWithImpl<$Res>
    implements $CallCopyWith<$Res> {
  _$CallCopyWithImpl(this._self, this._then);

  final Call _self;
  final $Res Function(Call) _then;

/// Create a copy of Call
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? remoteNumber = null,Object? displayName = null,Object? state = null,Object? direction = null,Object? duration = null,Object? isOnHold = null,Object? uuid = null,Object? mos = null,Object? currentMos = null,Object? contact = freezed,Object? remotePartyHeading = null,Object? remotePartySubheading = null,Object? prettyDuration = null,Object? callId = null,Object? reason = null,}) {
  return _then(_self.copyWith(
remoteNumber: null == remoteNumber ? _self.remoteNumber : remoteNumber // ignore: cast_nullable_to_non_nullable
as String,displayName: null == displayName ? _self.displayName : displayName // ignore: cast_nullable_to_non_nullable
as String,state: null == state ? _self.state : state // ignore: cast_nullable_to_non_nullable
as CallState,direction: null == direction ? _self.direction : direction // ignore: cast_nullable_to_non_nullable
as CallDirection,duration: null == duration ? _self.duration : duration // ignore: cast_nullable_to_non_nullable
as int,isOnHold: null == isOnHold ? _self.isOnHold : isOnHold // ignore: cast_nullable_to_non_nullable
as bool,uuid: null == uuid ? _self.uuid : uuid // ignore: cast_nullable_to_non_nullable
as String,mos: null == mos ? _self.mos : mos // ignore: cast_nullable_to_non_nullable
as double,currentMos: null == currentMos ? _self.currentMos : currentMos // ignore: cast_nullable_to_non_nullable
as double,contact: freezed == contact ? _self.contact : contact // ignore: cast_nullable_to_non_nullable
as Contact?,remotePartyHeading: null == remotePartyHeading ? _self.remotePartyHeading : remotePartyHeading // ignore: cast_nullable_to_non_nullable
as String,remotePartySubheading: null == remotePartySubheading ? _self.remotePartySubheading : remotePartySubheading // ignore: cast_nullable_to_non_nullable
as String,prettyDuration: null == prettyDuration ? _self.prettyDuration : prettyDuration // ignore: cast_nullable_to_non_nullable
as String,callId: null == callId ? _self.callId : callId // ignore: cast_nullable_to_non_nullable
as String,reason: null == reason ? _self.reason : reason // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [Call].
extension CallPatterns on Call {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Call value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Call() when $default != null:
return $default(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Call value)  $default,){
final _that = this;
switch (_that) {
case _Call():
return $default(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Call value)?  $default,){
final _that = this;
switch (_that) {
case _Call() when $default != null:
return $default(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String remoteNumber,  String displayName, @CallStateConverter()  CallState state, @CallDirectionConverter()  CallDirection direction,  int duration,  bool isOnHold,  String uuid,  double mos,  double currentMos,  Contact? contact,  String remotePartyHeading,  String remotePartySubheading,  String prettyDuration,  String callId,  String reason)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Call() when $default != null:
return $default(_that.remoteNumber,_that.displayName,_that.state,_that.direction,_that.duration,_that.isOnHold,_that.uuid,_that.mos,_that.currentMos,_that.contact,_that.remotePartyHeading,_that.remotePartySubheading,_that.prettyDuration,_that.callId,_that.reason);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String remoteNumber,  String displayName, @CallStateConverter()  CallState state, @CallDirectionConverter()  CallDirection direction,  int duration,  bool isOnHold,  String uuid,  double mos,  double currentMos,  Contact? contact,  String remotePartyHeading,  String remotePartySubheading,  String prettyDuration,  String callId,  String reason)  $default,) {final _that = this;
switch (_that) {
case _Call():
return $default(_that.remoteNumber,_that.displayName,_that.state,_that.direction,_that.duration,_that.isOnHold,_that.uuid,_that.mos,_that.currentMos,_that.contact,_that.remotePartyHeading,_that.remotePartySubheading,_that.prettyDuration,_that.callId,_that.reason);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String remoteNumber,  String displayName, @CallStateConverter()  CallState state, @CallDirectionConverter()  CallDirection direction,  int duration,  bool isOnHold,  String uuid,  double mos,  double currentMos,  Contact? contact,  String remotePartyHeading,  String remotePartySubheading,  String prettyDuration,  String callId,  String reason)?  $default,) {final _that = this;
switch (_that) {
case _Call() when $default != null:
return $default(_that.remoteNumber,_that.displayName,_that.state,_that.direction,_that.duration,_that.isOnHold,_that.uuid,_that.mos,_that.currentMos,_that.contact,_that.remotePartyHeading,_that.remotePartySubheading,_that.prettyDuration,_that.callId,_that.reason);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Call implements Call {
  const _Call({required this.remoteNumber, required this.displayName, @CallStateConverter() required this.state, @CallDirectionConverter() required this.direction, required this.duration, required this.isOnHold, required this.uuid, required this.mos, required this.currentMos, this.contact, required this.remotePartyHeading, required this.remotePartySubheading, required this.prettyDuration, required this.callId, required this.reason});
  factory _Call.fromJson(Map<String, dynamic> json) => _$CallFromJson(json);

@override final  String remoteNumber;
@override final  String displayName;
@override@CallStateConverter() final  CallState state;
@override@CallDirectionConverter() final  CallDirection direction;
@override final  int duration;
@override final  bool isOnHold;
@override final  String uuid;
@override final  double mos;
@override final  double currentMos;
@override final  Contact? contact;
@override final  String remotePartyHeading;
@override final  String remotePartySubheading;
@override final  String prettyDuration;
@override final  String callId;
@override final  String reason;

/// Create a copy of Call
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CallCopyWith<_Call> get copyWith => __$CallCopyWithImpl<_Call>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CallToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Call&&(identical(other.remoteNumber, remoteNumber) || other.remoteNumber == remoteNumber)&&(identical(other.displayName, displayName) || other.displayName == displayName)&&(identical(other.state, state) || other.state == state)&&(identical(other.direction, direction) || other.direction == direction)&&(identical(other.duration, duration) || other.duration == duration)&&(identical(other.isOnHold, isOnHold) || other.isOnHold == isOnHold)&&(identical(other.uuid, uuid) || other.uuid == uuid)&&(identical(other.mos, mos) || other.mos == mos)&&(identical(other.currentMos, currentMos) || other.currentMos == currentMos)&&(identical(other.contact, contact) || other.contact == contact)&&(identical(other.remotePartyHeading, remotePartyHeading) || other.remotePartyHeading == remotePartyHeading)&&(identical(other.remotePartySubheading, remotePartySubheading) || other.remotePartySubheading == remotePartySubheading)&&(identical(other.prettyDuration, prettyDuration) || other.prettyDuration == prettyDuration)&&(identical(other.callId, callId) || other.callId == callId)&&(identical(other.reason, reason) || other.reason == reason));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,remoteNumber,displayName,state,direction,duration,isOnHold,uuid,mos,currentMos,contact,remotePartyHeading,remotePartySubheading,prettyDuration,callId,reason);

@override
String toString() {
  return 'Call(remoteNumber: $remoteNumber, displayName: $displayName, state: $state, direction: $direction, duration: $duration, isOnHold: $isOnHold, uuid: $uuid, mos: $mos, currentMos: $currentMos, contact: $contact, remotePartyHeading: $remotePartyHeading, remotePartySubheading: $remotePartySubheading, prettyDuration: $prettyDuration, callId: $callId, reason: $reason)';
}


}

/// @nodoc
abstract mixin class _$CallCopyWith<$Res> implements $CallCopyWith<$Res> {
  factory _$CallCopyWith(_Call value, $Res Function(_Call) _then) = __$CallCopyWithImpl;
@override @useResult
$Res call({
 String remoteNumber, String displayName,@CallStateConverter() CallState state,@CallDirectionConverter() CallDirection direction, int duration, bool isOnHold, String uuid, double mos, double currentMos, Contact? contact, String remotePartyHeading, String remotePartySubheading, String prettyDuration, String callId, String reason
});




}
/// @nodoc
class __$CallCopyWithImpl<$Res>
    implements _$CallCopyWith<$Res> {
  __$CallCopyWithImpl(this._self, this._then);

  final _Call _self;
  final $Res Function(_Call) _then;

/// Create a copy of Call
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? remoteNumber = null,Object? displayName = null,Object? state = null,Object? direction = null,Object? duration = null,Object? isOnHold = null,Object? uuid = null,Object? mos = null,Object? currentMos = null,Object? contact = freezed,Object? remotePartyHeading = null,Object? remotePartySubheading = null,Object? prettyDuration = null,Object? callId = null,Object? reason = null,}) {
  return _then(_Call(
remoteNumber: null == remoteNumber ? _self.remoteNumber : remoteNumber // ignore: cast_nullable_to_non_nullable
as String,displayName: null == displayName ? _self.displayName : displayName // ignore: cast_nullable_to_non_nullable
as String,state: null == state ? _self.state : state // ignore: cast_nullable_to_non_nullable
as CallState,direction: null == direction ? _self.direction : direction // ignore: cast_nullable_to_non_nullable
as CallDirection,duration: null == duration ? _self.duration : duration // ignore: cast_nullable_to_non_nullable
as int,isOnHold: null == isOnHold ? _self.isOnHold : isOnHold // ignore: cast_nullable_to_non_nullable
as bool,uuid: null == uuid ? _self.uuid : uuid // ignore: cast_nullable_to_non_nullable
as String,mos: null == mos ? _self.mos : mos // ignore: cast_nullable_to_non_nullable
as double,currentMos: null == currentMos ? _self.currentMos : currentMos // ignore: cast_nullable_to_non_nullable
as double,contact: freezed == contact ? _self.contact : contact // ignore: cast_nullable_to_non_nullable
as Contact?,remotePartyHeading: null == remotePartyHeading ? _self.remotePartyHeading : remotePartyHeading // ignore: cast_nullable_to_non_nullable
as String,remotePartySubheading: null == remotePartySubheading ? _self.remotePartySubheading : remotePartySubheading // ignore: cast_nullable_to_non_nullable
as String,prettyDuration: null == prettyDuration ? _self.prettyDuration : prettyDuration // ignore: cast_nullable_to_non_nullable
as String,callId: null == callId ? _self.callId : callId // ignore: cast_nullable_to_non_nullable
as String,reason: null == reason ? _self.reason : reason // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
