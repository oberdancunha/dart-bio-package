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
  late int start;
  late int end;
  late int strand;

  LocationsType({
    required this.start,
    required this.end,
    required this.strand,
  });

  LocationsType.empty() {
    start = 0;
    end = 0;
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
