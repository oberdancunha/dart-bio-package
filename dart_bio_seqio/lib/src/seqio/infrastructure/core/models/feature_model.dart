import '../../../domain/entities/genbank/feature.dart';

abstract class FeatureModel {
  Feature toDomain(Feature feature);
}
