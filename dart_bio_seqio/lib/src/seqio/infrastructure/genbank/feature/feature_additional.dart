import 'feature_additional_value.dart';
import 'feature_typing.dart';

class FeatureAdditional {
  static const pattern = r'\/(.+)\=(.+)';

  FeatureData getAdditionalFeatureData({
    required String featureValue,
    required String featureName,
  }) {
    final regexAdditionalFeatures = RegExp(r'\/(.+)\=(.+)');
    final matchFeatureDetail = regexAdditionalFeatures.allMatches(featureValue);
    String? additionalFeatureName = featureName;
    String? additionalFeatureValue;
    if (matchFeatureDetail.isNotEmpty) {
      additionalFeatureName = matchFeatureDetail.elementAt(0).group(1);
      additionalFeatureValue = matchFeatureDetail.elementAt(0).group(2);
    } else {
      additionalFeatureValue = featureValue;
    }

    return FeatureData(
      name: additionalFeatureName!,
      value: additionalFeatureValue!,
    );
  }

  FeatureAdditionalValue getAdditionalFeaturesValues({
    required String additionalFeatureName,
    required String additionalFeatureValue,
    required FeatureAdditionalValue additionalFeature,
  }) {
    if (additionalFeatureName != '') {
      switch (additionalFeatureName) {
        case 'product':
          {
            additionalFeature.product = additionalFeatureValue;
          }
          break;
        case 'translation':
          {
            additionalFeature.translation = additionalFeatureValue;
          }
          break;
        case 'gene':
          {
            additionalFeature.name = additionalFeatureValue;
          }
          break;
        case 'note':
          {
            additionalFeature.note = additionalFeatureValue;
          }
          break;
        default:
          {
            additionalFeature.addAnotherFeatures({additionalFeatureName: additionalFeatureValue});
          }
          break;
      }
    }

    return additionalFeature;
  }
}
