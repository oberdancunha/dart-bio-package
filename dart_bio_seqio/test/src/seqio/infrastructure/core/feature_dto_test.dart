import 'package:dart_bio_seqio/src/seqio/infrastructure/core/feature_dto.dart';
import 'package:dart_bio_seqio/src/seqio/infrastructure/genbank/feature/genbank_feature_file_execute.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../data/genbank/SCU49845/SCU49845_genbank_data.dart';
import '../../../../data/genbank/SCU49845/SCU49845_genbank_original_format_data.dart';
import '../../../../data/genbank/feature_data_more_than_one_line.dart';

void main() {
  void runFromFileFunction(FeatureDto featureDto) {
    final locusFeaturesGenbank = getGenbankLocusFeatures();
    final locusFeaturesMocked = getLocusFeatures();
    final locusFeatures = featureDto.fromFile(
      features: locusFeaturesGenbank,
      locusSequence: getLocusSequenceFormatted().split(''),
    );
    // expect(locusFeatures.toString(), equals(locusFeaturesMocked.toString()));
    expect(locusFeatures.get(2).type, equals('CDS'));
    expect(locusFeatures.get(2).positions.elementAt(0).start, equals(1));
    expect(locusFeatures.get(2).positions.elementAt(0).end, equals(206));
    expect(locusFeatures.get(2).strand, equals(0));
    expect(locusFeatures.get(2).product, equals('TCP1-beta'));
  }

  group('From Genbank file |', () {
    final featureDto = FeatureDto(GenbankFeatureFileExecute());

    test(
      'Should get features data (Feature entity) from genbank file',
      () {
        final featureDto = FeatureDto(GenbankFeatureFileExecute());
        runFromFileFunction(featureDto);
      },
    );

    group('Individual data |', () {
      final locusFeatures = featureDto.fromFile(
        features: featureDataMoreThanOneLine,
        locusSequence: [],
      );

      group('Product data |', () {
        test('Should join the product separated by more than one line', () {
          expect(
            locusFeatures.get(0).product,
            equals('mannosyl-3-phosphoglycerate phosphatase-related protein'),
          );
        });
      });

      group('Note data |', () {
        test('Should join the note separated by more than one line', () {
          expect(
            locusFeatures.get(0).note,
            'Derived by automated computational analysis using gene prediction method: Protein Homology.',
          );
        });
      });
    });
  });
}
