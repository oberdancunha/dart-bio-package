import 'package:dart_bio_core/value_transformer.dart';
import 'package:dart_bio_dependency_module/dart_bio_dependency_module.dart';

import '../../../domain/entities/genbank/location_position.dart';

class FeatureSequence {
  String? getNucleotides({
    required String currentFeatureName,
    required int strand,
    required List<String> locusSequence,
    required List<LocationPosition> positions,
    required List<Map<String, dynamic>> additionalFeaturesData,
  }) {
    if (currentFeatureName != 'source' &&
        currentFeatureName != 'gene' &&
        currentFeatureName != 'mRNA') {
      final nucleotidesList = positions
          .map(
            (position) => getSubSequence(
              sequence: locusSequence,
              start: position.start - 1,
              end: position.end,
              codonStart: getCodonStart(additionalFeaturesData),
            ).flatMap(getSequenceToUpperCase).foldRight(
                  "",
                  (_, nucleotides) => nucleotides.join(),
                ),
          )
          .toList();
      Either<Unit, List<String>> nucleotides = right(nucleotidesList.join().split(''));
      if (strand != 0) {
        nucleotides = nucleotides.flatMap(getReverseSequence).flatMap(getComplementSequence);
      }

      return nucleotides.foldRight("", (_, nucleotides) => nucleotides.join());
    }

    return null;
  }

  int getCodonStart(List<Map<String, dynamic>> additionalFeaturesData) =>
      int.tryParse(
        additionalFeaturesData
            .firstWhere(
              (feature) => feature['codon_start'] != null,
              orElse: () => {},
            )['codon_start']
            .toString(),
      ) ??
      1;

  String? getTranslation(List<String> translationValue) =>
      translationValue.isNotEmpty ? translationValue.join() : null;
}
