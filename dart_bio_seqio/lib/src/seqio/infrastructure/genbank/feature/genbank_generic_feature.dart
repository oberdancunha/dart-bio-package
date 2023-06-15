import 'package:dart_bio_core/exceptions.dart';

class GenbankGenericFeature {
  String getData(String featureData, String featurePattern) {
    final featureRegex = RegExp(featurePattern);
    final featureMatch = featureRegex.firstMatch(featureData);
    if (featureMatch != null) {
      final String featureData = featureMatch.group(1).toString().replaceAll('"', "");

      return featureData;
    }

    throw FileDataFormatException();
  }
}
