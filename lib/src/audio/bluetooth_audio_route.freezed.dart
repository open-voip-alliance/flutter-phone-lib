// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'bluetooth_audio_route.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$BluetoothAudioRoute {

 String get displayName; String get identifier;
/// Create a copy of BluetoothAudioRoute
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$BluetoothAudioRouteCopyWith<BluetoothAudioRoute> get copyWith => _$BluetoothAudioRouteCopyWithImpl<BluetoothAudioRoute>(this as BluetoothAudioRoute, _$identity);

  /// Serializes this BluetoothAudioRoute to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BluetoothAudioRoute&&(identical(other.displayName, displayName) || other.displayName == displayName)&&(identical(other.identifier, identifier) || other.identifier == identifier));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,displayName,identifier);

@override
String toString() {
  return 'BluetoothAudioRoute(displayName: $displayName, identifier: $identifier)';
}


}

/// @nodoc
abstract mixin class $BluetoothAudioRouteCopyWith<$Res>  {
  factory $BluetoothAudioRouteCopyWith(BluetoothAudioRoute value, $Res Function(BluetoothAudioRoute) _then) = _$BluetoothAudioRouteCopyWithImpl;
@useResult
$Res call({
 String displayName, String identifier
});




}
/// @nodoc
class _$BluetoothAudioRouteCopyWithImpl<$Res>
    implements $BluetoothAudioRouteCopyWith<$Res> {
  _$BluetoothAudioRouteCopyWithImpl(this._self, this._then);

  final BluetoothAudioRoute _self;
  final $Res Function(BluetoothAudioRoute) _then;

/// Create a copy of BluetoothAudioRoute
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? displayName = null,Object? identifier = null,}) {
  return _then(_self.copyWith(
displayName: null == displayName ? _self.displayName : displayName // ignore: cast_nullable_to_non_nullable
as String,identifier: null == identifier ? _self.identifier : identifier // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [BluetoothAudioRoute].
extension BluetoothAudioRoutePatterns on BluetoothAudioRoute {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _BluetoothAudioRoute value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _BluetoothAudioRoute() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _BluetoothAudioRoute value)  $default,){
final _that = this;
switch (_that) {
case _BluetoothAudioRoute():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _BluetoothAudioRoute value)?  $default,){
final _that = this;
switch (_that) {
case _BluetoothAudioRoute() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String displayName,  String identifier)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _BluetoothAudioRoute() when $default != null:
return $default(_that.displayName,_that.identifier);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String displayName,  String identifier)  $default,) {final _that = this;
switch (_that) {
case _BluetoothAudioRoute():
return $default(_that.displayName,_that.identifier);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String displayName,  String identifier)?  $default,) {final _that = this;
switch (_that) {
case _BluetoothAudioRoute() when $default != null:
return $default(_that.displayName,_that.identifier);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _BluetoothAudioRoute implements BluetoothAudioRoute {
  const _BluetoothAudioRoute({required this.displayName, required this.identifier});
  factory _BluetoothAudioRoute.fromJson(Map<String, dynamic> json) => _$BluetoothAudioRouteFromJson(json);

@override final  String displayName;
@override final  String identifier;

/// Create a copy of BluetoothAudioRoute
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$BluetoothAudioRouteCopyWith<_BluetoothAudioRoute> get copyWith => __$BluetoothAudioRouteCopyWithImpl<_BluetoothAudioRoute>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$BluetoothAudioRouteToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _BluetoothAudioRoute&&(identical(other.displayName, displayName) || other.displayName == displayName)&&(identical(other.identifier, identifier) || other.identifier == identifier));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,displayName,identifier);

@override
String toString() {
  return 'BluetoothAudioRoute(displayName: $displayName, identifier: $identifier)';
}


}

/// @nodoc
abstract mixin class _$BluetoothAudioRouteCopyWith<$Res> implements $BluetoothAudioRouteCopyWith<$Res> {
  factory _$BluetoothAudioRouteCopyWith(_BluetoothAudioRoute value, $Res Function(_BluetoothAudioRoute) _then) = __$BluetoothAudioRouteCopyWithImpl;
@override @useResult
$Res call({
 String displayName, String identifier
});




}
/// @nodoc
class __$BluetoothAudioRouteCopyWithImpl<$Res>
    implements _$BluetoothAudioRouteCopyWith<$Res> {
  __$BluetoothAudioRouteCopyWithImpl(this._self, this._then);

  final _BluetoothAudioRoute _self;
  final $Res Function(_BluetoothAudioRoute) _then;

/// Create a copy of BluetoothAudioRoute
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? displayName = null,Object? identifier = null,}) {
  return _then(_BluetoothAudioRoute(
displayName: null == displayName ? _self.displayName : displayName // ignore: cast_nullable_to_non_nullable
as String,identifier: null == identifier ? _self.identifier : identifier // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
