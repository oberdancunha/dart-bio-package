import 'package:bio/src/core/value_transformer.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../data/SCU49845/SCU49845_genbank_data.dart';
import '../../data/SCU49845/SCU49845_genbank_original_format_data.dart';

void main() {
  late List<String> mockSequence;

  setUpAll(
    () {
      mockSequence = getLocusSequenceFormatted().split('');
    },
  );

  group(
    'formatGenbankLocusSequence | ',
    () {
      test(
        'Should transform the genbank locus sequence format (sequences that contain nucleotides, blanks and base position in each line) to nucleotide format only',
        () {
          final mockGenbankLocusSequence = getGenbankLocusSequence();
          final mockLocusSequence = getLocusSequenceFormatted();
          final locusSequence = formatGenbankLocusSequence(mockGenbankLocusSequence.join());
          expect(locusSequence, equals(mockLocusSequence));
        },
      );
    },
  );

  group(
    'Positive sequence (0 or +) | ',
    () {
      test(
        'Should get sub sequence from whole sequence based on start, end positions, codon_start is 3',
        () {
          const start = 1;
          const end = 206;
          const codonStart = 3;
          final mockSubSequence =
              'tcctccatatacaacggtatctccacctcaggtttagatctcaacaacggaaccattgccgacatgagacagttaggtatcgtcgagagttacaagctaaaacgagcagtagtcagctctgcatctgaagccgctgaagttctactaagggtggataacatcatccgtgcaagaccaagaaccgccaatagacaacatatgtaa'
                  .split('');
          final subSequence = getSubSequence(
            sequence: mockSequence,
            start: start - 1,
            end: end,
            codonStart: codonStart,
          ).foldRight(null, (subSequence, previous) => subSequence);
          expect(subSequence, equals(mockSubSequence));
        },
      );
    },
  );

  group(
    'Reverse sequence (strand is -1 or -) | ',
    () {
      const start = 3300;
      const end = 4037;
      const codonStart = 1;
      final mockSubSequence =
          'ttaaaacaaagatccaaaaatgctctcgccctcttcatattgagaatacactccattcaaaattttgtcgtcaccgctgattaatttttcactaaactgatgaataatcaaaggccccacgtcagaaccgactaaagaagtgagttttattttaggaggttgaaaaccattattgtctggtaaattttcatcttcttgacatttaacccagtttgaatccctttcaatttctgctttttcctccaaactatcgaccctcctgtttctgtccaacttatgtcctagttccaattcgatcgcattaataactgcttcaaatgttattgtgtcatcgttgactttaggtaatttctccaaatgcataatcaaactatttaaggaagatcggaattcgtcgaacacttcagtttccgtaatgatctgatcgtctttatccacatgttgtaattcactaaaatctaaaacgtatttttcaatgcataaatcgttctttttattaataatgcagatggaaaatctgtaaacgtgcgttaatttagaaagaacatccagtataagttcttctatatagtcaattaaagcaggatgcctattaatgggaacgaactgcggcaagttgaatgactggtaagtagtgtagtcgaatgactgaggtgggtatacatttctataaaataaaatcaaattaatgtagcattttaagtataccctcagccacttctctacccatctattcat'
              .split('');
      final mockSubSequenceReverse =
          'tacttatctacccatctcttcaccgactcccatatgaattttacgatgtaattaaactaaaataaaatatctttacatatgggtggagtcagtaagctgatgtgatgaatggtcagtaagttgaacggcgtcaagcaagggtaattatccgtaggacgaaattaactgatatatcttcttgaatatgacctacaagaaagatttaattgcgtgcaaatgtctaaaaggtagacgtaataattatttttcttgctaaatacgtaactttttatgcaaaatctaaaatcacttaatgttgtacacctatttctgctagtctagtaatgcctttgacttcacaagctgcttaaggctagaaggaatttatcaaactaatacgtaaacctctttaatggatttcagttgctactgtgttattgtaaacttcgtcaataattacgctagcttaaccttgatcctgtattcaacctgtctttgtcctcccagctatcaaacctcctttttcgtctttaactttccctaagtttgacccaatttacagttcttctacttttaaatggtctgttattaccaaaagttggaggattttattttgagtgaagaaatcagccaagactgcaccccggaaactaataagtagtcaaatcactttttaattagtcgccactgctgttttaaaacttacctcacataagagttatacttctcccgctctcgtaaaaacctagaaacaaaatt'
              .split('');
      final mockSubSequenceComplement =
          'ATGAATAGATGGGTAGAGAAGTGGCTGAGGGTATACTTAAAATGCTACATTAATTTGATTTTATTTTATAGAAATGTATACCCACCTCAGTCATTCGACTACACTACTTACCAGTCATTCAACTTGCCGCAGTTCGTTCCCATTAATAGGCATCCTGCTTTAATTGACTATATAGAAGAACTTATACTGGATGTTCTTTCTAAATTAACGCACGTTTACAGATTTTCCATCTGCATTATTAATAAAAAGAACGATTTATGCATTGAAAAATACGTTTTAGATTTTAGTGAATTACAACATGTGGATAAAGACGATCAGATCATTACGGAAACTGAAGTGTTCGACGAATTCCGATCTTCCTTAAATAGTTTGATTATGCATTTGGAGAAATTACCTAAAGTCAACGATGACACAATAACATTTGAAGCAGTTATTAATGCGATCGAATTGGAACTAGGACATAAGTTGGACAGAAACAGGAGGGTCGATAGTTTGGAGGAAAAAGCAGAAATTGAAAGGGATTCAAACTGGGTTAAATGTCAAGAAGATGAAAATTTACCAGACAATAATGGTTTTCAACCTCCTAAAATAAAACTCACTTCTTTAGTCGGTTCTGACGTGGGGCCTTTGATTATTCATCAGTTTAGTGAAAAATTAATCAGCGGTGACGACAAAATTTTGAATGGAGTGTATTCTCAATATGAAGAGGGCGAGAGCATTTTTGGATCTTTGTTTTAA'
              .toLowerCase()
              .split('');

      test(
        'Should get sub sequence from whole sequence based on start, end positions, codon_start is 1 and strand is positive (-1 or -)',
        () {
          final subSequence = getSubSequence(
            sequence: mockSequence,
            start: start - 1,
            end: end,
            codonStart: codonStart,
          ).foldRight(null, (subSequence, previous) => subSequence);
          expect(subSequence, equals(mockSubSequence));
        },
      );
      test(
        'Should get reverse sequence ',
        () {
          final subSequenceReverse = getReverseSequence(mockSubSequence).foldRight(
            null,
            (subSequenceReverse, previous) => subSequenceReverse,
          );
          expect(subSequenceReverse, equals(mockSubSequenceReverse));
        },
      );

      test(
        'Should get complement sequence',
        () {
          final subSequenceComplement = getComplementSequence(mockSubSequenceReverse).foldRight(
            null,
            (subSequenceComplement, previous) => subSequenceComplement,
          );
          expect(subSequenceComplement, equals(mockSubSequenceComplement));
        },
      );

      test(
        'Should integrate getSubSequence, getReverseSequence and getComplementSequence functions',
        () {
          final subSequence = getSubSequence(
            sequence: mockSequence,
            start: start - 1,
            end: end,
            codonStart: codonStart,
          )
              .flatMap(getReverseSequence)
              .flatMap(getComplementSequence)
              .foldRight(null, (finalSequence, previous) => finalSequence);
          expect(subSequence, equals(mockSubSequenceComplement));
        },
      );
    },
  );
}
