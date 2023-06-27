import 'package:dart_bio_dependency_module/dart_bio_dependency_module.dart';

class Failure extends Union5Impl<_FileNotFound, _FileParseError, _FileEmpty, _FileFormatIncorrect,
    _FileDataFormatIncorrect> {
  static const _factory = Quintet<_FileNotFound, _FileParseError, _FileEmpty, _FileFormatIncorrect,
      _FileDataFormatIncorrect>();

  Failure._(super.union);

  factory Failure.fileNotFound() => Failure._(_factory.first(_FileNotFound()));

  factory Failure.fileParseError(error) => Failure._(
        _factory.second(_FileParseError(error.toString())),
      );

  factory Failure.fileEmpty() => Failure._(_factory.third(_FileEmpty()));

  factory Failure.fileFormatIncorrect() => Failure._(_factory.fourth(_FileFormatIncorrect()));

  factory Failure.fileDataFormatIncorrect() =>
      Failure._(_factory.fifth(_FileDataFormatIncorrect()));
}

class _FileNotFound extends Equatable {
  @override
  List<Object?> get props => [];
}

class _FileParseError extends Equatable {
  final String error;

  const _FileParseError(this.error);

  @override
  List<Object?> get props => [error];
}

class _FileEmpty extends Equatable {
  @override
  List<Object?> get props => [];
}

class _FileFormatIncorrect extends Equatable {
  @override
  List<Object?> get props => [];
}

class _FileDataFormatIncorrect extends Equatable {
  @override
  List<Object?> get props => [];
}
