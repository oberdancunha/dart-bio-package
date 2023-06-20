import '../../../domain/entities/genbank/feature.dart';
import 'feature_model.dart';

class FeatureAminoacidSequenceModel implements FeatureModel {
  final String aminoacidSequence;

  FeatureAminoacidSequenceModel({
    required this.aminoacidSequence,
  });

  @override
  Feature toDomain(Feature feature) => feature.copyWith(
        aminoacids: feature.aminoacids != null
            ? "${feature.aminoacids}$aminoacidSequence"
            : aminoacidSequence,
      );
}
