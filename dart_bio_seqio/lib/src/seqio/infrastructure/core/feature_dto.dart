import 'package:dart_bio_dependency_module/dart_bio_dependency_module.dart';

import '../../domain/entities/genbank/feature.dart';

class FeatureDto {
  KtList<Feature> fromGenbankFile({
    required List<String> features,
    required List<String> locusSequence,
  }) {
    final featuresData = <Feature>[];

    features.forEach((feature) {});

    return featuresData.toImmutableList();
  }
}
