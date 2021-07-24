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

Either<Unit, List<String>> getReverseSequence(List<String> sequence) =>
    right(sequence.reversed.toList());

Either<Unit, List<String>> getComplementSequence(List<String> sequence) {
  const complementMap = {
    'a': 't',
    't': 'a',
    'c': 'g',
    'g': 'c',
  };

  return right(
    sequence.map((nucleotide) => complementMap[nucleotide.toLowerCase()].toString()).toList(),
  );
}
