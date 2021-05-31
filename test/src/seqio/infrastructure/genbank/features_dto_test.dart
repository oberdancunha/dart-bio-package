import 'package:bio/src/seqio/infrastructure/genbank/features_dto.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../data/SCU49845/SCU49845_genbank_data.dart';
import '../../../../data/SCU49845/SCU49845_genbank_original_format_data.dart';

void main() {
  FeaturesDto? featuresDto;

  setUpAll(() {
    featuresDto = FeaturesDto();
  });

  test(
    'Should get features data (Feature entity)',
    () {
      final locusFeaturesGenbank = getGenbankLocusFeatures();
      final locusFeaturesMocked = getLocusFeatures();
      final locusFeatures = featuresDto!.fromGenbankFile(locusFeaturesGenbank);
      expect(locusFeatures.toString(), equals(locusFeaturesMocked.toString()));
    },
  );
}
