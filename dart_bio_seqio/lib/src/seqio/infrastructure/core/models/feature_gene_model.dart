import '../../../domain/entities/feature.dart';
import 'feature_model.dart';

class FeatureGeneModel implements FeatureModel {
  final String gene;

  FeatureGeneModel({
    required this.gene,
  });

  @override
  Feature toDomain(Feature feature) => feature.copyWith(
        name: gene,
      );
}
