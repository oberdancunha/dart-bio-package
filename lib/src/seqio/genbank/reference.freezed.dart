// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides

part of 'reference.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
class _$ReferenceTearOff {
  const _$ReferenceTearOff();

  _Reference call(
      {required String description,
      required String authors,
      required String title,
      required String journal,
      String? pubmed}) {
    return _Reference(
      description: description,
      authors: authors,
      title: title,
      journal: journal,
      pubmed: pubmed,
    );
  }
}

/// @nodoc
const $Reference = _$ReferenceTearOff();

/// @nodoc
mixin _$Reference {
  String get description => throw _privateConstructorUsedError;
  String get authors => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  String get journal => throw _privateConstructorUsedError;
  String? get pubmed => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $ReferenceCopyWith<Reference> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ReferenceCopyWith<$Res> {
  factory $ReferenceCopyWith(Reference value, $Res Function(Reference) then) =
      _$ReferenceCopyWithImpl<$Res>;
  $Res call(
      {String description,
      String authors,
      String title,
      String journal,
      String? pubmed});
}

/// @nodoc
class _$ReferenceCopyWithImpl<$Res> implements $ReferenceCopyWith<$Res> {
  _$ReferenceCopyWithImpl(this._value, this._then);

  final Reference _value;
  // ignore: unused_field
  final $Res Function(Reference) _then;

  @override
  $Res call({
    Object? description = freezed,
    Object? authors = freezed,
    Object? title = freezed,
    Object? journal = freezed,
    Object? pubmed = freezed,
  }) {
    return _then(_value.copyWith(
      description: description == freezed
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      authors: authors == freezed
          ? _value.authors
          : authors // ignore: cast_nullable_to_non_nullable
              as String,
      title: title == freezed
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      journal: journal == freezed
          ? _value.journal
          : journal // ignore: cast_nullable_to_non_nullable
              as String,
      pubmed: pubmed == freezed
          ? _value.pubmed
          : pubmed // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
abstract class _$ReferenceCopyWith<$Res> implements $ReferenceCopyWith<$Res> {
  factory _$ReferenceCopyWith(
          _Reference value, $Res Function(_Reference) then) =
      __$ReferenceCopyWithImpl<$Res>;
  @override
  $Res call(
      {String description,
      String authors,
      String title,
      String journal,
      String? pubmed});
}

/// @nodoc
class __$ReferenceCopyWithImpl<$Res> extends _$ReferenceCopyWithImpl<$Res>
    implements _$ReferenceCopyWith<$Res> {
  __$ReferenceCopyWithImpl(_Reference _value, $Res Function(_Reference) _then)
      : super(_value, (v) => _then(v as _Reference));

  @override
  _Reference get _value => super._value as _Reference;

  @override
  $Res call({
    Object? description = freezed,
    Object? authors = freezed,
    Object? title = freezed,
    Object? journal = freezed,
    Object? pubmed = freezed,
  }) {
    return _then(_Reference(
      description: description == freezed
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      authors: authors == freezed
          ? _value.authors
          : authors // ignore: cast_nullable_to_non_nullable
              as String,
      title: title == freezed
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      journal: journal == freezed
          ? _value.journal
          : journal // ignore: cast_nullable_to_non_nullable
              as String,
      pubmed: pubmed == freezed
          ? _value.pubmed
          : pubmed // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$_Reference extends _Reference {
  const _$_Reference(
      {required this.description,
      required this.authors,
      required this.title,
      required this.journal,
      this.pubmed})
      : super._();

  @override
  final String description;
  @override
  final String authors;
  @override
  final String title;
  @override
  final String journal;
  @override
  final String? pubmed;

  @override
  String toString() {
    return 'Reference(description: $description, authors: $authors, title: $title, journal: $journal, pubmed: $pubmed)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _Reference &&
            (identical(other.description, description) ||
                const DeepCollectionEquality()
                    .equals(other.description, description)) &&
            (identical(other.authors, authors) ||
                const DeepCollectionEquality()
                    .equals(other.authors, authors)) &&
            (identical(other.title, title) ||
                const DeepCollectionEquality().equals(other.title, title)) &&
            (identical(other.journal, journal) ||
                const DeepCollectionEquality()
                    .equals(other.journal, journal)) &&
            (identical(other.pubmed, pubmed) ||
                const DeepCollectionEquality().equals(other.pubmed, pubmed)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(description) ^
      const DeepCollectionEquality().hash(authors) ^
      const DeepCollectionEquality().hash(title) ^
      const DeepCollectionEquality().hash(journal) ^
      const DeepCollectionEquality().hash(pubmed);

  @JsonKey(ignore: true)
  @override
  _$ReferenceCopyWith<_Reference> get copyWith =>
      __$ReferenceCopyWithImpl<_Reference>(this, _$identity);
}

abstract class _Reference extends Reference {
  const factory _Reference(
      {required String description,
      required String authors,
      required String title,
      required String journal,
      String? pubmed}) = _$_Reference;
  const _Reference._() : super._();

  @override
  String get description => throw _privateConstructorUsedError;
  @override
  String get authors => throw _privateConstructorUsedError;
  @override
  String get title => throw _privateConstructorUsedError;
  @override
  String get journal => throw _privateConstructorUsedError;
  @override
  String? get pubmed => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$ReferenceCopyWith<_Reference> get copyWith =>
      throw _privateConstructorUsedError;
}
