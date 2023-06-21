import 'package:dart_bio_core/value_transformer.dart';
import 'package:dart_bio_dependency_module/dart_bio_dependency_module.dart';
import 'package:dart_bio_seqio/src/seqio/domain/entities/feature.dart';
import 'package:dart_bio_seqio/src/seqio/infrastructure/core/feature_dto.dart';
import 'package:dart_bio_seqio/src/seqio/infrastructure/genbank/feature/genbank_feature_file_execute.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../data/genbank/SCU49845/SCU49845_genbank_data.dart';
import '../../../../data/genbank/SCU49845/SCU49845_genbank_original_format_data.dart';
import '../../../../data/genbank/feature_data_more_than_one_line.dart';

void main() {
  group('From Genbank file |', () {
    group('Full object feature |', () {
      late FeatureDto featureDto;

      setUpAll(() {
        featureDto = FeatureDto(GenbankFeatureFileExecute());
      });

      void runFromFileFunction(FeatureDto featureDto) {
        final locusFeaturesGenbank = getGenbankLocusFeatures();
        final locusFeaturesMocked = getLocusFeatures();
        final locusFeatures = featureDto.fromFile(
          features: locusFeaturesGenbank,
          locusSequence: formatGenbankLocusSequence(getGenbankLocusSequence().join()).split(''),
        );
        expect(locusFeatures.get(2).type, equals('CDS'));
        expect(locusFeatures.get(2).positions.elementAt(0).start, equals(1));
        expect(locusFeatures.get(2).positions.elementAt(0).end, equals(206));
        expect(locusFeatures.get(2).strand, equals(0));
        expect(locusFeatures.get(2).product, equals('TCP1-beta'));
        expect(locusFeatures.get(2).codonStart, equals(3));
        expect(
          locusFeatures.get(2).features.toString(),
          equals(
            [
              <String, dynamic>{'protein_id': 'AAA98665.1'},
            ].toImmutableList().toString(),
          ),
        );
        expect(
          locusFeatures.get(2).nucleotides,
          equals(
            'TCCTCCATATACAACGGTATCTCCACCTCAGGTTTAGATCTCAACAACGGAACCATTGCCGACATGAGACAGTTAGGTATCGTCGAGAGTTACAAGCTAAAACGAGCAGTAGTCAGCTCTGCATCTGAAGCCGCTGAAGTTCTACTAAGGGTGGATAACATCATCCGTGCAAGACCAAGAACCGCCAATAGACAACATATGTAA',
          ),
        );
        expect(
          locusFeatures.get(2).aminoacids,
          equals('SSIYNGISTSGLDLNNGTIADMRQLGIVESYKLKRAVVSSASEAAEVLLRVDNIIRARPRTANRQHM'),
        );
        expect(locusFeatures.toString(), equals(locusFeaturesMocked.toString()));
      }

      test(
        'Should get features data (Feature entity) from genbank file',
        () {
          runFromFileFunction(featureDto);
        },
      );
    });

    group('Individual data |', () {
      late FeatureDto featureDto;
      late KtList<Feature> locusFeatures;

      setUpAll(() {
        featureDto = FeatureDto(GenbankFeatureFileExecute());
        locusFeatures = featureDto.fromFile(
          features: featureDataMoreThanOneLine,
          locusSequence: [],
        );
      });

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
            equals(
              'Derived by automated computational analysis using gene prediction method: Protein Homology.',
            ),
          );
        });
      });

      group('Aminoacid sequence data |', () {
        test('Should join the aminoacid sequence separated by more than one line', () {
          expect(
            locusFeatures.get(0).aminoacids,
            equals(
              'MLSIHDPLLIFTDLDGTLLNSHTFEWQPAAPWLTRLHESGVPVILCSSKTAAEMLQLQTTLNLQGLPLIAENGAVIQLDVHWEDHPNYPRLIAGISHNEIRLVLHKLREKEQFKFTTFDDVDDQVISEWTGLNRAQSALTRLHEASVSLIWRDSDERMAQFVARLNDLGLQFVHGARFWHVLDASAGKDQAANWLIEAYRRQWRARPLTLGLGDGPNDAPLLDVMDYAVVVKGLNREGVHLRNDDPQRVYRSQNEGPDGWREGMDYFFSRS',
            ),
          );
        });
      });

      group('Gene data |', () {
        test('Should get gene data', () {
          expect(locusFeatures.get(0).name, equals('AXL2'));
        });
      });

      group('Get codon start data |', () {
        test('Should get codon start data', () {
          expect(locusFeatures.get(0).codonStart, equals(1));
        });
      });

      group('Get features another data |', () {
        test('Should get inference data', () {
          final inferenceKey = locusFeatures.get(0).features!.get(3).keys.elementAt(0);
          final inferenceValue = locusFeatures.get(0).features!.get(3).values.elementAt(0);
          expect(inferenceKey, equals('inference'));
          expect(inferenceValue, equals('COORDINATES: similar to AA sequence:RefSeq:NP_460937.1'));
        });

        test('Should get all features anothers', () {
          expect(
            locusFeatures.get(0).features.toString(),
            equals(
              [
                {'locus_tag': 'J4684_RS00090'},
                {'old_locus_tag': 'J4684_00090'},
                {'EC_number': '3.1.3.70'},
                {'inference': 'COORDINATES: similar to AA sequence:RefSeq:NP_460937.1'},
                {'transl_table': 11},
                {'protein_id': 'WP_000948794.1'},
              ].toImmutableList().toString(),
            ),
          );
        });
      });
    });
  });
}
