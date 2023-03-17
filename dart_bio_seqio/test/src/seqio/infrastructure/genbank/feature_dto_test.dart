import 'package:dart_bio_seqio/src/seqio/infrastructure/genbank/feature_dto.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../data/genbank/SCU49845/SCU49845_genbank_original_format_data.dart';
import '../../../../data/genbank/SCU49845/scu49845_genbank_data.dart';

void main() {
  late FeatureDto featuresDto;

  setUpAll(() {
    featuresDto = FeatureDto();
  });

  test(
    'Should get features data (Feature entity)',
    () {
      final locusFeaturesGenbank = getGenbankLocusFeatures();
      final locusFeaturesMocked = getLocusFeatures();
      final locusFeatures = featuresDto.fromGenbankFile(
        features: locusFeaturesGenbank,
        locusSequence: getLocusSequenceFormatted().split(''),
      );
      expect(locusFeatures.toString(), equals(locusFeaturesMocked.toString()));
    },
  );

  test(
    'Should there is not start codon',
    () {
      final List<Map<String, dynamic>> featuresList = [
        {'organism': 'Saccharomyces cerevisiae'},
        {'mol_type': 'genomic DNA'},
        {'db_xref': 'taxon:4932'},
        {'chromosome': 'IX'},
      ];
      final codonStart = featuresDto.getCodonStart(featuresList);
      expect(codonStart, equals(1));
    },
  );
}
