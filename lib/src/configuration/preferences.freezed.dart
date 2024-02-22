// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'preferences.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

Preferences _$PreferencesFromJson(Map<String, dynamic> json) {
  return _Preferences.fromJson(json);
}

/// @nodoc
mixin _$Preferences {
  bool get useApplicationProvidedRingtone => throw _privateConstructorUsedError;
  bool get showCallsInNativeRecents => throw _privateConstructorUsedError;
  Set<SupplementaryContact> get supplementaryContacts =>
      throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $PreferencesCopyWith<Preferences> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PreferencesCopyWith<$Res> {
  factory $PreferencesCopyWith(
          Preferences value, $Res Function(Preferences) then) =
      _$PreferencesCopyWithImpl<$Res, Preferences>;
  @useResult
  $Res call(
      {bool useApplicationProvidedRingtone,
      bool showCallsInNativeRecents,
      Set<SupplementaryContact> supplementaryContacts});
}

/// @nodoc
class _$PreferencesCopyWithImpl<$Res, $Val extends Preferences>
    implements $PreferencesCopyWith<$Res> {
  _$PreferencesCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? useApplicationProvidedRingtone = null,
    Object? showCallsInNativeRecents = null,
    Object? supplementaryContacts = null,
  }) {
    return _then(_value.copyWith(
      useApplicationProvidedRingtone: null == useApplicationProvidedRingtone
          ? _value.useApplicationProvidedRingtone
          : useApplicationProvidedRingtone // ignore: cast_nullable_to_non_nullable
              as bool,
      showCallsInNativeRecents: null == showCallsInNativeRecents
          ? _value.showCallsInNativeRecents
          : showCallsInNativeRecents // ignore: cast_nullable_to_non_nullable
              as bool,
      supplementaryContacts: null == supplementaryContacts
          ? _value.supplementaryContacts
          : supplementaryContacts // ignore: cast_nullable_to_non_nullable
              as Set<SupplementaryContact>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$PreferencesImplCopyWith<$Res>
    implements $PreferencesCopyWith<$Res> {
  factory _$$PreferencesImplCopyWith(
          _$PreferencesImpl value, $Res Function(_$PreferencesImpl) then) =
      __$$PreferencesImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {bool useApplicationProvidedRingtone,
      bool showCallsInNativeRecents,
      Set<SupplementaryContact> supplementaryContacts});
}

/// @nodoc
class __$$PreferencesImplCopyWithImpl<$Res>
    extends _$PreferencesCopyWithImpl<$Res, _$PreferencesImpl>
    implements _$$PreferencesImplCopyWith<$Res> {
  __$$PreferencesImplCopyWithImpl(
      _$PreferencesImpl _value, $Res Function(_$PreferencesImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? useApplicationProvidedRingtone = null,
    Object? showCallsInNativeRecents = null,
    Object? supplementaryContacts = null,
  }) {
    return _then(_$PreferencesImpl(
      useApplicationProvidedRingtone: null == useApplicationProvidedRingtone
          ? _value.useApplicationProvidedRingtone
          : useApplicationProvidedRingtone // ignore: cast_nullable_to_non_nullable
              as bool,
      showCallsInNativeRecents: null == showCallsInNativeRecents
          ? _value.showCallsInNativeRecents
          : showCallsInNativeRecents // ignore: cast_nullable_to_non_nullable
              as bool,
      supplementaryContacts: null == supplementaryContacts
          ? _value._supplementaryContacts
          : supplementaryContacts // ignore: cast_nullable_to_non_nullable
              as Set<SupplementaryContact>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$PreferencesImpl implements _Preferences {
  const _$PreferencesImpl(
      {required this.useApplicationProvidedRingtone,
      required this.showCallsInNativeRecents,
      final Set<SupplementaryContact> supplementaryContacts = const {}})
      : _supplementaryContacts = supplementaryContacts;

  factory _$PreferencesImpl.fromJson(Map<String, dynamic> json) =>
      _$$PreferencesImplFromJson(json);

  @override
  final bool useApplicationProvidedRingtone;
  @override
  final bool showCallsInNativeRecents;
  final Set<SupplementaryContact> _supplementaryContacts;
  @override
  @JsonKey()
  Set<SupplementaryContact> get supplementaryContacts {
    if (_supplementaryContacts is EqualUnmodifiableSetView)
      return _supplementaryContacts;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableSetView(_supplementaryContacts);
  }

  @override
  String toString() {
    return 'Preferences(useApplicationProvidedRingtone: $useApplicationProvidedRingtone, showCallsInNativeRecents: $showCallsInNativeRecents, supplementaryContacts: $supplementaryContacts)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PreferencesImpl &&
            (identical(other.useApplicationProvidedRingtone,
                    useApplicationProvidedRingtone) ||
                other.useApplicationProvidedRingtone ==
                    useApplicationProvidedRingtone) &&
            (identical(
                    other.showCallsInNativeRecents, showCallsInNativeRecents) ||
                other.showCallsInNativeRecents == showCallsInNativeRecents) &&
            const DeepCollectionEquality()
                .equals(other._supplementaryContacts, _supplementaryContacts));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      useApplicationProvidedRingtone,
      showCallsInNativeRecents,
      const DeepCollectionEquality().hash(_supplementaryContacts));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$PreferencesImplCopyWith<_$PreferencesImpl> get copyWith =>
      __$$PreferencesImplCopyWithImpl<_$PreferencesImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PreferencesImplToJson(
      this,
    );
  }
}

abstract class _Preferences implements Preferences {
  const factory _Preferences(
          {required final bool useApplicationProvidedRingtone,
          required final bool showCallsInNativeRecents,
          final Set<SupplementaryContact> supplementaryContacts}) =
      _$PreferencesImpl;

  factory _Preferences.fromJson(Map<String, dynamic> json) =
      _$PreferencesImpl.fromJson;

  @override
  bool get useApplicationProvidedRingtone;
  @override
  bool get showCallsInNativeRecents;
  @override
  Set<SupplementaryContact> get supplementaryContacts;
  @override
  @JsonKey(ignore: true)
  _$$PreferencesImplCopyWith<_$PreferencesImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
