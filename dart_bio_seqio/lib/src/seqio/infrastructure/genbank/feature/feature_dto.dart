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
    final featureIdentifier = FeatureIdentifier();
    final featureLocation = FeatureLocation();
    final featureSequence = FeatureSequence();
    final featureAdditional = FeatureAdditional();
    String? currentFeatureName;
    String? currentFeatureValue;
    var strand = 0;
    var featureAdditionalName = '';
    var positions = <LocationPosition>[];
    var featureAdditionalValuesType = FeatureAdditionalValue.init();

    features.forEach((feature) {
      final featureNameAndValue = featureIdentifier.getFeatureNameAndValue(feature);
      if (featureNameAndValue.name.isNotEmpty) {
        if (positions.isNotEmpty) {
          featuresData.add(
            _setFeature(
              positions: positions,
              strand: strand,
              currentFeatureName: currentFeatureName!,
              featureAdditionalValuesType: featureAdditionalValuesType,
              locusSequence: locusSequence,
              featureSequence: featureSequence,
            ),
          );
          positions.clear();
          strand = 0;
          featureAdditionalValuesType = FeatureAdditionalValue.init();
          featureAdditionalName = '';
        }
        currentFeatureName = featureNameAndValue.name;
      }
      currentFeatureValue = feature.removeBeginningWhitespaces;
      // FEATURES             Location/Qualifiers
      if (currentFeatureName != 'FEATURES') {
        final locations = featureLocation.getLocations(currentFeatureValue!);
        if (locations.positions.isNotEmpty) {
          positions = List.from(locations.positions);
          strand = locations.strand;
        }
        final featureAdditionalData = featureAdditional.getAdditionalFeatureData(
          featureName: featureAdditionalName,
          featureValue: currentFeatureValue!,
        );
        featureAdditionalName = featureAdditionalData.name;
        featureAdditionalValuesType = featureAdditional.getFeatureAdditionalValuesType(
          featureAdditionalName: featureAdditionalName,
          featureAdditionalValue: featureAdditionalData.value.removeDoubleQuotes,
          featureAdditionalValuesType: featureAdditionalValuesType,
        );
      }
    });
    if (positions.isNotEmpty) {
      featuresData.add(
        _setFeature(
          positions: positions,
          strand: strand,
          currentFeatureName: currentFeatureName!,
          featureAdditionalValuesType: featureAdditionalValuesType,
          locusSequence: locusSequence,
          featureSequence: featureSequence,
        ),
      );
    }

    return featuresData.toImmutableList();
  }

  Feature _setFeature({
    required List<LocationPosition> positions,
    required int strand,
    required String currentFeatureName,
    required FeatureAdditionalValue featureAdditionalValuesType,
    required List<String> locusSequence,
    required FeatureSequence featureSequence,
  }) =>
      Feature(
        positions: List.from(positions),
        strand: strand,
        type: currentFeatureName,
        product: featureAdditionalValuesType.product,
        aminoacids: featureAdditionalValuesType.translation,
        nucleotides: featureSequence.getNucleotides(
          currentFeatureName: currentFeatureName,
          strand: strand,
          locusSequence: locusSequence,
          positions: positions,
          additionalFeaturesData: featureAdditionalValuesType.anotherFeatures,
        ),
        name: featureAdditionalValuesType.name,
        note: featureAdditionalValuesType.note,
        features: featureAdditionalValuesType.anotherFeatures?.toImmutableList(),
      );
}
