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

  _FileNotFound fileNotFound(String file) {
    return _FileNotFound(
      file,
    );
  }

  _ParserError fileParserError() {
    return const _ParserError();
  }

  _FileIsEmpty fileIsEmpty() {
    return const _FileIsEmpty();
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
    required TResult Function(String file) fileNotFound,
    required TResult Function() fileParserError,
    required TResult Function() fileIsEmpty,
    required TResult Function() fileFormatIncorrect,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String file)? fileNotFound,
    TResult Function()? fileParserError,
    TResult Function()? fileIsEmpty,
    TResult Function()? fileFormatIncorrect,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_FileNotFound value) fileNotFound,
    required TResult Function(_ParserError value) fileParserError,
    required TResult Function(_FileIsEmpty value) fileIsEmpty,
    required TResult Function(_FileFormatIncorrect value) fileFormatIncorrect,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_FileNotFound value)? fileNotFound,
    TResult Function(_ParserError value)? fileParserError,
    TResult Function(_FileIsEmpty value)? fileIsEmpty,
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
  $Res call({String file});
}

/// @nodoc
class __$FileNotFoundCopyWithImpl<$Res> extends _$FailureCopyWithImpl<$Res>
    implements _$FileNotFoundCopyWith<$Res> {
  __$FileNotFoundCopyWithImpl(
      _FileNotFound _value, $Res Function(_FileNotFound) _then)
      : super(_value, (v) => _then(v as _FileNotFound));

  @override
  _FileNotFound get _value => super._value as _FileNotFound;

  @override
  $Res call({
    Object? file = freezed,
  }) {
    return _then(_FileNotFound(
      file == freezed
          ? _value.file
          : file // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$_FileNotFound implements _FileNotFound {
  const _$_FileNotFound(this.file);

  @override
  final String file;

  @override
  String toString() {
    return 'Failure.fileNotFound(file: $file)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _FileNotFound &&
            (identical(other.file, file) ||
                const DeepCollectionEquality().equals(other.file, file)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^ const DeepCollectionEquality().hash(file);

  @JsonKey(ignore: true)
  @override
  _$FileNotFoundCopyWith<_FileNotFound> get copyWith =>
      __$FileNotFoundCopyWithImpl<_FileNotFound>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String file) fileNotFound,
    required TResult Function() fileParserError,
    required TResult Function() fileIsEmpty,
    required TResult Function() fileFormatIncorrect,
  }) {
    return fileNotFound(file);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String file)? fileNotFound,
    TResult Function()? fileParserError,
    TResult Function()? fileIsEmpty,
    TResult Function()? fileFormatIncorrect,
    required TResult orElse(),
  }) {
    if (fileNotFound != null) {
      return fileNotFound(file);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_FileNotFound value) fileNotFound,
    required TResult Function(_ParserError value) fileParserError,
    required TResult Function(_FileIsEmpty value) fileIsEmpty,
    required TResult Function(_FileFormatIncorrect value) fileFormatIncorrect,
  }) {
    return fileNotFound(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_FileNotFound value)? fileNotFound,
    TResult Function(_ParserError value)? fileParserError,
    TResult Function(_FileIsEmpty value)? fileIsEmpty,
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
  const factory _FileNotFound(String file) = _$_FileNotFound;

  String get file => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  _$FileNotFoundCopyWith<_FileNotFound> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$ParserErrorCopyWith<$Res> {
  factory _$ParserErrorCopyWith(
          _ParserError value, $Res Function(_ParserError) then) =
      __$ParserErrorCopyWithImpl<$Res>;
}

/// @nodoc
class __$ParserErrorCopyWithImpl<$Res> extends _$FailureCopyWithImpl<$Res>
    implements _$ParserErrorCopyWith<$Res> {
  __$ParserErrorCopyWithImpl(
      _ParserError _value, $Res Function(_ParserError) _then)
      : super(_value, (v) => _then(v as _ParserError));

  @override
  _ParserError get _value => super._value as _ParserError;
}

/// @nodoc

class _$_ParserError implements _ParserError {
  const _$_ParserError();

  @override
  String toString() {
    return 'Failure.fileParserError()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) || (other is _ParserError);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String file) fileNotFound,
    required TResult Function() fileParserError,
    required TResult Function() fileIsEmpty,
    required TResult Function() fileFormatIncorrect,
  }) {
    return fileParserError();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String file)? fileNotFound,
    TResult Function()? fileParserError,
    TResult Function()? fileIsEmpty,
    TResult Function()? fileFormatIncorrect,
    required TResult orElse(),
  }) {
    if (fileParserError != null) {
      return fileParserError();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_FileNotFound value) fileNotFound,
    required TResult Function(_ParserError value) fileParserError,
    required TResult Function(_FileIsEmpty value) fileIsEmpty,
    required TResult Function(_FileFormatIncorrect value) fileFormatIncorrect,
  }) {
    return fileParserError(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_FileNotFound value)? fileNotFound,
    TResult Function(_ParserError value)? fileParserError,
    TResult Function(_FileIsEmpty value)? fileIsEmpty,
    TResult Function(_FileFormatIncorrect value)? fileFormatIncorrect,
    required TResult orElse(),
  }) {
    if (fileParserError != null) {
      return fileParserError(this);
    }
    return orElse();
  }
}

abstract class _ParserError implements Failure {
  const factory _ParserError() = _$_ParserError;
}

/// @nodoc
abstract class _$FileIsEmptyCopyWith<$Res> {
  factory _$FileIsEmptyCopyWith(
          _FileIsEmpty value, $Res Function(_FileIsEmpty) then) =
      __$FileIsEmptyCopyWithImpl<$Res>;
}

/// @nodoc
class __$FileIsEmptyCopyWithImpl<$Res> extends _$FailureCopyWithImpl<$Res>
    implements _$FileIsEmptyCopyWith<$Res> {
  __$FileIsEmptyCopyWithImpl(
      _FileIsEmpty _value, $Res Function(_FileIsEmpty) _then)
      : super(_value, (v) => _then(v as _FileIsEmpty));

  @override
  _FileIsEmpty get _value => super._value as _FileIsEmpty;
}

/// @nodoc

class _$_FileIsEmpty implements _FileIsEmpty {
  const _$_FileIsEmpty();

  @override
  String toString() {
    return 'Failure.fileIsEmpty()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) || (other is _FileIsEmpty);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String file) fileNotFound,
    required TResult Function() fileParserError,
    required TResult Function() fileIsEmpty,
    required TResult Function() fileFormatIncorrect,
  }) {
    return fileIsEmpty();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String file)? fileNotFound,
    TResult Function()? fileParserError,
    TResult Function()? fileIsEmpty,
    TResult Function()? fileFormatIncorrect,
    required TResult orElse(),
  }) {
    if (fileIsEmpty != null) {
      return fileIsEmpty();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_FileNotFound value) fileNotFound,
    required TResult Function(_ParserError value) fileParserError,
    required TResult Function(_FileIsEmpty value) fileIsEmpty,
    required TResult Function(_FileFormatIncorrect value) fileFormatIncorrect,
  }) {
    return fileIsEmpty(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_FileNotFound value)? fileNotFound,
    TResult Function(_ParserError value)? fileParserError,
    TResult Function(_FileIsEmpty value)? fileIsEmpty,
    TResult Function(_FileFormatIncorrect value)? fileFormatIncorrect,
    required TResult orElse(),
  }) {
    if (fileIsEmpty != null) {
      return fileIsEmpty(this);
    }
    return orElse();
  }
}

abstract class _FileIsEmpty implements Failure {
  const factory _FileIsEmpty() = _$_FileIsEmpty;
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
    required TResult Function(String file) fileNotFound,
    required TResult Function() fileParserError,
    required TResult Function() fileIsEmpty,
    required TResult Function() fileFormatIncorrect,
  }) {
    return fileFormatIncorrect();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String file)? fileNotFound,
    TResult Function()? fileParserError,
    TResult Function()? fileIsEmpty,
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
    required TResult Function(_ParserError value) fileParserError,
    required TResult Function(_FileIsEmpty value) fileIsEmpty,
    required TResult Function(_FileFormatIncorrect value) fileFormatIncorrect,
  }) {
    return fileFormatIncorrect(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_FileNotFound value)? fileNotFound,
    TResult Function(_ParserError value)? fileParserError,
    TResult Function(_FileIsEmpty value)? fileIsEmpty,
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
