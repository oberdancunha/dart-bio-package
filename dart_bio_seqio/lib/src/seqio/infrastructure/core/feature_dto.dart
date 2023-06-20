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
      if (_sourceFeatureFileExecute.isNextFeature(feature) &&
          _sourceFeatureFileExecute.featureData.positions.elementAt(0).start > 0) {
        _sourceFeatureFileExecute.parseNucleotide(locusSequence);
        featuresData.add(_sourceFeatureFileExecute.featureData);
        _sourceFeatureFileExecute.initFeature();
      }
      _sourceFeatureFileExecute.callActionByPattern(feature);
    });
    _sourceFeatureFileExecute
      ..callActionByPattern("")
      ..parseNucleotide(locusSequence);
    featuresData.add(_sourceFeatureFileExecute.featureData);

    return featuresData.toImmutableList();
  }
}
