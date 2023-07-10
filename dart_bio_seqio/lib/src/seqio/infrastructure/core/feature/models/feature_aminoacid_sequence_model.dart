import '../../../../domain/entities/feature.dart';
import '../../data_model.dart';

class FeatureAminoacidSequenceModel implements DataModel<Feature> {
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
