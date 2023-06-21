import 'package:dart_bio_core/exceptions.dart';

class FeaturePatternData {
  String getData(String featureData, String featurePattern) {
    final featureRegex = RegExp(featurePattern);
    final featureMatch = featureRegex.firstMatch(featureData);
    if (featureMatch != null) {
      final String featureData = featureMatch.group(1).toString().replaceAll('"', "");

      return featureData;
    }

    throw FileDataFormatException();
  }

  Map<String, String> getMapAnotherData(String featureData, String featurePattern) {
    final featureRegex = RegExp(featurePattern);
    final featureMatch = featureRegex.firstMatch(featureData);
    if (featureMatch != null && featureMatch.groupCount == 2) {
      final String featureKey = featureMatch.group(1).toString().replaceAll('"', "");
      final String featureData = featureMatch.group(2).toString().replaceAll('"', "");

      return {featureKey: featureData};
    }

    throw FileDataFormatException();
  }
}
