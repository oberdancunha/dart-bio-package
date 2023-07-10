import 'package:dart_bio_dependency_module/dart_bio_dependency_module.dart';

import '../feature.dart';
import '../locus.dart';
import '../locus_details.dart';
import 'reference.dart';

class Genbank extends Equatable {
  final Locus locus;
  final LocusDetails locusDetails;
  final KtList<GenbankReference>? references;
  final KtList<Feature> features;

  const Genbank({
    required this.locus,
    required this.locusDetails,
    required this.references,
    required this.features,
  });

  @override
  List<Object?> get props => [
        locus,
        locusDetails,
        references,
        features,
      ];
}
