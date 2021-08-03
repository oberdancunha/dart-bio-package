import 'package:freezed_annotation/freezed_annotation.dart';

part 'locus.freezed.dart';

@freezed
class Locus with _$Locus {
  const Locus._();

  const factory Locus({
    required String name,
    required int length,
    required String type,
    required String shape,
    required String taxonomicDivision,
    required String releaseDate,
    String? sequence,
  }) = _Locus;
}
