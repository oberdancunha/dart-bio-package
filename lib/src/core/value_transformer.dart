import 'package:dartz/dartz.dart';

String formatGenbankLocusSequence(String locusSequence) => locusSequence
    .replaceAll(RegExp(r'\s'), '')
    .replaceAll(RegExp('[0-9]'), '')
    .replaceAll(RegExp(r'\n'), '');

Either<Unit, List<String>> getSubSequence({
  required List<String> sequence,
  required int start,
  required int end,
  required int codonStart,
}) =>
    right(sequence.getRange(start + (codonStart - 1), end).toList());

Either<Unit, List<String>> getSequenceToUpperCase(List<String> sequence) =>
    right(sequence.join().toUpperCase().split('').toList());

Either<Unit, List<String>> getReverseSequence(List<String> sequence) =>
    right(sequence.reversed.toList());

Either<Unit, List<String>> getComplementSequence(List<String> sequence) {
  const complementMap = {
    'A': 'T',
    'T': 'A',
    'C': 'G',
    'G': 'C',
  };

  return right(
    sequence.map((nucleotide) => complementMap[nucleotide.toUpperCase()].toString()).toList(),
  );
}
