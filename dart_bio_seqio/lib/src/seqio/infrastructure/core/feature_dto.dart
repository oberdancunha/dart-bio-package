import 'package:dart_bio_dependency_module/dart_bio_dependency_module.dart';

import '../../domain/entities/genbank/feature.dart';
import 'source_feature_file_execute.dart';

class FeatureDto {
  final SourceFeatureFileExecute _sourceFeatureFileExecute;

  FeatureDto(this._sourceFeatureFileExecute);

  KtList<Feature> fromFile({
    required List<String> features,
    required List<String> locusSequence,
  }) {
    final featuresData = <Feature>[];

    features.forEach((feature) {
      final featureData = _sourceFeatureFileExecute.orchestrateParseEventsToRun(feature);
      if (featureData != null) {
        featuresData.add(featureData);
      }
      _sourceFeatureFileExecute.callActionByPattern(feature);
    });
    final featureData = _sourceFeatureFileExecute.orchestrateParseEventsToRun("");
    if (featureData != null) {
      featuresData.add(featureData);
    }

    return featuresData.toImmutableList();
  }
}
