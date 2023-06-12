import 'package:dart_bio_dependency_module/dart_bio_dependency_module.dart';

class BioResult<F, D> extends Union2Impl<_Failure<F>, _Data<D>> {
  BioResult._(super.union);

  factory BioResult.failure(F failure) => BioResult._(
        Doublet<_Failure<F>, _Data<D>>().first(
          _Failure(failure),
        ),
      );

  factory BioResult.data(D data) => BioResult._(
        Doublet<_Failure<F>, _Data<D>>().second(
          _Data(data),
        ),
      );
}

class _Failure<F> extends Equatable {
  final F failure;

  const _Failure(this.failure);

  @override
  List<Object?> get props => [failure];
}

class _Data<D> extends Equatable {
  final D data;

  const _Data(this.data);

  @override
  List<Object?> get props => [data];
}
