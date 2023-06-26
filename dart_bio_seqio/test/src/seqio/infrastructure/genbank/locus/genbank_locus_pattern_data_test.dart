import 'package:dart_bio_core/exceptions.dart';
import 'package:dart_bio_seqio/src/seqio/infrastructure/core/pattern_data.dart';
import 'package:dart_bio_seqio/src/seqio/infrastructure/genbank/locus/genbank_locus_patterns.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Genbank locus data |', () {
    late PatternData patternData;
    late GenbankLocusPatterns genbankLocusPatterns;
    late String locusCorrectLine;

    setUpAll(() {
      patternData = PatternData();
      genbankLocusPatterns = GenbankLocusPatterns();
      locusCorrectLine =
          'LOCUS       SCU49845                5028 bp    DNA     linear   PLN 29-OCT-2018';
    });

    group('Get name |', () {
      test('Should throw FileDataFormatException when genbank locus data is not in pattern', () {
        const locusLine = 'LOCUS       5028 bp    DNA     linear   PLN 29-OCT-2018';
        final nameCall = patternData.getData;
        expect(
          () => nameCall(locusLine, genbankLocusPatterns.namePattern),
          throwsA(isA<FileDataFormatException>()),
        );
      });

      test('Should get name description', () {
        final name = patternData.getData(locusCorrectLine, genbankLocusPatterns.namePattern);
        expect(name, equals('SCU49845'));
      });
    });

    group('Get length |', () {
      test('Should throw FileDataFormatException when genbank locus data is not in pattern', () {
        const locusLine = 'LOCUS       5028    DNA     linear   PLN 29-OCT-2018';

        final lengthCall = patternData.getData;
        expect(
          () => lengthCall(locusLine, genbankLocusPatterns.lengthPattern),
          throwsA(isA<FileDataFormatException>()),
        );
      });

      test('Should get length data', () {
        final length = patternData.getData(locusCorrectLine, genbankLocusPatterns.lengthPattern);
        expect(length, equals('5028'));
      });
    });

    group('Get type |', () {
      test('Should throw FileDataFormatException when genbank locus data is not in pattern', () {
        const locusLine =
            'LOCUS       SCU49845                5028 bp    123     linear   PLN 29-OCT-2018';
        final typeCall = patternData.getData;
        expect(
          () => typeCall(locusLine, genbankLocusPatterns.typePattern),
          throwsA(isA<FileDataFormatException>()),
        );
      });

      test('Should get type description', () {
        final type = patternData.getData(locusCorrectLine, genbankLocusPatterns.typePattern);
        expect(type, equals('DNA'));
      });
    });

    group('Get shape |', () {
      test('Should throw FileDataFormatException when genbank locus data is not in pattern', () {
        const locusLine =
            'LOCUS       SCU49845                5028 bp    DNA     linear1   PLN 29-OCT-2018';
        final shapeCall = patternData.getData;
        expect(
          () => shapeCall(locusLine, genbankLocusPatterns.shapePattern),
          throwsA(isA<FileDataFormatException>()),
        );
      });

      test('Should get shape description', () {
        final shape = patternData.getData(locusCorrectLine, genbankLocusPatterns.shapePattern);
        expect(shape, equals('linear'));
      });
    });

    group('Get taxonomic division |', () {
      test('Should throw FileDataFormatException when genbank locus data is not in pattern', () {
        const locusLine =
            'LOCUS       SCU49845                5028 bp    DNA     linear   PL3N 29-OCT-2018';
        final taxonomicDivisionCall = patternData.getData;
        expect(
          () => taxonomicDivisionCall(locusLine, genbankLocusPatterns.taxonomicDivision),
          throwsA(isA<FileDataFormatException>()),
        );
      });

      test('Should get taxonomic division description', () {
        final taxonomicDivision = patternData.getData(
          locusCorrectLine,
          genbankLocusPatterns.taxonomicDivision,
        );
        expect(taxonomicDivision, equals('PLN'));
      });
    });

    group('Get release date |', () {
      test('Should throw FileDataFormatException when genbank locus data is not in pattern', () {
        const locusLine =
            'LOCUS       SCU49845                5028 bp    DNA     linear   PLN 29-OCT-';
        final releaseDateCall = patternData.getData;
        expect(
          () => releaseDateCall(locusLine, genbankLocusPatterns.releaseDate),
          throwsA(isA<FileDataFormatException>()),
        );
      });

      test('Should get release date', () {
        final releaseDate = patternData.getData(locusCorrectLine, genbankLocusPatterns.releaseDate);
        expect(releaseDate, equals('29-OCT-2018'));
      });
    });
  });
}
