import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:kt_dart/collection.dart';

import 'feature.dart';
import 'locus.dart';
import 'locus_details.dart';

part 'genbank.freezed.dart';

@freezed
class Genbank with _$Genbank {
  const Genbank._();

  const factory Genbank({
    required Locus locus,
    required LocusDetails locusDetails,
    required KtList<Feature> features,
  }) = _Genbank;
}
