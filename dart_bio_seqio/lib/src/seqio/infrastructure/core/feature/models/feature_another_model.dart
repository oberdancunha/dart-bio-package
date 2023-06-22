// ignore_for_file: avoid_dynamic_calls
import 'package:dart_bio_dependency_module/dart_bio_dependency_module.dart';

import '../../../../domain/entities/feature.dart';
import '../../data_model.dart';

class FeatureAnotherModel implements DataModel<Feature> {
  Map<String, String> another;

  FeatureAnotherModel({
    required this.another,
  });

  @override
  Feature toDomain(Feature feature) {
    final featuresAlreadyAdded = feature.features != null
        ? feature.features!.toMutableList().asList()
        : <Map<String, dynamic>>[];
    final isContinuationPreviousFeature = another.keys.first == 'continuation_previous_feature';
    if (isContinuationPreviousFeature) {
      final lastFeatureAddedKey = featuresAlreadyAdded.last.keys.elementAt(0);
      featuresAlreadyAdded.last[lastFeatureAddedKey] += ' ${another.values.first}';
    } else {
      featuresAlreadyAdded.add(another);
    }

    return feature.copyWith(
      features: featuresAlreadyAdded.toImmutableList(),
    );
  }
}
