import '../../../../domain/entities/feature.dart';
import '../../data_model.dart';
import 'feature_positions_model.dart';

class FeatureIdentifierPositionsModel implements DataModel<Feature> {
  final String identifier;
  final FeaturePositionsModel featurePositions;

  FeatureIdentifierPositionsModel({
    required this.identifier,
    required this.featurePositions,
  });

  @override
  Feature toDomain(Feature feature) => feature.copyWith(
        type: identifier,
        positions: featurePositions.positions,
        strand: featurePositions.strand,
      );
}
