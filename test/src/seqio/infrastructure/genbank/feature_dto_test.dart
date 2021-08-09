import 'package:bio/src/seqio/infrastructure/genbank/feature_dto.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../data/genbank/SCU49845/SCU49845_genbank_data.dart';
import '../../../../data/genbank/SCU49845/SCU49845_genbank_original_format_data.dart';

void main() {
  FeatureDto? featuresDto;

  setUpAll(() {
    featuresDto = FeatureDto();
  });

  test(
    'Should get features data (Feature entity)',
    () {
      final locusFeaturesGenbank = getGenbankLocusFeatures();
      final locusFeaturesMocked = getLocusFeatures();
      final locusFeatures = featuresDto!.fromGenbankFile(
        features: locusFeaturesGenbank,
        locusSequence: getLocusSequenceFormatted().split(''),
      );
      expect(locusFeatures.toString(), equals(locusFeaturesMocked.toString()));
    },
  );
}
