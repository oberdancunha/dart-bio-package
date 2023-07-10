import 'package:dart_bio_seqio/src/seqio/infrastructure/genbank/feature/genbank_feature_event.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late GenbankFeatureEvent genbankFeatureEvent;

  setUpAll(() {
    genbankFeatureEvent = GenbankFeatureEvent();
  });

  test('Should verify genbank pattern line', () {
    const featureLocation = "     source          1..5028";
    genbankFeatureEvent.identifyActionByPattern(featureLocation);
  });

  group('getAnother function |', () {
    test('Should call getData function when another feature is continuous on another line', () {
      const recallLastEventPattern = r'^\s{21}((?!\/).+)\"?$';
      const featureAnother = '                     sequence:RefSeq:NP_460937.1"';
      final data = genbankFeatureEvent.getAnother(featureAnother, recallLastEventPattern);
      expect(
        data.another,
        equals(
          {'continuation_previous_feature': "sequence:RefSeq:NP_460937.1"},
        ),
      );
    });
  });
}
