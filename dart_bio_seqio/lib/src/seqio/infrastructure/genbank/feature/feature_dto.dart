import 'package:dart_bio_core/value_transformer.dart';
import 'package:dart_bio_dependency_module/dart_bio_dependency_module.dart';

import '../../../domain/entities/genbank/feature.dart';
import '../../../domain/entities/genbank/location_position.dart';
import 'feature_additional.dart';
import 'feature_additional_value.dart';
import 'feature_identifier.dart';
import 'feature_location.dart';
import 'feature_sequence.dart';

class FeatureDto {
  KtList<Feature> fromGenbankFile({
    required List<String> features,
    required List<String> locusSequence,
  }) {
    final featuresData = <Feature>[];
    String? currentFeatureName;
    String? lastFeatureName;
    String currentFeatureValue;
    String additionalFeatureName = '';
    String additionalFeatureValue;
    final positions = <LocationPosition>[];
    int strand = 0;

    final featureIdentifier = FeatureIdentifier();
    final featureLocation = FeatureLocation();
    final featureSequence = FeatureSequence();
    final featureAdditional = FeatureAdditional();
    var featureAdditionalValue = FeatureAdditionalValue.init();

    features.forEach((feature) {
      final featureNameAndValue = featureIdentifier.getFeatureNameAndValue(feature);
      if (featureNameAndValue.name.isNotEmpty) {
        if (positions.isNotEmpty) {
          featuresData.add(
            Feature(
              positions: positions
                  .map(
                    (position) => position.copyWith(),
                  )
                  .toList(),
              strand: strand,
              type: currentFeatureName!,
              product: featureAdditionalValue.product,
              aminoacids: featureAdditionalValue.translation,
              nucleotides: featureSequence.getNucleotides(
                currentFeatureName: currentFeatureName!,
                strand: strand,
                locusSequence: locusSequence,
                positions: positions,
                additionalFeaturesData: featureAdditionalValue.anotherFeatures,
              ),
              name: featureAdditionalValue.name,
              note: featureAdditionalValue.note,
              features: featureAdditionalValue.anotherFeatures?.toImmutableList(),
            ),
          );
          positions.clear();
          strand = 0;
          featureAdditionalValue = FeatureAdditionalValue.init();
          additionalFeatureName = '';
        }
        currentFeatureName = featureNameAndValue.name;
        lastFeatureName = currentFeatureName;
        currentFeatureValue = featureNameAndValue.value;
      } else {
        currentFeatureName = lastFeatureName;
        currentFeatureValue = feature.removeBeginningWhitespaces;
      }
      if (currentFeatureName != 'FEATURES') {
        final locations = featureLocation.getLocations(currentFeatureValue);
        if (locations.positions.isNotEmpty) {
          positions.addAll(locations.positions.map((position) => position));
          strand = locations.strand;
        }
        final additionalFeatureData = featureAdditional.getAdditionalFeatureData(
          featureName: additionalFeatureName,
          featureValue: currentFeatureValue,
        );
        additionalFeatureName = additionalFeatureData.name;
        additionalFeatureValue = additionalFeatureData.value.removeDoubleQuotes;
        featureAdditionalValue = featureAdditional.getAdditionalFeaturesValues(
          additionalFeatureName: additionalFeatureName,
          additionalFeatureValue: additionalFeatureValue,
          additionalFeature: featureAdditionalValue,
        );
      }
    });
    if (positions.isNotEmpty) {
      featuresData.add(
        Feature(
          positions: positions,
          strand: strand,
          type: currentFeatureName!,
          product: featureAdditionalValue.product,
          aminoacids: featureAdditionalValue.translation,
          nucleotides: featureSequence.getNucleotides(
            currentFeatureName: currentFeatureName!,
            strand: strand,
            locusSequence: locusSequence,
            positions: positions,
            additionalFeaturesData: featureAdditionalValue.anotherFeatures,
          ),
          name: featureAdditionalValue.name,
          note: featureAdditionalValue.note,
          features: featureAdditionalValue.anotherFeatures?.toImmutableList(),
        ),
      );
    }

    return featuresData.toImmutableList();
  }
}
