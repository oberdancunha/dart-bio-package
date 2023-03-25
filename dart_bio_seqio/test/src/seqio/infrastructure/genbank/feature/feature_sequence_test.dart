import 'package:dart_bio_seqio/src/seqio/infrastructure/genbank/feature/feature_sequence.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late FeatureSequence featureSequence;

  setUpAll(() {
    featureSequence = FeatureSequence();
  });

  test(
    'Should there is not start codon',
    () {
      final List<Map<String, dynamic>> featuresList = [
        {'organism': 'Saccharomyces cerevisiae'},
        {'mol_type': 'genomic DNA'},
        {'db_xref': 'taxon:4932'},
        {'chromosome': 'IX'},
      ];
      final codonStart = featureSequence.getCodonStart(featuresList);
      expect(codonStart, equals(1));
    },
  );
}
