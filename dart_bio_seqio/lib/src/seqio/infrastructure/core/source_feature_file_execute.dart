import '../../domain/entities/genbank/feature.dart';
import 'models/feature_identifier_positions.dart';
import 'source_feature_file_patterns.dart';

abstract class SourceFeatureFileExecute {
  Map<String, Function> _parseEvents = {};

  Map<String, Function> get patternsList => Map.from({
        sourceFeatureFilePatterns.locationPattern: getLocations,
      });

  void callActionByPattern(String value) {
    patternsList.keys.forEach((pattern) {
      final regexPattern = RegExp(pattern);
      if (regexPattern.hasMatch(value)) {
        final function = patternsList[pattern]!;
        _parseEvents.addAll({
          // ignore: avoid_dynamic_calls
          pattern: () => function.call(value),
        });

        return;
      }
    });
  }

  Feature? orchestrateParseEventsToRun(String value) {
    if (_isNextFeature(value) || _isFinishFeature(value)) {
      late Feature feature;
      _parseEvents.keys.forEach((event) {
        // ignore: avoid_dynamic_calls
        final featureData = _parseEvents[event]!.call();
        switch (featureData.runtimeType) {
          case FeatureIdentifierPositions:
            {
              feature = Feature(
                type: (featureData as FeatureIdentifierPositions).identifier,
                positions: featureData.featurePositions.positions,
                strand: featureData.featurePositions.strand,
              );
            }
        }
      });
      _restartEvents();

      return feature;
    }

    return null;
  }

  bool _isNextFeature(String value) {
    var isNextFeature = false;

    for (final pattern in patternsList.keys) {
      final regexPattern = RegExp(pattern);
      if (regexPattern.hasMatch(value)) {
        isNextFeature = _isRepetitiveEvent(pattern);

        break;
      }
    }

    return isNextFeature;
  }

  bool _isRepetitiveEvent(String pattern) => _parseEvents.containsKey(pattern);

  bool _isFinishFeature(value) => value == "";

  void _restartEvents() => _parseEvents = {};

  SourceFeatureFilePatterns get sourceFeatureFilePatterns;
  FeatureIdentifierPositions getLocations(String featureLocation);
}
