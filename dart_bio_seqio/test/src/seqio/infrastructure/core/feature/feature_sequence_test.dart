import 'package:dart_bio_core/exceptions.dart';
import 'package:dart_bio_seqio/src/seqio/domain/entities/location_position.dart';
import 'package:dart_bio_seqio/src/seqio/infrastructure/core/feature/feature_sequence.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../../data/genbank/SCU49845/SCU49845_genbank_data.dart';

void main() {
  late FeatureSequence featureSequence;
  late List<String> genbankLocusSequence;

  setUpAll(() {
    featureSequence = FeatureSequence();
    genbankLocusSequence = getLocusSequenceFormatted().split('');
  });

  group('Get nucleotide function |', () {
    group('FileDataFormatException |', () {
      test('Should throw FileDataFormatException when position start is negative', () {
        final nucleotideSequenceCall = featureSequence.getNucleotideSubSequence;
        expect(
          () => nucleotideSequenceCall(
            type: 'CDS',
            strand: 0,
            positions: [const LocationPosition(start: -1, end: 206)],
            codonStart: 3,
            originalNucleotideSequence: genbankLocusSequence,
          ),
          throwsA(isA<FileDataFormatException>()),
        );
      });

      test(
        'Should throw FileDataFormatException when position start is greather than original nucleotide sequence',
        () {
          final nucleotideSequenceCall = featureSequence.getNucleotideSubSequence;
          expect(
            () => nucleotideSequenceCall(
              type: 'CDS',
              strand: 0,
              positions: [const LocationPosition(start: 10000, end: 10001)],
              codonStart: 3,
              originalNucleotideSequence: genbankLocusSequence,
            ),
            throwsA(isA<FileDataFormatException>()),
          );
        },
      );

      test('Should throw FileDataFormatException when position end is negative', () {
        final nucleotideSequenceCall = featureSequence.getNucleotideSubSequence;
        expect(
          () => nucleotideSequenceCall(
            type: 'CDS',
            strand: 0,
            positions: [const LocationPosition(start: 1, end: -206)],
            codonStart: 3,
            originalNucleotideSequence: genbankLocusSequence,
          ),
          throwsA(isA<FileDataFormatException>()),
        );
      });

      test(
        'Should throw FileDataFormatException when position end is greather than original nucleotide sequence',
        () {
          final nucleotideSequenceCall = featureSequence.getNucleotideSubSequence;
          expect(
            () => nucleotideSequenceCall(
              type: 'CDS',
              strand: 0,
              positions: [const LocationPosition(start: 1, end: 10000)],
              codonStart: 3,
              originalNucleotideSequence: genbankLocusSequence,
            ),
            throwsA(isA<FileDataFormatException>()),
          );
        },
      );

      test(
        'Should throw FileDataFormatException when position start is greather than original end',
        () {
          final nucleotideSequenceCall = featureSequence.getNucleotideSubSequence;
          expect(
            () => nucleotideSequenceCall(
              type: 'CDS',
              strand: 0,
              positions: [const LocationPosition(start: 150, end: 149)],
              codonStart: 3,
              originalNucleotideSequence: genbankLocusSequence,
            ),
            throwsA(isA<FileDataFormatException>()),
          );
        },
      );
    });

    test('Should return null when feature type is source, gene or mRNA', () {
      final nucleotideSequence = featureSequence.getNucleotideSubSequence(
        type: 'mRNA',
        strand: 0,
        positions: [const LocationPosition(start: 1, end: 206)],
        codonStart: 3,
        originalNucleotideSequence: genbankLocusSequence,
      );
      expect(nucleotideSequence, isNull);
    });

    test('Should get nucleotide subsequence string', () {
      final nucleotideSequence = featureSequence.getNucleotideSubSequence(
        type: 'CDS',
        strand: 0,
        positions: [const LocationPosition(start: 1, end: 206)],
        codonStart: 3,
        originalNucleotideSequence: genbankLocusSequence,
      );
      expect(
        nucleotideSequence,
        equals(
          'TCCTCCATATACAACGGTATCTCCACCTCAGGTTTAGATCTCAACAACGGAACCATTGCCGACATGAGACAGTTAGGTATCGTCGAGAGTTACAAGCTAAAACGAGCAGTAGTCAGCTCTGCATCTGAAGCCGCTGAAGTTCTACTAAGGGTGGATAACATCATCCGTGCAAGACCAAGAACCGCCAATAGACAACATATGTAA',
        ),
      );
    });
  });
}
