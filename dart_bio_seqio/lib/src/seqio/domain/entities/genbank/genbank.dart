import 'package:dart_bio_dependency_module/dart_bio_dependency_module.dart';

import 'feature.dart';
import 'locus.dart';
import 'locus_details.dart';

class Genbank extends Equatable {
  final Locus locus;
  final LocusDetails locusDetails;
  final KtList<Feature> features;

  const Genbank({
    required this.locus,
    required this.locusDetails,
    required this.features,
  });

  @override
  List<Object?> get props => [
        locus,
        locusDetails,
        features,
      ];
}
