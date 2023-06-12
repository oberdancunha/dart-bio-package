import 'package:dart_bio_seqio/src/seqio/infrastructure/genbank/feature/feature_sequence.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late FeatureSequence featureSequence;

  setUpAll(() {
    featureSequence = FeatureSequence();
  });

  test('Should return 1 when features list is not defined', () {
    final codonStart = featureSequence.getCodonStart(null);
    expect(codonStart, equals(1));
  });

  test(
    'Should return 1 when features list is defined, but there is not codon_start feature',
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

  test(
    'Should return 3 when features list is defined and codon_start feature is 3',
    () {
      final List<Map<String, dynamic>> featuresList = [
        {'codon_start': '3'},
        {'product': 'TCP1-beta'},
        {'protein_id': 'AAA98665.1'},
        {'translation': 'SSIYNGISTSGLDLNNGTIADMRQLGIVESYKLKRAVVSSASEA'},
      ];
      final codonStart = featureSequence.getCodonStart(featuresList);
      expect(codonStart, equals(3));
    },
  );
}
