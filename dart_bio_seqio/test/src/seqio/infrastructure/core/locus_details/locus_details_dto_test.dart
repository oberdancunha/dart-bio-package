import 'package:dart_bio_seqio/src/seqio/domain/entities/locus_details.dart';
import 'package:dart_bio_seqio/src/seqio/infrastructure/core/locus_details/locus_details_dto.dart';
import 'package:dart_bio_seqio/src/seqio/infrastructure/genbank/locus_details/genbank_locus_details_event.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../../data/genbank/SCU49845/SCU49845_genbank_original_format_data.dart';
import '../../../../../data/genbank/SCU49845/scu49845_genbank_data.dart';

void main() {
  group('From genbank file |', () {
    LocusDetailsDto? locusDetailsDto;

    group('Full object locus details |', () {
      setUpAll(() {
        locusDetailsDto = LocusDetailsDto(GenbankLocusDetailsEvent());
      });

      test(
        'Should get locus details data (LocusDetails entity)',
        () {
          final locusDetailsGenbank = getGenbankLocusDetails();
          final locusDetailsMocked = getLocusDetails();
          final locusDetails = locusDetailsDto!.fromFile(locusDetailsGenbank);
          expect(locusDetails, equals(locusDetailsMocked));
        },
      );
    });

    group('Individual data |', () {
      late LocusDetailsDto locusDetailsDto;
      late LocusDetails locusDetails;

      setUpAll(() {
        locusDetailsDto = LocusDetailsDto(GenbankLocusDetailsEvent());
        locusDetails = locusDetailsDto.fromFile(getGenbankLocusDetails());
      });

      group('Get definition |', () {
        test('Should join the definition separated by more than one line', () {
          expect(
            locusDetails.definition,
            equals(
              'Saccharomyces cerevisiae TCP1-beta gene, partial cds; and Axl2p (AXL2) and Rev7p (REV7) genes, complete cds.',
            ),
          );
        });
      });

      group('Get accession |', () {
        test('Should get accession data', () {
          expect(locusDetails.accession, equals('U49845'));
        });
      });

      group('Get version |', () {
        test('Should get version number', () {
          expect(locusDetails.version, equals(1));
        });
      });

      group('Get keywords |', () {
        test('Should get keywords value', () {
          expect(locusDetails.keywords, equals('.'));
        });
      });

      group('Get source |', () {
        test('Should get source data', () {
          expect(locusDetails.source, equals("Saccharomyces cerevisiae (baker's yeast)"));
        });
      });

      group('Get organism |', () {
        test('Should join the organism separated by more than one line', () {
          expect(
            locusDetails.organism,
            'Saccharomyces cerevisiae; Eukaryota; Fungi; Dikarya; Ascomycota; Saccharomycotina; Saccharomycetes; Saccharomycetales; Saccharomycetaceae; Saccharomyces.',
          );
        });
      });
    });
  });
}
