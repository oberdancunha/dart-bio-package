import 'package:dart_bio_seqio/src/seqio/infrastructure/genbank/feature/genbank_feature_file_execute.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late GenbankFeatureFileExecute genbankFeatureFileExecute;

  setUpAll(() {
    genbankFeatureFileExecute = GenbankFeatureFileExecute();
  });

  test('Should verify genbank pattern line', () {
    const featureLocation = "     source          1..5028";
    genbankFeatureFileExecute.identifyActionByPattern(
      currentFeature: featureLocation,
      isNextFeature: true,
      isFinishFeature: true,
      locusSequence: [],
    );
  });

  group('getAnother function |', () {
    test('Should call getData function when another feature is continuous on another line', () {
      const recallLastEventPattern = r'^\s{21}((?!\/).+)\"?$';
      const featureAnother = '                     sequence:RefSeq:NP_460937.1"';
      final data = genbankFeatureFileExecute.getAnother(featureAnother, recallLastEventPattern);
      expect(
        data.another,
        equals(
          {'continuation_previous_feature': "sequence:RefSeq:NP_460937.1"},
        ),
      );
    });
  });
}
