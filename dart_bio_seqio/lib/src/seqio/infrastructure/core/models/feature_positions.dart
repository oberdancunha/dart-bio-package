import '../../../domain/entities/genbank/location_position.dart';

class FeaturePositions {
  final List<LocationPosition> positions;
  final int strand;

  FeaturePositions({
    required this.positions,
    required this.strand,
  });
}
