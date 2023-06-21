// ignore_for_file: avoid_bool_literals_in_conditional_expressions
import 'package:dart_bio_dependency_module/dart_bio_dependency_module.dart';

import '../../../domain/entities/feature.dart';
import 'feature_file_execute.dart';

class FeatureDto {
  final FeatureFileExecute _sourceFeatureFileExecute;

  FeatureDto(this._sourceFeatureFileExecute);

  KtList<Feature> fromFile({
    required List<String> features,
    required List<String> locusSequence,
  }) {
    final featuresData = <Feature>[];

    for (var featureLine = 0; featureLine < features.length; featureLine++) {
      final feature = features.elementAt(featureLine);
      if (_sourceFeatureFileExecute.isNextFeature(feature)) {
        featuresData.add(_sourceFeatureFileExecute.featureData);
        _sourceFeatureFileExecute.initFeature();
      }
      final isFinishFeature = featureLine + 1 == features.length;
      final isNextLineNewFeature = isFinishFeature
          ? false
          : _sourceFeatureFileExecute.isNextFeature(
              features.elementAt(featureLine + 1),
            );
      _sourceFeatureFileExecute.identifyActionByPattern(
        currentFeature: feature,
        isNextFeature: isNextLineNewFeature,
        isFinishFeature: isFinishFeature,
        locusSequence: locusSequence,
      );
    }
    featuresData.add(_sourceFeatureFileExecute.featureData);
    _sourceFeatureFileExecute.initFeature();

    return featuresData.toImmutableList();
  }
}
