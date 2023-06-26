import 'package:dart_bio_core/exceptions.dart';
import 'package:dart_bio_seqio/src/seqio/infrastructure/core/pattern_data.dart';
import 'package:dart_bio_seqio/src/seqio/infrastructure/genbank/locus_details/genbank_locus_details_patterns.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Genbank locus details data |', () {
    late PatternData patternData;
    late GenbankLocusDetailsPatterns genbankLocusDetailsPatterns;

    setUpAll(() {
      patternData = PatternData();
      genbankLocusDetailsPatterns = GenbankLocusDetailsPatterns();
    });

    group('Verify if is continous data |', () {
      test('Should throw FileDataFormatException when not continous data', () {
        const continousData = '      Eukaryota; Fungi; Dikarya; Ascomycota; Saccharomycotina;';
        final continousDataCall = patternData.getData;
        expect(
          () => continousDataCall(
            continousData,
            genbankLocusDetailsPatterns.recallLastEventPattern,
          ),
          throwsA(isA<FileDataFormatException>()),
        );
      });

      test('Should return continous data', () {
        const continousData =
            '            Eukaryota; Fungi; Dikarya; Ascomycota; Saccharomycotina;';
        final data = patternData.getData(
          continousData,
          genbankLocusDetailsPatterns.recallLastEventPattern,
        );
        expect(data, equals('Eukaryota; Fungi; Dikarya; Ascomycota; Saccharomycotina;'));
      });
    });

    group('Get definition description |', () {
      test(
        'Should throw FileDataFormatException when genbank locus details definition is not in pattern',
        () {
          const definitionLine =
              'DEFINITIONSaccharomyces cerevisiae TCP1-beta gene, partial cds; and Axl2p';
          final definitionLineCall = patternData.getData;
          expect(
            () => definitionLineCall(definitionLine, genbankLocusDetailsPatterns.definitionPattern),
            throwsA(isA<FileDataFormatException>()),
          );
        },
      );

      test('Should get definition description', () {
        const definitionLine =
            'DEFINITION  Saccharomyces cerevisiae TCP1-beta gene, partial cds; and Axl2p';
        final definition = patternData.getData(
          definitionLine,
          genbankLocusDetailsPatterns.definitionPattern,
        );
        expect(
          definition,
          equals('Saccharomyces cerevisiae TCP1-beta gene, partial cds; and Axl2p'),
        );
      });
    });

    group('Get accession value |', () {
      test(
        'Should throw FileDataFormatException when genbank locus details accession is not in pattern',
        () {
          const accessionLine = 'ACCESSION   ';
          final accessionCall = patternData.getData;
          expect(
            () => accessionCall(accessionLine, genbankLocusDetailsPatterns.accessionPattern),
            throwsA(isA<FileDataFormatException>()),
          );
        },
      );

      test('Should get accession value', () {
        const accessionLine = 'ACCESSION   U49845';
        final accession = patternData.getData(
          accessionLine,
          genbankLocusDetailsPatterns.accessionPattern,
        );
        expect(accession, equals('U49845'));
      });
    });

    group('Get version value |', () {
      test(
        'Should throw FileDataFormatException when genbank locus details version is not in pattern',
        () {
          const versionLine = 'VERSION     U49845.1 ';
          final versionCall = patternData.getData;
          expect(
            () => versionCall(versionLine, genbankLocusDetailsPatterns.versionPattern),
            throwsA(isA<FileDataFormatException>()),
          );
        },
      );

      test('Should get version value', () {
        const versionLine = 'VERSION     U49845.1';
        final version = patternData.getData(
          versionLine,
          genbankLocusDetailsPatterns.versionPattern,
        );
        expect(version, equals('U49845.1'));
      });
    });

    group('Get keywords value |', () {
      test(
        'Should throw FileDataFormatException when genbank locus details keywords is not in pattern',
        () {
          const keywordsLine = 'KEYWORDS    ';
          final keywordsCall = patternData.getData;
          expect(
            () => keywordsCall(keywordsLine, genbankLocusDetailsPatterns.keywordsPattern),
            throwsA(isA<FileDataFormatException>()),
          );
        },
      );

      test('Should get keywords value', () {
        const keywordsLine = 'KEYWORDS    .';
        final keywords = patternData.getData(
          keywordsLine,
          genbankLocusDetailsPatterns.keywordsPattern,
        );
        expect(keywords, equals('.'));
      });
    });

    group('Get source name |', () {
      test(
        'Should throw FileDataFormatException when genbank locus details source is not in pattern',
        () {
          const sourceLine = " SOURCE      Saccharomyces cerevisiae (baker's yeast)";
          final sourceCall = patternData.getData;
          expect(
            () => sourceCall(sourceLine, genbankLocusDetailsPatterns.sourcePattern),
            throwsA(isA<FileDataFormatException>()),
          );
        },
      );

      test('Should get source name', () {
        const sourceLine = "SOURCE      Saccharomyces cerevisiae (baker's yeast)";
        final source = patternData.getData(sourceLine, genbankLocusDetailsPatterns.sourcePattern);
        expect(source, equals("Saccharomyces cerevisiae (baker's yeast)"));
      });
    });

    group('Get organism name', () {
      test(
        'Should throw FileDataFormatException when genbank locus details organism is not in pattern',
        () {
          const organismLine = ' ORGANISM  Saccharomyces cerevisiae';
          final organismCall = patternData.getData;
          expect(
            () => organismCall(organismLine, genbankLocusDetailsPatterns.organismPattern),
            throwsA(isA<FileDataFormatException>()),
          );
        },
      );

      test('Should get organism name', () {
        const organismLine = '  ORGANISM  Saccharomyces cerevisiae';
        final organism = patternData.getData(
          organismLine,
          genbankLocusDetailsPatterns.organismPattern,
        );
        expect(organism, equals('Saccharomyces cerevisiae'));
      });
    });
  });
}
