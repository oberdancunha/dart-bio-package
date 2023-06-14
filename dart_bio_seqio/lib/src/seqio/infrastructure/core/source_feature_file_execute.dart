import 'models/feature_identifier_positions.dart';
import 'source_feature_file_patterns.dart';

abstract class SourceFeatureFileExecute {
  SourceFeatureFilePatterns get sourceFeatureFilePatterns;

  Map<RegExp, Function> get patternsList => Map.from({
        sourceFeatureFilePatterns.locationPatternRegExp: getLocations,
      });

  void callActionByPattern(String value) {
    patternsList.keys.forEach((regexPattern) {
      if (regexPattern.hasMatch(value)) {
        final function = patternsList[regexPattern]!;
        // ignore: avoid_dynamic_calls
        function.call(value);

        return;
      }
    });
  }

  FeatureIdentifierPositions getLocations(String featureLocation);
}
