import 'package:dart_bio_core/exceptions.dart';
import 'package:dart_bio_core/value_transformer.dart';
import 'package:dart_bio_seqio/src/seqio/infrastructure/genbank/locus/locus_dto.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../../data/genbank/SCU49845/SCU49845_genbank_data.dart';
import '../../../../../data/genbank/SCU49845/SCU49845_genbank_original_format_data.dart';

void main() {
  LocusDto? locusDto;

  setUpAll(() {
    locusDto = LocusDto();
  });

  test(
    'Should format the genbank locus sequence by removing numbers, blanks and line breaks',
    () {
      final genbankLocusSequenceMocked = getGenbankLocusSequence().join();
      final locusSequenceFormattedMocked = getLocusSequenceFormatted();
      final locusSequenceFormatted = formatGenbankLocusSequence(genbankLocusSequenceMocked);
      expect(locusSequenceFormatted, equals(locusSequenceFormattedMocked));
    },
  );

  test('Should get locus data (Locus entity)', () {
    final locusGenbank = getGenbankLocus();
    final locusMocked = getLocus();
    final locusSequence = getGenbankLocusSequence();
    final locus = locusDto!.fromGenbankFile(
      locusData: locusGenbank,
      locusSequence: formatGenbankLocusSequence(locusSequence.join()),
    );
    expect(locus, equals(locusMocked));
  });

  test('Should throw FormatException exception if release date is not in dd-MMM-yyyy format', () {
    final locusGenbank = getGenbankLocusReleaseDateError();
    final locusDtoFromGenbankFileFunction = locusDto!.fromGenbankFile;
    expect(
      () => locusDtoFromGenbankFileFunction(
        locusData: locusGenbank,
        locusSequence: formatGenbankLocusSequence(""),
      ),
      throwsA(isA<FileFormatException>()),
    );
  });
}
