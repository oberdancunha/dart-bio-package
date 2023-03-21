import 'package:dart_bio_seqio/src/seqio/domain/entities/genbank/location_position.dart';
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

  group('Single location position |', () {
    test('Should get single location position', () {
      const featureValue = '<147594..>151166';
      final singlePosition = featuresDto.getSinglePosition(featureValue);
      expect(singlePosition.elementAt(0).start, equals(147594));
      expect(singlePosition.elementAt(0).end, equals(151166));
    });

    test('Should get single complement location position', () {
      const featureValue = 'complement(<147594..>151166)';
      final singlePosition = featuresDto.getSinglePosition(featureValue);
      expect(singlePosition.elementAt(0).start, equals(147594));
      expect(singlePosition.elementAt(0).end, equals(151166));
    });
  });

  group('Multiple location positions |', () {
    test('Should get multiple location positions', () {
      const featureValue = "join(147594..151006,151097..151166)";
      final multiplePositions = featuresDto.getMultiplePositions(featureValue);
      expect(multiplePositions.elementAt(0).start, equals(147594));
      expect(multiplePositions.elementAt(0).end, equals(151006));
      expect(multiplePositions.elementAt(1).start, equals(151097));
      expect(multiplePositions.elementAt(1).end, equals(151166));
    });

    test('Should get multiple complement location positions', () {
      const featureValue = "complement(join(147594..151006,151097..151166))";
      final multiplePositions = featuresDto.getMultiplePositions(featureValue);
      expect(multiplePositions.elementAt(0).start, equals(147594));
      expect(multiplePositions.elementAt(0).end, equals(151006));
      expect(multiplePositions.elementAt(1).start, equals(151097));
      expect(multiplePositions.elementAt(1).end, equals(151166));
    });

    test('Should return an empty location position', () {
      const featureValue = '<147594';
      final singlePosition = featuresDto.getSinglePosition(featureValue);
      expect(singlePosition, equals(List<LocationPosition>.empty()));
    });
  });

  group('Location type |', () {
    test('Should get single location', () {
      const featureValue = '<147594..>151166';
      final locationType = featuresDto.getLocations(featureValue);
      expect(locationType.positions.elementAt(0).start, equals(147594));
      expect(locationType.positions.elementAt(0).end, equals(151166));
      expect(locationType.strand, equals(0));
    });

    test('Should get single complement location', () {
      const featureValue = 'complement(<147594..>151166)';
      final locationType = featuresDto.getLocations(featureValue);
      expect(locationType.positions.elementAt(0).start, equals(147594));
      expect(locationType.positions.elementAt(0).end, equals(151166));
      expect(locationType.strand, equals(1));
    });

    test('Should get multiple locations', () {
      const featureValue = "join(147594..151006,151097..151166)";
      final locationType = featuresDto.getLocations(featureValue);
      expect(locationType.positions.elementAt(0).start, equals(147594));
      expect(locationType.positions.elementAt(0).end, equals(151006));
      expect(locationType.positions.elementAt(1).start, equals(151097));
      expect(locationType.positions.elementAt(1).end, equals(151166));
      expect(locationType.strand, equals(0));
    });

    test('Should get multiple complement locations', () {
      const featureValue = "complement(join(147594..151006,151097..151166))";
      final locationType = featuresDto.getLocations(featureValue);
      expect(locationType.positions.elementAt(0).start, equals(147594));
      expect(locationType.positions.elementAt(0).end, equals(151006));
      expect(locationType.positions.elementAt(1).start, equals(151097));
      expect(locationType.positions.elementAt(1).end, equals(151166));
      expect(locationType.strand, equals(1));
    });

    test('Should return empty for a single location', () {
      const featureValue = '<147594';
      final locationType = featuresDto.getLocations(featureValue);
      expect(locationType.positions, equals([]));
      expect(locationType.strand, equals(0));
    });

    test('Should return empty for multiple locations', () {
      const featureValue = 'join(<147594)';
      final locationType = featuresDto.getLocations(featureValue);
      expect(locationType.positions, equals([]));
      expect(locationType.strand, equals(0));
    });
  });
}
