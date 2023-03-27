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
    String? featureAdditionalName = featureName;
    String? featureAdditionalValue;
    if (matchFeatureDetail.isNotEmpty) {
      featureAdditionalName = matchFeatureDetail.elementAt(0).group(1);
      featureAdditionalValue = matchFeatureDetail.elementAt(0).group(2);
    } else {
      featureAdditionalValue = featureValue;
    }

    return FeatureData(
      name: featureAdditionalName!,
      value: featureAdditionalValue!,
    );
  }

  FeatureAdditionalValue getFeatureAdditionalValuesType({
    required String featureAdditionalName,
    required String featureAdditionalValue,
    required FeatureAdditionalValue featureAdditionalValuesType,
  }) {
    if (featureAdditionalName != '') {
      switch (featureAdditionalName) {
        // /product="seripauperin PAU8"

        case 'product':
          {
            featureAdditionalValuesType.product = featureAdditionalValue;
          }
          break;
        // /translation="MVKLTSIAAGVAAIAATASATTTLAQSDERVNLVELGVYVSDIR
        case 'translation':
          {
            featureAdditionalValuesType.translation = featureAdditionalValue;
          }
          break;
        // /gene="PAU8"
        case 'gene':
          {
            featureAdditionalValuesType.name = featureAdditionalValue;
          }
          break;
        // /note="hypothetical protein; member of the seripauperin
        case 'note':
          {
            featureAdditionalValuesType.note = featureAdditionalValue;
          }
          break;
        // /locus_tag="YAL068C"
        // /experiment="EXISTENCE:mutant phenotype:GO:0045944
        // /protein_id="NP_009332.1"
        // /db_xref="GeneID:851229
        default:
          {
            featureAdditionalValuesType
                .addAnotherFeatures({featureAdditionalName: featureAdditionalValue});
          }
          break;
      }
    }

    return featureAdditionalValuesType;
  }
}
