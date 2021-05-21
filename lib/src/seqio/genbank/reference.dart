import 'package:freezed_annotation/freezed_annotation.dart';

part 'reference.freezed.dart';

@freezed
class Reference with _$Reference {
  const Reference._();

  const factory Reference({
    required String description,
    required String authors,
    required String title,
    required String journal,
    int? pubmed,
  }) = _Reference;
}
