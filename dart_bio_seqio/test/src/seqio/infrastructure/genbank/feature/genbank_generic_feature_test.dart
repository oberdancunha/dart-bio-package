import 'package:dart_bio_core/exceptions.dart';
import 'package:dart_bio_seqio/src/seqio/infrastructure/genbank/feature/genbank_generic_feature.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late GenbankGenericFeature genbankGenericFeature;

  setUpAll(() {
    genbankGenericFeature = GenbankGenericFeature();
  });

  group('Get product |', () {
    late String productPattern;

    setUpAll(() {
      productPattern = r'^\s{21}\/product\=\"(.+)\"?$';
    });

    test('Should throw FileDataFormatException when product description is not in pattern', () {
      const featureProduct = '                     /product=';
      final productCall = genbankGenericFeature.getData;
      expect(
        () => productCall(featureProduct, productPattern),
        throwsA(isA<FileDataFormatException>()),
      );
    });

    test('Should get product description', () {
      const featureProduct =
          '                     /product="flagella biosynthesis regulatory protein FliZ"';
      final product = genbankGenericFeature.getData(featureProduct, productPattern);
      expect(product, equals('flagella biosynthesis regulatory protein FliZ'));
    });
  });

  group('Get note |', () {
    late String notePattern;

    setUpAll(() {
      notePattern = r'^\s{21}\/note\=\"(.+)\"?$';
    });

    test('Should throw FileDataFormatException when note is not in pattern', () {
      const featureNote = '                     /note=Derived by automated computational analysis';
      final noteCall = genbankGenericFeature.getData;
      expect(
        () => noteCall(featureNote, notePattern),
        throwsA(isA<FileDataFormatException>()),
      );
    });

    test('Should get note description', () {
      const featureNote =
          '                     /note="Derived by automated computational analysis"';
      final product = genbankGenericFeature.getData(featureNote, notePattern);
      expect(product, equals('Derived by automated computational analysis'));
    });
  });

  group('Get aminoacid sequence |', () {
    const aminoacidSequencePattern = r'^\s{21}\/translation\=\"(.+)\"?$';

    test('Should throw FileDataFormatException when aminoacid sequence is not in pattern', () {
      const featureAminoacidSequence = '                     /translation=MTQLQISLLLTATISLLHLVVAT';
      final aminoacidSequenceCall = genbankGenericFeature.getData;
      expect(
        () => aminoacidSequenceCall(featureAminoacidSequence, aminoacidSequencePattern),
        throwsA(isA<FileDataFormatException>()),
      );
    });

    test('Should get aminoacid sequence', () {
      const featureAminoacidSequence = '                     /translation="MTQLQISLLLTATISLLHLVVA"';
      final aminoacidSequence = genbankGenericFeature.getData(
        featureAminoacidSequence,
        aminoacidSequencePattern,
      );
      expect(aminoacidSequence, equals('MTQLQISLLLTATISLLHLVVA'));
    });
  });

  group('Get gene |', () {
    const genePattern = r'^\s{21}\/gene\=\"(.+)\"$';

    test('Should throw FileDataFormatException when gene is not in pattern', () {
      const featureGene = '                     /gene="AXL2';
      final geneCall = genbankGenericFeature.getData;
      expect(() => geneCall(featureGene, genePattern), throwsA(isA<FileDataFormatException>()));
    });

    test('Should get gene', () {
      const featureGene = '                     /gene="AXL2"';
      final gene = genbankGenericFeature.getData(featureGene, genePattern);
      expect(gene, equals('AXL2'));
    });
  });
}
