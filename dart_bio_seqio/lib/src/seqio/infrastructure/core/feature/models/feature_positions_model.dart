import '../../../../domain/entities/location_position.dart';

class FeaturePositionsModel {
  final List<LocationPosition> positions;
  final int strand;

  FeaturePositionsModel({
    required this.positions,
    required this.strand,
  });
}
