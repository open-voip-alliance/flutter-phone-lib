// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'supplementary_contact.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$SupplementaryContact {

 String get number; String get name; Uri? get imageUri;
/// Create a copy of SupplementaryContact
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SupplementaryContactCopyWith<SupplementaryContact> get copyWith => _$SupplementaryContactCopyWithImpl<SupplementaryContact>(this as SupplementaryContact, _$identity);

  /// Serializes this SupplementaryContact to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SupplementaryContact&&(identical(other.number, number) || other.number == number)&&(identical(other.name, name) || other.name == name)&&(identical(other.imageUri, imageUri) || other.imageUri == imageUri));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,number,name,imageUri);

@override
String toString() {
  return 'SupplementaryContact(number: $number, name: $name, imageUri: $imageUri)';
}


}

/// @nodoc
abstract mixin class $SupplementaryContactCopyWith<$Res>  {
  factory $SupplementaryContactCopyWith(SupplementaryContact value, $Res Function(SupplementaryContact) _then) = _$SupplementaryContactCopyWithImpl;
@useResult
$Res call({
 String number, String name, Uri? imageUri
});




}
/// @nodoc
class _$SupplementaryContactCopyWithImpl<$Res>
    implements $SupplementaryContactCopyWith<$Res> {
  _$SupplementaryContactCopyWithImpl(this._self, this._then);

  final SupplementaryContact _self;
  final $Res Function(SupplementaryContact) _then;

/// Create a copy of SupplementaryContact
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? number = null,Object? name = null,Object? imageUri = freezed,}) {
  return _then(_self.copyWith(
number: null == number ? _self.number : number // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,imageUri: freezed == imageUri ? _self.imageUri : imageUri // ignore: cast_nullable_to_non_nullable
as Uri?,
  ));
}

}


/// Adds pattern-matching-related methods to [SupplementaryContact].
extension SupplementaryContactPatterns on SupplementaryContact {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SupplementaryContact value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SupplementaryContact() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SupplementaryContact value)  $default,){
final _that = this;
switch (_that) {
case _SupplementaryContact():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SupplementaryContact value)?  $default,){
final _that = this;
switch (_that) {
case _SupplementaryContact() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String number,  String name,  Uri? imageUri)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SupplementaryContact() when $default != null:
return $default(_that.number,_that.name,_that.imageUri);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String number,  String name,  Uri? imageUri)  $default,) {final _that = this;
switch (_that) {
case _SupplementaryContact():
return $default(_that.number,_that.name,_that.imageUri);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String number,  String name,  Uri? imageUri)?  $default,) {final _that = this;
switch (_that) {
case _SupplementaryContact() when $default != null:
return $default(_that.number,_that.name,_that.imageUri);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _SupplementaryContact implements SupplementaryContact {
  const _SupplementaryContact({required this.number, required this.name, this.imageUri = null});
  factory _SupplementaryContact.fromJson(Map<String, dynamic> json) => _$SupplementaryContactFromJson(json);

@override final  String number;
@override final  String name;
@override@JsonKey() final  Uri? imageUri;

/// Create a copy of SupplementaryContact
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SupplementaryContactCopyWith<_SupplementaryContact> get copyWith => __$SupplementaryContactCopyWithImpl<_SupplementaryContact>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SupplementaryContactToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SupplementaryContact&&(identical(other.number, number) || other.number == number)&&(identical(other.name, name) || other.name == name)&&(identical(other.imageUri, imageUri) || other.imageUri == imageUri));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,number,name,imageUri);

@override
String toString() {
  return 'SupplementaryContact(number: $number, name: $name, imageUri: $imageUri)';
}


}

/// @nodoc
abstract mixin class _$SupplementaryContactCopyWith<$Res> implements $SupplementaryContactCopyWith<$Res> {
  factory _$SupplementaryContactCopyWith(_SupplementaryContact value, $Res Function(_SupplementaryContact) _then) = __$SupplementaryContactCopyWithImpl;
@override @useResult
$Res call({
 String number, String name, Uri? imageUri
});




}
/// @nodoc
class __$SupplementaryContactCopyWithImpl<$Res>
    implements _$SupplementaryContactCopyWith<$Res> {
  __$SupplementaryContactCopyWithImpl(this._self, this._then);

  final _SupplementaryContact _self;
  final $Res Function(_SupplementaryContact) _then;

/// Create a copy of SupplementaryContact
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? number = null,Object? name = null,Object? imageUri = freezed,}) {
  return _then(_SupplementaryContact(
number: null == number ? _self.number : number // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,imageUri: freezed == imageUri ? _self.imageUri : imageUri // ignore: cast_nullable_to_non_nullable
as Uri?,
  ));
}


}

// dart format on
