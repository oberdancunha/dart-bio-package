// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides

part of 'failures.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
class _$FailureTearOff {
  const _$FailureTearOff();

  _FileNotFound fileNotFound() {
    return const _FileNotFound();
  }

  _FileParseError fileParseError({required Object error}) {
    return _FileParseError(
      error: error,
    );
  }

  _FileEmpty fileEmpty() {
    return const _FileEmpty();
  }

  _FileFormatIncorrect fileFormatIncorrect() {
    return const _FileFormatIncorrect();
  }
}

/// @nodoc
const $Failure = _$FailureTearOff();

/// @nodoc
mixin _$Failure {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() fileNotFound,
    required TResult Function(Object error) fileParseError,
    required TResult Function() fileEmpty,
    required TResult Function() fileFormatIncorrect,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? fileNotFound,
    TResult Function(Object error)? fileParseError,
    TResult Function()? fileEmpty,
    TResult Function()? fileFormatIncorrect,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_FileNotFound value) fileNotFound,
    required TResult Function(_FileParseError value) fileParseError,
    required TResult Function(_FileEmpty value) fileEmpty,
    required TResult Function(_FileFormatIncorrect value) fileFormatIncorrect,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_FileNotFound value)? fileNotFound,
    TResult Function(_FileParseError value)? fileParseError,
    TResult Function(_FileEmpty value)? fileEmpty,
    TResult Function(_FileFormatIncorrect value)? fileFormatIncorrect,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FailureCopyWith<$Res> {
  factory $FailureCopyWith(Failure value, $Res Function(Failure) then) =
      _$FailureCopyWithImpl<$Res>;
}

/// @nodoc
class _$FailureCopyWithImpl<$Res> implements $FailureCopyWith<$Res> {
  _$FailureCopyWithImpl(this._value, this._then);

  final Failure _value;
  // ignore: unused_field
  final $Res Function(Failure) _then;
}

/// @nodoc
abstract class _$FileNotFoundCopyWith<$Res> {
  factory _$FileNotFoundCopyWith(
          _FileNotFound value, $Res Function(_FileNotFound) then) =
      __$FileNotFoundCopyWithImpl<$Res>;
}

/// @nodoc
class __$FileNotFoundCopyWithImpl<$Res> extends _$FailureCopyWithImpl<$Res>
    implements _$FileNotFoundCopyWith<$Res> {
  __$FileNotFoundCopyWithImpl(
      _FileNotFound _value, $Res Function(_FileNotFound) _then)
      : super(_value, (v) => _then(v as _FileNotFound));

  @override
  _FileNotFound get _value => super._value as _FileNotFound;
}

/// @nodoc

class _$_FileNotFound implements _FileNotFound {
  const _$_FileNotFound();

  @override
  String toString() {
    return 'Failure.fileNotFound()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) || (other is _FileNotFound);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() fileNotFound,
    required TResult Function(Object error) fileParseError,
    required TResult Function() fileEmpty,
    required TResult Function() fileFormatIncorrect,
  }) {
    return fileNotFound();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? fileNotFound,
    TResult Function(Object error)? fileParseError,
    TResult Function()? fileEmpty,
    TResult Function()? fileFormatIncorrect,
    required TResult orElse(),
  }) {
    if (fileNotFound != null) {
      return fileNotFound();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_FileNotFound value) fileNotFound,
    required TResult Function(_FileParseError value) fileParseError,
    required TResult Function(_FileEmpty value) fileEmpty,
    required TResult Function(_FileFormatIncorrect value) fileFormatIncorrect,
  }) {
    return fileNotFound(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_FileNotFound value)? fileNotFound,
    TResult Function(_FileParseError value)? fileParseError,
    TResult Function(_FileEmpty value)? fileEmpty,
    TResult Function(_FileFormatIncorrect value)? fileFormatIncorrect,
    required TResult orElse(),
  }) {
    if (fileNotFound != null) {
      return fileNotFound(this);
    }
    return orElse();
  }
}

abstract class _FileNotFound implements Failure {
  const factory _FileNotFound() = _$_FileNotFound;
}

/// @nodoc
abstract class _$FileParseErrorCopyWith<$Res> {
  factory _$FileParseErrorCopyWith(
          _FileParseError value, $Res Function(_FileParseError) then) =
      __$FileParseErrorCopyWithImpl<$Res>;
  $Res call({Object error});
}

/// @nodoc
class __$FileParseErrorCopyWithImpl<$Res> extends _$FailureCopyWithImpl<$Res>
    implements _$FileParseErrorCopyWith<$Res> {
  __$FileParseErrorCopyWithImpl(
      _FileParseError _value, $Res Function(_FileParseError) _then)
      : super(_value, (v) => _then(v as _FileParseError));

  @override
  _FileParseError get _value => super._value as _FileParseError;

  @override
  $Res call({
    Object? error = freezed,
  }) {
    return _then(_FileParseError(
      error: error == freezed
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as Object,
    ));
  }
}

/// @nodoc

class _$_FileParseError implements _FileParseError {
  const _$_FileParseError({required this.error});

  @override
  final Object error;

  @override
  String toString() {
    return 'Failure.fileParseError(error: $error)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _FileParseError &&
            (identical(other.error, error) ||
                const DeepCollectionEquality().equals(other.error, error)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^ const DeepCollectionEquality().hash(error);

  @JsonKey(ignore: true)
  @override
  _$FileParseErrorCopyWith<_FileParseError> get copyWith =>
      __$FileParseErrorCopyWithImpl<_FileParseError>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() fileNotFound,
    required TResult Function(Object error) fileParseError,
    required TResult Function() fileEmpty,
    required TResult Function() fileFormatIncorrect,
  }) {
    return fileParseError(error);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? fileNotFound,
    TResult Function(Object error)? fileParseError,
    TResult Function()? fileEmpty,
    TResult Function()? fileFormatIncorrect,
    required TResult orElse(),
  }) {
    if (fileParseError != null) {
      return fileParseError(error);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_FileNotFound value) fileNotFound,
    required TResult Function(_FileParseError value) fileParseError,
    required TResult Function(_FileEmpty value) fileEmpty,
    required TResult Function(_FileFormatIncorrect value) fileFormatIncorrect,
  }) {
    return fileParseError(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_FileNotFound value)? fileNotFound,
    TResult Function(_FileParseError value)? fileParseError,
    TResult Function(_FileEmpty value)? fileEmpty,
    TResult Function(_FileFormatIncorrect value)? fileFormatIncorrect,
    required TResult orElse(),
  }) {
    if (fileParseError != null) {
      return fileParseError(this);
    }
    return orElse();
  }
}

abstract class _FileParseError implements Failure {
  const factory _FileParseError({required Object error}) = _$_FileParseError;

  Object get error => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  _$FileParseErrorCopyWith<_FileParseError> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$FileEmptyCopyWith<$Res> {
  factory _$FileEmptyCopyWith(
          _FileEmpty value, $Res Function(_FileEmpty) then) =
      __$FileEmptyCopyWithImpl<$Res>;
}

/// @nodoc
class __$FileEmptyCopyWithImpl<$Res> extends _$FailureCopyWithImpl<$Res>
    implements _$FileEmptyCopyWith<$Res> {
  __$FileEmptyCopyWithImpl(_FileEmpty _value, $Res Function(_FileEmpty) _then)
      : super(_value, (v) => _then(v as _FileEmpty));

  @override
  _FileEmpty get _value => super._value as _FileEmpty;
}

/// @nodoc

class _$_FileEmpty implements _FileEmpty {
  const _$_FileEmpty();

  @override
  String toString() {
    return 'Failure.fileEmpty()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) || (other is _FileEmpty);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() fileNotFound,
    required TResult Function(Object error) fileParseError,
    required TResult Function() fileEmpty,
    required TResult Function() fileFormatIncorrect,
  }) {
    return fileEmpty();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? fileNotFound,
    TResult Function(Object error)? fileParseError,
    TResult Function()? fileEmpty,
    TResult Function()? fileFormatIncorrect,
    required TResult orElse(),
  }) {
    if (fileEmpty != null) {
      return fileEmpty();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_FileNotFound value) fileNotFound,
    required TResult Function(_FileParseError value) fileParseError,
    required TResult Function(_FileEmpty value) fileEmpty,
    required TResult Function(_FileFormatIncorrect value) fileFormatIncorrect,
  }) {
    return fileEmpty(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_FileNotFound value)? fileNotFound,
    TResult Function(_FileParseError value)? fileParseError,
    TResult Function(_FileEmpty value)? fileEmpty,
    TResult Function(_FileFormatIncorrect value)? fileFormatIncorrect,
    required TResult orElse(),
  }) {
    if (fileEmpty != null) {
      return fileEmpty(this);
    }
    return orElse();
  }
}

abstract class _FileEmpty implements Failure {
  const factory _FileEmpty() = _$_FileEmpty;
}

/// @nodoc
abstract class _$FileFormatIncorrectCopyWith<$Res> {
  factory _$FileFormatIncorrectCopyWith(_FileFormatIncorrect value,
          $Res Function(_FileFormatIncorrect) then) =
      __$FileFormatIncorrectCopyWithImpl<$Res>;
}

/// @nodoc
class __$FileFormatIncorrectCopyWithImpl<$Res>
    extends _$FailureCopyWithImpl<$Res>
    implements _$FileFormatIncorrectCopyWith<$Res> {
  __$FileFormatIncorrectCopyWithImpl(
      _FileFormatIncorrect _value, $Res Function(_FileFormatIncorrect) _then)
      : super(_value, (v) => _then(v as _FileFormatIncorrect));

  @override
  _FileFormatIncorrect get _value => super._value as _FileFormatIncorrect;
}

/// @nodoc

class _$_FileFormatIncorrect implements _FileFormatIncorrect {
  const _$_FileFormatIncorrect();

  @override
  String toString() {
    return 'Failure.fileFormatIncorrect()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) || (other is _FileFormatIncorrect);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() fileNotFound,
    required TResult Function(Object error) fileParseError,
    required TResult Function() fileEmpty,
    required TResult Function() fileFormatIncorrect,
  }) {
    return fileFormatIncorrect();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? fileNotFound,
    TResult Function(Object error)? fileParseError,
    TResult Function()? fileEmpty,
    TResult Function()? fileFormatIncorrect,
    required TResult orElse(),
  }) {
    if (fileFormatIncorrect != null) {
      return fileFormatIncorrect();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_FileNotFound value) fileNotFound,
    required TResult Function(_FileParseError value) fileParseError,
    required TResult Function(_FileEmpty value) fileEmpty,
    required TResult Function(_FileFormatIncorrect value) fileFormatIncorrect,
  }) {
    return fileFormatIncorrect(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_FileNotFound value)? fileNotFound,
    TResult Function(_FileParseError value)? fileParseError,
    TResult Function(_FileEmpty value)? fileEmpty,
    TResult Function(_FileFormatIncorrect value)? fileFormatIncorrect,
    required TResult orElse(),
  }) {
    if (fileFormatIncorrect != null) {
      return fileFormatIncorrect(this);
    }
    return orElse();
  }
}

abstract class _FileFormatIncorrect implements Failure {
  const factory _FileFormatIncorrect() = _$_FileFormatIncorrect;
}
