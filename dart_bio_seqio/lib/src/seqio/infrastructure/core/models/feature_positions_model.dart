import '../../../domain/entities/genbank/location_position.dart';

class FeaturePositionsModel {
  final List<LocationPosition> positions;
  final int strand;

  FeaturePositionsModel({
    required this.positions,
    required this.strand,
  });
}
