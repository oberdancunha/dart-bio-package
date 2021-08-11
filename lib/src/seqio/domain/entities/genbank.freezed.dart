// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides

part of 'genbank.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
class _$GenbankTearOff {
  const _$GenbankTearOff();

  _Genbank call(
      {required Locus locus,
      required LocusDetails locusDetails,
      required KtList<Feature> features}) {
    return _Genbank(
      locus: locus,
      locusDetails: locusDetails,
      features: features,
    );
  }
}

/// @nodoc
const $Genbank = _$GenbankTearOff();

/// @nodoc
mixin _$Genbank {
  Locus get locus => throw _privateConstructorUsedError;
  LocusDetails get locusDetails => throw _privateConstructorUsedError;
  KtList<Feature> get features => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $GenbankCopyWith<Genbank> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GenbankCopyWith<$Res> {
  factory $GenbankCopyWith(Genbank value, $Res Function(Genbank) then) =
      _$GenbankCopyWithImpl<$Res>;
  $Res call({Locus locus, LocusDetails locusDetails, KtList<Feature> features});

  $LocusCopyWith<$Res> get locus;
  $LocusDetailsCopyWith<$Res> get locusDetails;
}

/// @nodoc
class _$GenbankCopyWithImpl<$Res> implements $GenbankCopyWith<$Res> {
  _$GenbankCopyWithImpl(this._value, this._then);

  final Genbank _value;
  // ignore: unused_field
  final $Res Function(Genbank) _then;

  @override
  $Res call({
    Object? locus = freezed,
    Object? locusDetails = freezed,
    Object? features = freezed,
  }) {
    return _then(_value.copyWith(
      locus: locus == freezed
          ? _value.locus
          : locus // ignore: cast_nullable_to_non_nullable
              as Locus,
      locusDetails: locusDetails == freezed
          ? _value.locusDetails
          : locusDetails // ignore: cast_nullable_to_non_nullable
              as LocusDetails,
      features: features == freezed
          ? _value.features
          : features // ignore: cast_nullable_to_non_nullable
              as KtList<Feature>,
    ));
  }

  @override
  $LocusCopyWith<$Res> get locus {
    return $LocusCopyWith<$Res>(_value.locus, (value) {
      return _then(_value.copyWith(locus: value));
    });
  }

  @override
  $LocusDetailsCopyWith<$Res> get locusDetails {
    return $LocusDetailsCopyWith<$Res>(_value.locusDetails, (value) {
      return _then(_value.copyWith(locusDetails: value));
    });
  }
}

/// @nodoc
abstract class _$GenbankCopyWith<$Res> implements $GenbankCopyWith<$Res> {
  factory _$GenbankCopyWith(_Genbank value, $Res Function(_Genbank) then) =
      __$GenbankCopyWithImpl<$Res>;
  @override
  $Res call({Locus locus, LocusDetails locusDetails, KtList<Feature> features});

  @override
  $LocusCopyWith<$Res> get locus;
  @override
  $LocusDetailsCopyWith<$Res> get locusDetails;
}

/// @nodoc
class __$GenbankCopyWithImpl<$Res> extends _$GenbankCopyWithImpl<$Res>
    implements _$GenbankCopyWith<$Res> {
  __$GenbankCopyWithImpl(_Genbank _value, $Res Function(_Genbank) _then)
      : super(_value, (v) => _then(v as _Genbank));

  @override
  _Genbank get _value => super._value as _Genbank;

  @override
  $Res call({
    Object? locus = freezed,
    Object? locusDetails = freezed,
    Object? features = freezed,
  }) {
    return _then(_Genbank(
      locus: locus == freezed
          ? _value.locus
          : locus // ignore: cast_nullable_to_non_nullable
              as Locus,
      locusDetails: locusDetails == freezed
          ? _value.locusDetails
          : locusDetails // ignore: cast_nullable_to_non_nullable
              as LocusDetails,
      features: features == freezed
          ? _value.features
          : features // ignore: cast_nullable_to_non_nullable
              as KtList<Feature>,
    ));
  }
}

/// @nodoc

class _$_Genbank extends _Genbank {
  const _$_Genbank(
      {required this.locus, required this.locusDetails, required this.features})
      : super._();

  @override
  final Locus locus;
  @override
  final LocusDetails locusDetails;
  @override
  final KtList<Feature> features;

  @override
  String toString() {
    return 'Genbank(locus: $locus, locusDetails: $locusDetails, features: $features)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _Genbank &&
            (identical(other.locus, locus) ||
                const DeepCollectionEquality().equals(other.locus, locus)) &&
            (identical(other.locusDetails, locusDetails) ||
                const DeepCollectionEquality()
                    .equals(other.locusDetails, locusDetails)) &&
            (identical(other.features, features) ||
                const DeepCollectionEquality()
                    .equals(other.features, features)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(locus) ^
      const DeepCollectionEquality().hash(locusDetails) ^
      const DeepCollectionEquality().hash(features);

  @JsonKey(ignore: true)
  @override
  _$GenbankCopyWith<_Genbank> get copyWith =>
      __$GenbankCopyWithImpl<_Genbank>(this, _$identity);
}

abstract class _Genbank extends Genbank {
  const factory _Genbank(
      {required Locus locus,
      required LocusDetails locusDetails,
      required KtList<Feature> features}) = _$_Genbank;
  const _Genbank._() : super._();

  @override
  Locus get locus => throw _privateConstructorUsedError;
  @override
  LocusDetails get locusDetails => throw _privateConstructorUsedError;
  @override
  KtList<Feature> get features => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$GenbankCopyWith<_Genbank> get copyWith =>
      throw _privateConstructorUsedError;
}
