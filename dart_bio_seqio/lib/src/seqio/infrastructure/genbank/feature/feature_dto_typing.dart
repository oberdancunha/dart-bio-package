import '../../../domain/entities/genbank/location_position.dart';

class FeatureNameAndValueType {
  late String currentFeatureName;
  late String currentFeatureValue;

  FeatureNameAndValueType({
    required this.currentFeatureName,
    required this.currentFeatureValue,
  });

  FeatureNameAndValueType.empty() {
    currentFeatureName = '';
    currentFeatureValue = '';
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

class AdditionalFeatureType {
  late String additionalFeatureName;
  late dynamic additionalFeatureValue;

  AdditionalFeatureType({
    required this.additionalFeatureName,
    required this.additionalFeatureValue,
  });
}
