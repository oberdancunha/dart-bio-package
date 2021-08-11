// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides

part of 'locus_details.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
class _$LocusDetailsTearOff {
  const _$LocusDetailsTearOff();

  _LocusDetails call(
      {String? definition,
      String? accession,
      int? version,
      String? keywords,
      String? source,
      String? organism,
      KtList<Reference>? references}) {
    return _LocusDetails(
      definition: definition,
      accession: accession,
      version: version,
      keywords: keywords,
      source: source,
      organism: organism,
      references: references,
    );
  }
}

/// @nodoc
const $LocusDetails = _$LocusDetailsTearOff();

/// @nodoc
mixin _$LocusDetails {
  String? get definition => throw _privateConstructorUsedError;
  String? get accession => throw _privateConstructorUsedError;
  int? get version => throw _privateConstructorUsedError;
  String? get keywords => throw _privateConstructorUsedError;
  String? get source => throw _privateConstructorUsedError;
  String? get organism => throw _privateConstructorUsedError;
  KtList<Reference>? get references => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $LocusDetailsCopyWith<LocusDetails> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LocusDetailsCopyWith<$Res> {
  factory $LocusDetailsCopyWith(
          LocusDetails value, $Res Function(LocusDetails) then) =
      _$LocusDetailsCopyWithImpl<$Res>;
  $Res call(
      {String? definition,
      String? accession,
      int? version,
      String? keywords,
      String? source,
      String? organism,
      KtList<Reference>? references});
}

/// @nodoc
class _$LocusDetailsCopyWithImpl<$Res> implements $LocusDetailsCopyWith<$Res> {
  _$LocusDetailsCopyWithImpl(this._value, this._then);

  final LocusDetails _value;
  // ignore: unused_field
  final $Res Function(LocusDetails) _then;

  @override
  $Res call({
    Object? definition = freezed,
    Object? accession = freezed,
    Object? version = freezed,
    Object? keywords = freezed,
    Object? source = freezed,
    Object? organism = freezed,
    Object? references = freezed,
  }) {
    return _then(_value.copyWith(
      definition: definition == freezed
          ? _value.definition
          : definition // ignore: cast_nullable_to_non_nullable
              as String?,
      accession: accession == freezed
          ? _value.accession
          : accession // ignore: cast_nullable_to_non_nullable
              as String?,
      version: version == freezed
          ? _value.version
          : version // ignore: cast_nullable_to_non_nullable
              as int?,
      keywords: keywords == freezed
          ? _value.keywords
          : keywords // ignore: cast_nullable_to_non_nullable
              as String?,
      source: source == freezed
          ? _value.source
          : source // ignore: cast_nullable_to_non_nullable
              as String?,
      organism: organism == freezed
          ? _value.organism
          : organism // ignore: cast_nullable_to_non_nullable
              as String?,
      references: references == freezed
          ? _value.references
          : references // ignore: cast_nullable_to_non_nullable
              as KtList<Reference>?,
    ));
  }
}

/// @nodoc
abstract class _$LocusDetailsCopyWith<$Res>
    implements $LocusDetailsCopyWith<$Res> {
  factory _$LocusDetailsCopyWith(
          _LocusDetails value, $Res Function(_LocusDetails) then) =
      __$LocusDetailsCopyWithImpl<$Res>;
  @override
  $Res call(
      {String? definition,
      String? accession,
      int? version,
      String? keywords,
      String? source,
      String? organism,
      KtList<Reference>? references});
}

/// @nodoc
class __$LocusDetailsCopyWithImpl<$Res> extends _$LocusDetailsCopyWithImpl<$Res>
    implements _$LocusDetailsCopyWith<$Res> {
  __$LocusDetailsCopyWithImpl(
      _LocusDetails _value, $Res Function(_LocusDetails) _then)
      : super(_value, (v) => _then(v as _LocusDetails));

  @override
  _LocusDetails get _value => super._value as _LocusDetails;

  @override
  $Res call({
    Object? definition = freezed,
    Object? accession = freezed,
    Object? version = freezed,
    Object? keywords = freezed,
    Object? source = freezed,
    Object? organism = freezed,
    Object? references = freezed,
  }) {
    return _then(_LocusDetails(
      definition: definition == freezed
          ? _value.definition
          : definition // ignore: cast_nullable_to_non_nullable
              as String?,
      accession: accession == freezed
          ? _value.accession
          : accession // ignore: cast_nullable_to_non_nullable
              as String?,
      version: version == freezed
          ? _value.version
          : version // ignore: cast_nullable_to_non_nullable
              as int?,
      keywords: keywords == freezed
          ? _value.keywords
          : keywords // ignore: cast_nullable_to_non_nullable
              as String?,
      source: source == freezed
          ? _value.source
          : source // ignore: cast_nullable_to_non_nullable
              as String?,
      organism: organism == freezed
          ? _value.organism
          : organism // ignore: cast_nullable_to_non_nullable
              as String?,
      references: references == freezed
          ? _value.references
          : references // ignore: cast_nullable_to_non_nullable
              as KtList<Reference>?,
    ));
  }
}

/// @nodoc

class _$_LocusDetails extends _LocusDetails {
  const _$_LocusDetails(
      {this.definition,
      this.accession,
      this.version,
      this.keywords,
      this.source,
      this.organism,
      this.references})
      : super._();

  @override
  final String? definition;
  @override
  final String? accession;
  @override
  final int? version;
  @override
  final String? keywords;
  @override
  final String? source;
  @override
  final String? organism;
  @override
  final KtList<Reference>? references;

  @override
  String toString() {
    return 'LocusDetails(definition: $definition, accession: $accession, version: $version, keywords: $keywords, source: $source, organism: $organism, references: $references)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _LocusDetails &&
            (identical(other.definition, definition) ||
                const DeepCollectionEquality()
                    .equals(other.definition, definition)) &&
            (identical(other.accession, accession) ||
                const DeepCollectionEquality()
                    .equals(other.accession, accession)) &&
            (identical(other.version, version) ||
                const DeepCollectionEquality()
                    .equals(other.version, version)) &&
            (identical(other.keywords, keywords) ||
                const DeepCollectionEquality()
                    .equals(other.keywords, keywords)) &&
            (identical(other.source, source) ||
                const DeepCollectionEquality().equals(other.source, source)) &&
            (identical(other.organism, organism) ||
                const DeepCollectionEquality()
                    .equals(other.organism, organism)) &&
            (identical(other.references, references) ||
                const DeepCollectionEquality()
                    .equals(other.references, references)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(definition) ^
      const DeepCollectionEquality().hash(accession) ^
      const DeepCollectionEquality().hash(version) ^
      const DeepCollectionEquality().hash(keywords) ^
      const DeepCollectionEquality().hash(source) ^
      const DeepCollectionEquality().hash(organism) ^
      const DeepCollectionEquality().hash(references);

  @JsonKey(ignore: true)
  @override
  _$LocusDetailsCopyWith<_LocusDetails> get copyWith =>
      __$LocusDetailsCopyWithImpl<_LocusDetails>(this, _$identity);
}

abstract class _LocusDetails extends LocusDetails {
  const factory _LocusDetails(
      {String? definition,
      String? accession,
      int? version,
      String? keywords,
      String? source,
      String? organism,
      KtList<Reference>? references}) = _$_LocusDetails;
  const _LocusDetails._() : super._();

  @override
  String? get definition => throw _privateConstructorUsedError;
  @override
  String? get accession => throw _privateConstructorUsedError;
  @override
  int? get version => throw _privateConstructorUsedError;
  @override
  String? get keywords => throw _privateConstructorUsedError;
  @override
  String? get source => throw _privateConstructorUsedError;
  @override
  String? get organism => throw _privateConstructorUsedError;
  @override
  KtList<Reference>? get references => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$LocusDetailsCopyWith<_LocusDetails> get copyWith =>
      throw _privateConstructorUsedError;
}
