import '../../../../domain/entities/feature.dart';
import '../../data_model.dart';

class FeatureGeneModel implements DataModel<Feature> {
  final String gene;

  FeatureGeneModel({
    required this.gene,
  });

  @override
  Feature toDomain(Feature feature) => feature.copyWith(
        name: gene,
      );
}
