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

    test('Should get product description when its all in just one line', () {
      const featureProduct =
          '                     /product="flagella biosynthesis regulatory protein FliZ"';
      final product = genbankGenericFeature.getData(featureProduct, productPattern);
      expect(product, equals('flagella biosynthesis regulatory protein FliZ'));
    });
  });
}
