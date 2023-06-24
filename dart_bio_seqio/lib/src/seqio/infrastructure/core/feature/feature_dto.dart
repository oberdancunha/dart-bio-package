import 'package:dart_bio_core/exceptions.dart';
import 'package:dart_bio_dependency_module/dart_bio_dependency_module.dart';

import '../../../domain/entities/feature.dart';
import 'feature_event.dart';

class FeatureDto {
  final FeatureEvent _featureEvent;

  FeatureDto(this._featureEvent);

  KtList<Feature> fromFile({
    required List<String> features,
    required List<String> locusSequence,
  }) {
    final featuresData = <Feature>[];

    features.forEach((feature) {
      if (_featureEvent.isNextFeature(feature)) {
        if (_featureEvent.data == Feature.init()) {
          throw FileDataFormatException();
        }
        _featureEvent.getNucleotideSequence(locusSequence);
        featuresData.add(_featureEvent.data);
        _featureEvent.initData();
      }
      _featureEvent.identifyActionByPattern(feature);
    });
    if (_featureEvent.data == Feature.init()) {
      throw FileDataFormatException();
    }
    _featureEvent.getNucleotideSequence(locusSequence);
    featuresData.add(_featureEvent.data);
    _featureEvent.initData();

    return featuresData.toImmutableList();
  }
}
