import 'feature_typing.dart';

class FeatureIdentifier {
  static const pattern = r'^\s{5}([\w+]+)\s+(.+)$';

  FeatureData getFeatureNameAndValue(String feature) {
    final regexFeatureNameAndValue = RegExp(pattern);
    final matchNameAndValue = regexFeatureNameAndValue.allMatches(feature);
    if (matchNameAndValue.isNotEmpty) {
      return FeatureData(
        name: matchNameAndValue.elementAt(0).group(1)!,
        value: matchNameAndValue.elementAt(0).group(2)!,
      );
    }

    return FeatureData.empty();
  }
}
