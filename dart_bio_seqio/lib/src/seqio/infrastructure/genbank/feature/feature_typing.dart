import '../../../domain/entities/genbank/location_position.dart';

class FeatureData {
  late String name;
  late String value;

  FeatureData({
    required this.name,
    required this.value,
  });

  FeatureData.empty() {
    name = '';
    value = '';
  }
}

class LocationsType {
  late List<LocationPosition> positions;
  late int strand;

  LocationsType({
    required this.positions,
    required this.strand,
  });

  LocationsType.empty() {
    positions = [];
    strand = 0;
  }
}
