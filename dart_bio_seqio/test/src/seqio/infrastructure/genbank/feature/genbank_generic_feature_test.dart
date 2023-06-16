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

    test('Should throw FileDataFormatException when product description is not found', () {
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

    test('Should throw FileDataFormatException when note is not found', () {
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
}
