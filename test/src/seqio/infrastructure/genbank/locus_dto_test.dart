import 'package:bio/src/seqio/infrastructure/genbank/locus_dto.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../data/genbank_data.dart';
import '../../../../data/genbank_original_format_data.dart';

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
      final locusSequenceFormatted =
          locusDto!.formatGenbankLocusSequence(genbankLocusSequenceMocked);
      expect(locusSequenceFormatted, equals(locusSequenceFormattedMocked));
    },
  );

  test('Should get locus data (Locus entity)', () {
    final locusGenbank = getGenbankLocus();
    final locusMocked = getLocus();
    final locus = locusDto!.fromGenbankFile(
      locusData: locusGenbank,
      locusSequence: getGenbankLocusSequence(),
    );
    expect(locus, equals(locusMocked));
  });
}
