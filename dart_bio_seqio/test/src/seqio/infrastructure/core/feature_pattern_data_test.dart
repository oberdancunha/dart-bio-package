import 'package:dart_bio_core/exceptions.dart';
import 'package:dart_bio_seqio/src/seqio/infrastructure/core/pattern_data.dart';
import 'package:dart_bio_seqio/src/seqio/infrastructure/genbank/feature/genbank_feature_patterns.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Genbank feature data |', () {
    late PatternData patternData;
    late GenbankFeaturePatterns genbankFeaturePatterns;

    setUpAll(() {
      patternData = PatternData();
      genbankFeaturePatterns = GenbankFeaturePatterns();
    });

    group('Get product |', () {
      test('Should throw FileDataFormatException when product description is not in pattern', () {
        const featureProduct = '                     /product=';
        final productCall = patternData.getData;
        expect(
          () => productCall(featureProduct, genbankFeaturePatterns.productPattern),
          throwsA(isA<FileDataFormatException>()),
        );
      });

      test('Should get product description', () {
        const featureProduct =
            '                     /product="flagella biosynthesis regulatory protein FliZ"';
        final product = patternData.getData(featureProduct, genbankFeaturePatterns.productPattern);
        expect(product, equals('flagella biosynthesis regulatory protein FliZ'));
      });
    });

    group('Get note |', () {
      test('Should throw FileDataFormatException when note is not in pattern', () {
        const featureNote =
            '                     /note=Derived by automated computational analysis';
        final noteCall = patternData.getData;
        expect(
          () => noteCall(featureNote, genbankFeaturePatterns.notePattern),
          throwsA(isA<FileDataFormatException>()),
        );
      });

      test('Should get note description', () {
        const featureNote =
            '                     /note="Derived by automated computational analysis"';
        final product = patternData.getData(featureNote, genbankFeaturePatterns.notePattern);
        expect(product, equals('Derived by automated computational analysis'));
      });
    });

    group('Get aminoacid sequence |', () {
      test('Should throw FileDataFormatException when aminoacid sequence is not in pattern', () {
        const featureAminoacidSequence =
            '                     /translation=MTQLQISLLLTATISLLHLVVAT';
        final aminoacidSequenceCall = patternData.getData;
        expect(
          () => aminoacidSequenceCall(
            featureAminoacidSequence,
            genbankFeaturePatterns.aminoacidSequencePattern,
          ),
          throwsA(isA<FileDataFormatException>()),
        );
      });

      test('Should get aminoacid sequence', () {
        const featureAminoacidSequence =
            '                     /translation="MTQLQISLLLTATISLLHLVVA"';
        final aminoacidSequence = patternData.getData(
          featureAminoacidSequence,
          genbankFeaturePatterns.aminoacidSequencePattern,
        );
        expect(aminoacidSequence, equals('MTQLQISLLLTATISLLHLVVA'));
      });
    });

    group('Get gene |', () {
      test('Should throw FileDataFormatException when gene is not in pattern', () {
        const featureGene = '                     /gene="AXL2';
        final geneCall = patternData.getData;
        expect(
          () => geneCall(featureGene, genbankFeaturePatterns.genePattern),
          throwsA(isA<FileDataFormatException>()),
        );
      });

      test('Should get gene', () {
        const featureGene = '                     /gene="AXL2"';
        final gene = patternData.getData(featureGene, genbankFeaturePatterns.genePattern);
        expect(gene, equals('AXL2'));
      });
    });

    group('Get codon start |', () {
      test('Should throw FileDataFormatException when codon start is not in pattern', () {
        const featureCodonStart = '                     /codon_start="3"';
        final codonStartCall = patternData.getData;
        expect(
          () => codonStartCall(featureCodonStart, genbankFeaturePatterns.codonStartPattern),
          throwsA(isA<FileDataFormatException>()),
        );
      });

      test('Should get codon start', () {
        const featureCodonStart = '                     /codon_start=3';
        final codonStart =
            patternData.getData(featureCodonStart, genbankFeaturePatterns.codonStartPattern);
        expect(codonStart, equals("3"));
      });
    });

    group('Get another |', () {
      test(
        'Should throw FileDataFormatException when not in pattern',
        () {
          const featureAnother = '                     /protein_id=';
          final featureAnotherCall = patternData.getMapAnotherData;
          expect(
            () => featureAnotherCall(featureAnother, genbankFeaturePatterns.anotherFeaturesPattern),
            throwsA(isA<FileDataFormatException>()),
          );
        },
      );

      test(
        'Should throw FileDataFormatException when a knowledge resource is found',
        () {
          const featureAnother = '                     /gene="AXL2"';
          final featureAnotherCall = patternData.getMapAnotherData;
          expect(
            () => featureAnotherCall(featureAnother, genbankFeaturePatterns.anotherFeaturesPattern),
            throwsA(isA<FileDataFormatException>()),
          );
        },
      );
    });
  });
}
