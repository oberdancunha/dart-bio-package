import 'package:freezed_annotation/freezed_annotation.dart';

part 'bio_result.freezed.dart';

@freezed
abstract class BioResult<F, D> with _$BioResult<F, D> {
  const factory BioResult.failure(F failure) = _Failure;
  const factory BioResult.data(D data) = _Data;
}
