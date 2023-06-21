import 'package:dart_bio_core/exceptions.dart';
import 'package:dart_bio_core/value_transformer.dart';
import 'package:dart_bio_dependency_module/dart_bio_dependency_module.dart';

import '../../domain/entities/location_position.dart';

class FeatureSequence {
  String? getNucleotideSubSequence({
    required String type,
    required int strand,
    required List<LocationPosition> positions,
    required int codonStart,
    required List<String> originalNucleotideSequence,
  }) {
    if (type != 'source' && type != 'gene' && type != 'mRNA') {
      final nucleotideSubSequenceList = positions.map((position) {
        final originalNucleotideSequenceLength = originalNucleotideSequence.length;
        if (position.start < 0 ||
            position.end > originalNucleotideSequenceLength ||
            position.start >= position.end) {
          throw FileDataFormatException();
        }

        return getSubSequence(
          sequence: originalNucleotideSequence,
          start: position.start - 1,
          end: position.end,
          codonStart: codonStart,
        )
            .flatMap(getSequenceToUpperCase)
            .foldRight("", (_, nucleotideSubSequence) => nucleotideSubSequence.join());
      }).toList();
      Either<Unit, List<String>> nucleotides = right(nucleotideSubSequenceList.join().split(''));
      if (strand != 0) {
        nucleotides = nucleotides.flatMap(getReverseSequence).flatMap(getComplementSequence);
      }

      return nucleotides.foldRight("", (_, nucleotides) => nucleotides.join());
    }

    return null;
  }
}
