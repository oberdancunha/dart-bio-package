// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides

part of 'bio_result.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
class _$BioResultTearOff {
  const _$BioResultTearOff();

  _Failure<F, D> failure<F, D>(F failure) {
    return _Failure<F, D>(
      failure,
    );
  }

  _Data<F, D> data<F, D>(D data) {
    return _Data<F, D>(
      data,
    );
  }
}

/// @nodoc
const $BioResult = _$BioResultTearOff();

/// @nodoc
mixin _$BioResult<F, D> {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(F failure) failure,
    required TResult Function(D data) data,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(F failure)? failure,
    TResult Function(D data)? data,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Failure<F, D> value) failure,
    required TResult Function(_Data<F, D> value) data,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Failure<F, D> value)? failure,
    TResult Function(_Data<F, D> value)? data,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BioResultCopyWith<F, D, $Res> {
  factory $BioResultCopyWith(
          BioResult<F, D> value, $Res Function(BioResult<F, D>) then) =
      _$BioResultCopyWithImpl<F, D, $Res>;
}

/// @nodoc
class _$BioResultCopyWithImpl<F, D, $Res>
    implements $BioResultCopyWith<F, D, $Res> {
  _$BioResultCopyWithImpl(this._value, this._then);

  final BioResult<F, D> _value;
  // ignore: unused_field
  final $Res Function(BioResult<F, D>) _then;
}

/// @nodoc
abstract class _$FailureCopyWith<F, D, $Res> {
  factory _$FailureCopyWith(
          _Failure<F, D> value, $Res Function(_Failure<F, D>) then) =
      __$FailureCopyWithImpl<F, D, $Res>;
  $Res call({F failure});
}

/// @nodoc
class __$FailureCopyWithImpl<F, D, $Res>
    extends _$BioResultCopyWithImpl<F, D, $Res>
    implements _$FailureCopyWith<F, D, $Res> {
  __$FailureCopyWithImpl(
      _Failure<F, D> _value, $Res Function(_Failure<F, D>) _then)
      : super(_value, (v) => _then(v as _Failure<F, D>));

  @override
  _Failure<F, D> get _value => super._value as _Failure<F, D>;

  @override
  $Res call({
    Object? failure = freezed,
  }) {
    return _then(_Failure<F, D>(
      failure == freezed
          ? _value.failure
          : failure // ignore: cast_nullable_to_non_nullable
              as F,
    ));
  }
}

/// @nodoc

class _$_Failure<F, D> implements _Failure<F, D> {
  const _$_Failure(this.failure);

  @override
  final F failure;

  @override
  String toString() {
    return 'BioResult<$F, $D>.failure(failure: $failure)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _Failure<F, D> &&
            (identical(other.failure, failure) ||
                const DeepCollectionEquality().equals(other.failure, failure)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^ const DeepCollectionEquality().hash(failure);

  @JsonKey(ignore: true)
  @override
  _$FailureCopyWith<F, D, _Failure<F, D>> get copyWith =>
      __$FailureCopyWithImpl<F, D, _Failure<F, D>>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(F failure) failure,
    required TResult Function(D data) data,
  }) {
    return failure(this.failure);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(F failure)? failure,
    TResult Function(D data)? data,
    required TResult orElse(),
  }) {
    if (failure != null) {
      return failure(this.failure);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Failure<F, D> value) failure,
    required TResult Function(_Data<F, D> value) data,
  }) {
    return failure(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Failure<F, D> value)? failure,
    TResult Function(_Data<F, D> value)? data,
    required TResult orElse(),
  }) {
    if (failure != null) {
      return failure(this);
    }
    return orElse();
  }
}

abstract class _Failure<F, D> implements BioResult<F, D> {
  const factory _Failure(F failure) = _$_Failure<F, D>;

  F get failure => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  _$FailureCopyWith<F, D, _Failure<F, D>> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$DataCopyWith<F, D, $Res> {
  factory _$DataCopyWith(_Data<F, D> value, $Res Function(_Data<F, D>) then) =
      __$DataCopyWithImpl<F, D, $Res>;
  $Res call({D data});
}

/// @nodoc
class __$DataCopyWithImpl<F, D, $Res>
    extends _$BioResultCopyWithImpl<F, D, $Res>
    implements _$DataCopyWith<F, D, $Res> {
  __$DataCopyWithImpl(_Data<F, D> _value, $Res Function(_Data<F, D>) _then)
      : super(_value, (v) => _then(v as _Data<F, D>));

  @override
  _Data<F, D> get _value => super._value as _Data<F, D>;

  @override
  $Res call({
    Object? data = freezed,
  }) {
    return _then(_Data<F, D>(
      data == freezed
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as D,
    ));
  }
}

/// @nodoc

class _$_Data<F, D> implements _Data<F, D> {
  const _$_Data(this.data);

  @override
  final D data;

  @override
  String toString() {
    return 'BioResult<$F, $D>.data(data: $data)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _Data<F, D> &&
            (identical(other.data, data) ||
                const DeepCollectionEquality().equals(other.data, data)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^ const DeepCollectionEquality().hash(data);

  @JsonKey(ignore: true)
  @override
  _$DataCopyWith<F, D, _Data<F, D>> get copyWith =>
      __$DataCopyWithImpl<F, D, _Data<F, D>>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(F failure) failure,
    required TResult Function(D data) data,
  }) {
    return data(this.data);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(F failure)? failure,
    TResult Function(D data)? data,
    required TResult orElse(),
  }) {
    if (data != null) {
      return data(this.data);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Failure<F, D> value) failure,
    required TResult Function(_Data<F, D> value) data,
  }) {
    return data(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Failure<F, D> value)? failure,
    TResult Function(_Data<F, D> value)? data,
    required TResult orElse(),
  }) {
    if (data != null) {
      return data(this);
    }
    return orElse();
  }
}

abstract class _Data<F, D> implements BioResult<F, D> {
  const factory _Data(D data) = _$_Data<F, D>;

  D get data => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  _$DataCopyWith<F, D, _Data<F, D>> get copyWith =>
      throw _privateConstructorUsedError;
}
