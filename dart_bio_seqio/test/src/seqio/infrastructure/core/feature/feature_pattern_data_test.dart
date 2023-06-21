import 'package:dart_bio_core/exceptions.dart';
import 'package:dart_bio_seqio/src/seqio/infrastructure/core/feature/feature_pattern_data.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late FeaturePatternData genbankGenericFeature;

  setUpAll(() {
    genbankGenericFeature = FeaturePatternData();
  });

  group('Genbank data |', () {
    group('Get product |', () {
      late String featureProductPattern;

      setUpAll(() {
        featureProductPattern = r'^\s{21}\/product\=\"(.+)\"?$';
      });

      test('Should throw FileDataFormatException when product description is not in pattern', () {
        const featureProduct = '                     /product=';
        final productCall = genbankGenericFeature.getData;
        expect(
          () => productCall(featureProduct, featureProductPattern),
          throwsA(isA<FileDataFormatException>()),
        );
      });

      test('Should get product description', () {
        const featureProduct =
            '                     /product="flagella biosynthesis regulatory protein FliZ"';
        final product = genbankGenericFeature.getData(featureProduct, featureProductPattern);
        expect(product, equals('flagella biosynthesis regulatory protein FliZ'));
      });
    });

    group('Get note |', () {
      late String featureNotePattern;

      setUpAll(() {
        featureNotePattern = r'^\s{21}\/note\=\"(.+)\"?$';
      });

      test('Should throw FileDataFormatException when note is not in pattern', () {
        const featureNote =
            '                     /note=Derived by automated computational analysis';
        final noteCall = genbankGenericFeature.getData;
        expect(
          () => noteCall(featureNote, featureNotePattern),
          throwsA(isA<FileDataFormatException>()),
        );
      });

      test('Should get note description', () {
        const featureNote =
            '                     /note="Derived by automated computational analysis"';
        final product = genbankGenericFeature.getData(featureNote, featureNotePattern);
        expect(product, equals('Derived by automated computational analysis'));
      });
    });

    group('Get aminoacid sequence |', () {
      const featureAminoacidSequencePattern = r'^\s{21}\/translation\=\"(.+)\"?$';

      test('Should throw FileDataFormatException when aminoacid sequence is not in pattern', () {
        const featureAminoacidSequence =
            '                     /translation=MTQLQISLLLTATISLLHLVVAT';
        final aminoacidSequenceCall = genbankGenericFeature.getData;
        expect(
          () => aminoacidSequenceCall(featureAminoacidSequence, featureAminoacidSequencePattern),
          throwsA(isA<FileDataFormatException>()),
        );
      });

      test('Should get aminoacid sequence', () {
        const featureAminoacidSequence =
            '                     /translation="MTQLQISLLLTATISLLHLVVA"';
        final aminoacidSequence = genbankGenericFeature.getData(
          featureAminoacidSequence,
          featureAminoacidSequencePattern,
        );
        expect(aminoacidSequence, equals('MTQLQISLLLTATISLLHLVVA'));
      });
    });

    group('Get gene |', () {
      const featureGenePattern = r'^\s{21}\/gene\=\"(.+)\"$';

      test('Should throw FileDataFormatException when gene is not in pattern', () {
        const featureGene = '                     /gene="AXL2';
        final geneCall = genbankGenericFeature.getData;
        expect(
          () => geneCall(featureGene, featureGenePattern),
          throwsA(isA<FileDataFormatException>()),
        );
      });

      test('Should get gene', () {
        const featureGene = '                     /gene="AXL2"';
        final gene = genbankGenericFeature.getData(featureGene, featureGenePattern);
        expect(gene, equals('AXL2'));
      });
    });

    group('Get codon start |', () {
      const featureCodonStartPattern = r'^\s{21}\/codon_start\=(\d{1})$';

      test('Should throw FileDataFormatException when codon start is not in pattern', () {
        const featureCodonStart = '                     /codon_start="3"';
        final codonStartCall = genbankGenericFeature.getData;
        expect(
          () => codonStartCall(featureCodonStart, featureCodonStartPattern),
          throwsA(isA<FileDataFormatException>()),
        );
      });

      test('Should get codon start', () {
        const featureCodonStart = '                     /codon_start=3';
        final codonStart =
            genbankGenericFeature.getData(featureCodonStart, featureCodonStartPattern);
        expect(codonStart, equals("3"));
      });
    });

    group('Get another |', () {
      const featuresAnotherPattern =
          r'^\s{21}\/((?!product)(?!note)(?!translation)(?!gene)(?!codon_start).+)\=(.+)$';

      test(
        'Should throw FileDataFormatException when not in pattern',
        () {
          const featureAnother = '                     /protein_id=';
          final featureAnotherCall = genbankGenericFeature.getMapAnotherData;
          expect(
            () => featureAnotherCall(featureAnother, featuresAnotherPattern),
            throwsA(isA<FileDataFormatException>()),
          );
        },
      );

      test(
        'Should throw FileDataFormatException when a knowledge resource is found',
        () {
          const featureAnother = '                     /gene="AXL2"';
          final featureAnotherCall = genbankGenericFeature.getMapAnotherData;
          expect(
            () => featureAnotherCall(featureAnother, featuresAnotherPattern),
            throwsA(isA<FileDataFormatException>()),
          );
        },
      );
    });
  });
}
