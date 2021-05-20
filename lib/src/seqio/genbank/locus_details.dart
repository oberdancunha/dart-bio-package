import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:kt_dart/collection.dart';

import 'reference.dart';

part 'locus_details.freezed.dart';

@freezed
class LocusDetails with _$LocusDetails {
  const LocusDetails._();

  const factory LocusDetails({
    String? definition,
    String? accession,
    int? version,
    String? keywords,
    String? source,
    String? organism,
    KtList<Reference>? references,
  }) = _LocusDetails;
}
