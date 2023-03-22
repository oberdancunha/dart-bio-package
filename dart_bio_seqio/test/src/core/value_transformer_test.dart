import 'package:dart_bio_core/value_transformer.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../data/genbank/SCU49845/SCU49845_genbank_original_format_data.dart';
import '../../data/genbank/SCU49845/scu49845_genbank_data.dart';

void main() {
  late List<String> mockSequence;

  setUpAll(
    () {
      mockSequence = getLocusSequenceFormatted().split('');
    },
  );

  group(
    'formatGenbankLocusSequence |',
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
    'getSequenceToUpperCase |',
    () {
      test(
        'Should transform lowercase sequence to uppercase sequence',
        () {
          final mockLowercaseSequence = [
            'a',
            't',
            'g',
            'a',
            'c',
            'a',
            'c',
            'a',
            'g',
            't',
            'g',
            'a',
          ];
          final mockUppercaseSequence = [
            'A',
            'T',
            'G',
            'A',
            'C',
            'A',
            'C',
            'A',
            'G',
            'T',
            'G',
            'A',
          ];
          final sequenceUppercase = getSequenceToUpperCase(mockLowercaseSequence)
              .foldRight(<String>[], (_, sequence) => sequence);
          expect(sequenceUppercase, equals(mockUppercaseSequence));
        },
      );
    },
  );

  group(
    'Positive sequence (0 or +) |',
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
          ).foldRight(<String>[], (_, subSequence) => subSequence);
          expect(subSequence, equals(mockSubSequence));
        },
      );
    },
  );

  group(
    'Reverse sequence (strand is -1 or -) |',
    () {
      const start = 3300;
      const end = 4037;
      const codonStart = 1;
      final mockSubSequence =
          'ttaaaacaaagatccaaaaatgctctcgccctcttcatattgagaatacactccattcaaaattttgtcgtcaccgctgattaatttttcactaaactgatgaataatcaaaggccccacgtcagaaccgactaaagaagtgagttttattttaggaggttgaaaaccattattgtctggtaaattttcatcttcttgacatttaacccagtttgaatccctttcaatttctgctttttcctccaaactatcgaccctcctgtttctgtccaacttatgtcctagttccaattcgatcgcattaataactgcttcaaatgttattgtgtcatcgttgactttaggtaatttctccaaatgcataatcaaactatttaaggaagatcggaattcgtcgaacacttcagtttccgtaatgatctgatcgtctttatccacatgttgtaattcactaaaatctaaaacgtatttttcaatgcataaatcgttctttttattaataatgcagatggaaaatctgtaaacgtgcgttaatttagaaagaacatccagtataagttcttctatatagtcaattaaagcaggatgcctattaatgggaacgaactgcggcaagttgaatgactggtaagtagtgtagtcgaatgactgaggtgggtatacatttctataaaataaaatcaaattaatgtagcattttaagtataccctcagccacttctctacccatctattcat'
              .split('');
      final mockSubSequenceUppercase =
          'TTAAAACAAAGATCCAAAAATGCTCTCGCCCTCTTCATATTGAGAATACACTCCATTCAAAATTTTGTCGTCACCGCTGATTAATTTTTCACTAAACTGATGAATAATCAAAGGCCCCACGTCAGAACCGACTAAAGAAGTGAGTTTTATTTTAGGAGGTTGAAAACCATTATTGTCTGGTAAATTTTCATCTTCTTGACATTTAACCCAGTTTGAATCCCTTTCAATTTCTGCTTTTTCCTCCAAACTATCGACCCTCCTGTTTCTGTCCAACTTATGTCCTAGTTCCAATTCGATCGCATTAATAACTGCTTCAAATGTTATTGTGTCATCGTTGACTTTAGGTAATTTCTCCAAATGCATAATCAAACTATTTAAGGAAGATCGGAATTCGTCGAACACTTCAGTTTCCGTAATGATCTGATCGTCTTTATCCACATGTTGTAATTCACTAAAATCTAAAACGTATTTTTCAATGCATAAATCGTTCTTTTTATTAATAATGCAGATGGAAAATCTGTAAACGTGCGTTAATTTAGAAAGAACATCCAGTATAAGTTCTTCTATATAGTCAATTAAAGCAGGATGCCTATTAATGGGAACGAACTGCGGCAAGTTGAATGACTGGTAAGTAGTGTAGTCGAATGACTGAGGTGGGTATACATTTCTATAAAATAAAATCAAATTAATGTAGCATTTTAAGTATACCCTCAGCCACTTCTCTACCCATCTATTCAT'
              .split('');
      final mockSubSequenceReverse =
          'TACTTATCTACCCATCTCTTCACCGACTCCCATATGAATTTTACGATGTAATTAAACTAAAATAAAATATCTTTACATATGGGTGGAGTCAGTAAGCTGATGTGATGAATGGTCAGTAAGTTGAACGGCGTCAAGCAAGGGTAATTATCCGTAGGACGAAATTAACTGATATATCTTCTTGAATATGACCTACAAGAAAGATTTAATTGCGTGCAAATGTCTAAAAGGTAGACGTAATAATTATTTTTCTTGCTAAATACGTAACTTTTTATGCAAAATCTAAAATCACTTAATGTTGTACACCTATTTCTGCTAGTCTAGTAATGCCTTTGACTTCACAAGCTGCTTAAGGCTAGAAGGAATTTATCAAACTAATACGTAAACCTCTTTAATGGATTTCAGTTGCTACTGTGTTATTGTAAACTTCGTCAATAATTACGCTAGCTTAACCTTGATCCTGTATTCAACCTGTCTTTGTCCTCCCAGCTATCAAACCTCCTTTTTCGTCTTTAACTTTCCCTAAGTTTGACCCAATTTACAGTTCTTCTACTTTTAAATGGTCTGTTATTACCAAAAGTTGGAGGATTTTATTTTGAGTGAAGAAATCAGCCAAGACTGCACCCCGGAAACTAATAAGTAGTCAAATCACTTTTTAATTAGTCGCCACTGCTGTTTTAAAACTTACCTCACATAAGAGTTATACTTCTCCCGCTCTCGTAAAAACCTAGAAACAAAATT'
              .split('');
      final mockSubSequenceComplement =
          'ATGAATAGATGGGTAGAGAAGTGGCTGAGGGTATACTTAAAATGCTACATTAATTTGATTTTATTTTATAGAAATGTATACCCACCTCAGTCATTCGACTACACTACTTACCAGTCATTCAACTTGCCGCAGTTCGTTCCCATTAATAGGCATCCTGCTTTAATTGACTATATAGAAGAACTTATACTGGATGTTCTTTCTAAATTAACGCACGTTTACAGATTTTCCATCTGCATTATTAATAAAAAGAACGATTTATGCATTGAAAAATACGTTTTAGATTTTAGTGAATTACAACATGTGGATAAAGACGATCAGATCATTACGGAAACTGAAGTGTTCGACGAATTCCGATCTTCCTTAAATAGTTTGATTATGCATTTGGAGAAATTACCTAAAGTCAACGATGACACAATAACATTTGAAGCAGTTATTAATGCGATCGAATTGGAACTAGGACATAAGTTGGACAGAAACAGGAGGGTCGATAGTTTGGAGGAAAAAGCAGAAATTGAAAGGGATTCAAACTGGGTTAAATGTCAAGAAGATGAAAATTTACCAGACAATAATGGTTTTCAACCTCCTAAAATAAAACTCACTTCTTTAGTCGGTTCTGACGTGGGGCCTTTGATTATTCATCAGTTTAGTGAAAAATTAATCAGCGGTGACGACAAAATTTTGAATGGAGTGTATTCTCAATATGAAGAGGGCGAGAGCATTTTTGGATCTTTGTTTTAA'
              .split('');

      test(
        'Should get sub sequence from whole sequence based on start, end positions, codon_start is 1 and strand is positive (-1 or -)',
        () {
          final subSequence = getSubSequence(
            sequence: mockSequence,
            start: start - 1,
            end: end,
            codonStart: codonStart,
          ).foldRight([], (_, subSequence) => subSequence);
          expect(subSequence, equals(mockSubSequence));
        },
      );
      test(
        'Should get reverse sequence ',
        () {
          final subSequenceReverse = getReverseSequence(mockSubSequenceUppercase).foldRight(
            <String>[],
            (_, subSequenceReverse) => subSequenceReverse,
          );
          expect(subSequenceReverse, equals(mockSubSequenceReverse));
        },
      );

      test(
        'Should get complement sequence',
        () {
          final subSequenceComplement = getComplementSequence(mockSubSequenceReverse).foldRight(
            <String>[],
            (_, subSequenceComplement) => subSequenceComplement,
          );
          expect(subSequenceComplement, equals(mockSubSequenceComplement));
        },
      );

      test(
        'Should integrate getSubSequence, getSequenceToUpperCase, getReverseSequence and getComplementSequence functions',
        () {
          final subSequence = getSubSequence(
            sequence: mockSequence,
            start: start - 1,
            end: end,
            codonStart: codonStart,
          )
              .flatMap(getSequenceToUpperCase)
              .flatMap(getReverseSequence)
              .flatMap(getComplementSequence)
              .foldRight(<String>[], (_, finalSequence) => finalSequence);
          expect(subSequence, equals(mockSubSequenceComplement));
        },
      );
    },
  );
}
