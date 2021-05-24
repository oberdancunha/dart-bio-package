import 'package:freezed_annotation/freezed_annotation.dart';

part 'failures.freezed.dart';

@freezed
abstract class Failure with _$Failure {
  const factory Failure.fileNotFound(String file) = _FileNotFound;
  const factory Failure.fileParserError() = _ParserError;
  const factory Failure.fileIsEmpty() = _FileIsEmpty;
  const factory Failure.fileFormatIncorrect() = _FileFormatIncorrect;
}
