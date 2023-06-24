import 'package:dart_bio_core/exceptions.dart';
import 'package:dart_bio_dependency_module/dart_bio_dependency_module.dart';

import '../../../domain/entities/feature.dart';
import 'feature_file_event.dart';

class FeatureDto {
  final FeatureFileEvent _featureFileEvent;

  FeatureDto(this._featureFileEvent);

  KtList<Feature> fromFile({
    required List<String> features,
    required List<String> locusSequence,
  }) {
    final featuresData = <Feature>[];

    features.forEach((feature) {
      if (_featureFileEvent.isNextFeature(feature)) {
        if (_featureFileEvent.data == Feature.init()) {
          throw FileDataFormatException();
        }
        _featureFileEvent.getNucleotideSequence(locusSequence);
        featuresData.add(_featureFileEvent.data);
        _featureFileEvent.initData();
      }
      _featureFileEvent.identifyActionByPattern(feature);
    });
    if (_featureFileEvent.data == Feature.init()) {
      throw FileDataFormatException();
    }
    _featureFileEvent.getNucleotideSequence(locusSequence);
    featuresData.add(_featureFileEvent.data);
    _featureFileEvent.initData();

    return featuresData.toImmutableList();
  }
}
