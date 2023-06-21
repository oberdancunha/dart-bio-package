import '../../../domain/entities/feature.dart';

abstract class FeatureModel {
  Feature toDomain(Feature feature);
}
