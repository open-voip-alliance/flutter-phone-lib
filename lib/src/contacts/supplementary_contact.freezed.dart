// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'supplementary_contact.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

SupplementaryContact _$SupplementaryContactFromJson(Map<String, dynamic> json) {
  return _SupplementaryContact.fromJson(json);
}

/// @nodoc
mixin _$SupplementaryContact {
  String get number => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  Uri? get imageUri => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $SupplementaryContactCopyWith<SupplementaryContact> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SupplementaryContactCopyWith<$Res> {
  factory $SupplementaryContactCopyWith(SupplementaryContact value,
          $Res Function(SupplementaryContact) then) =
      _$SupplementaryContactCopyWithImpl<$Res, SupplementaryContact>;
  @useResult
  $Res call({String number, String name, Uri? imageUri});
}

/// @nodoc
class _$SupplementaryContactCopyWithImpl<$Res,
        $Val extends SupplementaryContact>
    implements $SupplementaryContactCopyWith<$Res> {
  _$SupplementaryContactCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? number = null,
    Object? name = null,
    Object? imageUri = freezed,
  }) {
    return _then(_value.copyWith(
      number: null == number
          ? _value.number
          : number // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      imageUri: freezed == imageUri
          ? _value.imageUri
          : imageUri // ignore: cast_nullable_to_non_nullable
              as Uri?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$SupplementaryContactImplCopyWith<$Res>
    implements $SupplementaryContactCopyWith<$Res> {
  factory _$$SupplementaryContactImplCopyWith(_$SupplementaryContactImpl value,
          $Res Function(_$SupplementaryContactImpl) then) =
      __$$SupplementaryContactImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String number, String name, Uri? imageUri});
}

/// @nodoc
class __$$SupplementaryContactImplCopyWithImpl<$Res>
    extends _$SupplementaryContactCopyWithImpl<$Res, _$SupplementaryContactImpl>
    implements _$$SupplementaryContactImplCopyWith<$Res> {
  __$$SupplementaryContactImplCopyWithImpl(_$SupplementaryContactImpl _value,
      $Res Function(_$SupplementaryContactImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? number = null,
    Object? name = null,
    Object? imageUri = freezed,
  }) {
    return _then(_$SupplementaryContactImpl(
      number: null == number
          ? _value.number
          : number // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      imageUri: freezed == imageUri
          ? _value.imageUri
          : imageUri // ignore: cast_nullable_to_non_nullable
              as Uri?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$SupplementaryContactImpl implements _SupplementaryContact {
  const _$SupplementaryContactImpl(
      {required this.number, required this.name, this.imageUri = null});

  factory _$SupplementaryContactImpl.fromJson(Map<String, dynamic> json) =>
      _$$SupplementaryContactImplFromJson(json);

  @override
  final String number;
  @override
  final String name;
  @override
  @JsonKey()
  final Uri? imageUri;

  @override
  String toString() {
    return 'SupplementaryContact(number: $number, name: $name, imageUri: $imageUri)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SupplementaryContactImpl &&
            (identical(other.number, number) || other.number == number) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.imageUri, imageUri) ||
                other.imageUri == imageUri));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, number, name, imageUri);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$SupplementaryContactImplCopyWith<_$SupplementaryContactImpl>
      get copyWith =>
          __$$SupplementaryContactImplCopyWithImpl<_$SupplementaryContactImpl>(
              this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SupplementaryContactImplToJson(
      this,
    );
  }
}

abstract class _SupplementaryContact implements SupplementaryContact {
  const factory _SupplementaryContact(
      {required final String number,
      required final String name,
      final Uri? imageUri}) = _$SupplementaryContactImpl;

  factory _SupplementaryContact.fromJson(Map<String, dynamic> json) =
      _$SupplementaryContactImpl.fromJson;

  @override
  String get number;
  @override
  String get name;
  @override
  Uri? get imageUri;
  @override
  @JsonKey(ignore: true)
  _$$SupplementaryContactImplCopyWith<_$SupplementaryContactImpl>
      get copyWith => throw _privateConstructorUsedError;
}
