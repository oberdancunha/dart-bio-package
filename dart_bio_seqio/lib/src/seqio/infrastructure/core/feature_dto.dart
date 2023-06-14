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

    features.forEach(_sourceFeatureFileExecute.callActionByPattern);

    return featuresData.toImmutableList();
  }
}
