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

class AdditionalFeatureValueType {
  String? name;
  final List<String> product;
  final List<String> translation;
  final List<String> note;
  final List<Map<String, dynamic>> anotherFeatures;

  AdditionalFeatureValueType({
    required this.name,
    required this.product,
    required this.translation,
    required this.note,
    required this.anotherFeatures,
  });

  factory AdditionalFeatureValueType.init() => AdditionalFeatureValueType(
        name: null,
        product: [],
        translation: [],
        note: [],
        anotherFeatures: [],
      );
}
