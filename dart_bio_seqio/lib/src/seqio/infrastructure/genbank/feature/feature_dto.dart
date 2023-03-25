import 'package:dart_bio_core/value_transformer.dart';
import 'package:dart_bio_dependency_module/dart_bio_dependency_module.dart';

import '../../../domain/entities/genbank/feature.dart';
import '../../../domain/entities/genbank/location_position.dart';
import 'feature_additional.dart';
import 'feature_identifier.dart';
import 'feature_location.dart';
import 'feature_sequence.dart';
import 'feature_typing.dart';

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
    var additionalFeatureValueType = AdditionalFeatureValueType.init();

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
              product: _getProduct(additionalFeatureValueType.product),
              aminoacids: featureSequence.getTranslation(additionalFeatureValueType.translation),
              nucleotides: featureSequence.getNucleotides(
                currentFeatureName: currentFeatureName!,
                strand: strand,
                locusSequence: locusSequence,
                positions: positions,
                additionalFeaturesData: additionalFeatureValueType.anotherFeatures,
              ),
              name: additionalFeatureValueType.name,
              note: _getNote(additionalFeatureValueType.note),
              features: _getAdditionalFeatures(additionalFeatureValueType.anotherFeatures),
            ),
          );
          positions.clear();
          strand = 0;
          additionalFeatureValueType = AdditionalFeatureValueType.init();
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
        additionalFeatureValueType = featureAdditional.getAdditionalFeaturesValues(
          additionalFeatureName: additionalFeatureName,
          additionalFeatureValue: additionalFeatureValue,
          additionalFeature: additionalFeatureValueType,
        );
      }
    });
    if (positions.isNotEmpty) {
      featuresData.add(
        Feature(
          positions: positions,
          strand: strand,
          type: currentFeatureName!,
          product: _getProduct(additionalFeatureValueType.product),
          aminoacids: featureSequence.getTranslation(additionalFeatureValueType.translation),
          nucleotides: featureSequence.getNucleotides(
            currentFeatureName: currentFeatureName!,
            strand: strand,
            locusSequence: locusSequence,
            positions: positions,
            additionalFeaturesData: additionalFeatureValueType.anotherFeatures,
          ),
          name: additionalFeatureValueType.name,
          note: _getNote(additionalFeatureValueType.note),
          features: _getAdditionalFeatures(additionalFeatureValueType.anotherFeatures),
        ),
      );
    }

    return featuresData.toImmutableList();
  }

  String? _getProduct(List<String> productValue) =>
      productValue.isNotEmpty ? productValue.join(' ') : null;

  String? _getNote(List<String> noteValue) => noteValue.isNotEmpty ? noteValue.join(' ') : null;

  KtList<Map<String, dynamic>>? _getAdditionalFeatures(
    List<Map<String, dynamic>> additionalFeaturesData,
  ) =>
      additionalFeaturesData.isNotEmpty ? additionalFeaturesData.toImmutableList() : null;
}
