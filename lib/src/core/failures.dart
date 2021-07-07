import 'package:freezed_annotation/freezed_annotation.dart';

part 'failures.freezed.dart';

@freezed
class Failure with _$Failure {
  const factory Failure.fileNotFound() = _FileNotFound;
  const factory Failure.fileParseError({required Object error}) = _FileParseError;
  const factory Failure.fileIsEmpty() = _FileIsEmpty;
  const factory Failure.fileFormatIncorrect() = _FileFormatIncorrect;
}
