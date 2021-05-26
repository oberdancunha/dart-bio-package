import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:kt_dart/kt.dart';

part 'feature.freezed.dart';

@freezed
class Feature with _$Feature {
  const Feature._();

  const factory Feature({
    required int start,
    required int end,
    required String type,
    required int strand,
    String? name,
    String? note,
    String? aminoacids,
    String? product,
    KtList<Map<String, dynamic>>? features,
  }) = _Feature;
}
