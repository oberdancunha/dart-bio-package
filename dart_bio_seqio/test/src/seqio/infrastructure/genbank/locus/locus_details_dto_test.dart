import 'package:dart_bio_seqio/src/seqio/infrastructure/genbank/locus/locus_details_dto.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../../data/genbank/SCU49845/SCU49845_genbank_original_format_data.dart';
import '../../../../../data/genbank/SCU49845/scu49845_genbank_data.dart';

void main() {
  LocusDetailsDto? locusDetailsDto;

  setUpAll(() {
    locusDetailsDto = LocusDetailsDto();
  });

  test(
    'Should get locus details data (LocusDetails entity)',
    () {
      final locusDetailsGenbank = getGenbankLocusDetails();
      final locusDetailsMocked = getLocusDetails();
      final locusDetails = locusDetailsDto!.fromGenbankFile(locusDetailsGenbank);
      expect(locusDetails, equals(locusDetailsMocked));
    },
  );
}
