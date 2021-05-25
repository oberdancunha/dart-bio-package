import 'package:kt_dart/kt.dart';

import '../../domain/genbank/feature.dart';

class FeaturesDto {
  KtList<Feature> fromGenbankFile(List<String> features) {
    final featuresData = <Feature>[];
    final regexFeatureLocations = RegExp(r'\(?\<?(\d+)\.\.\>?(\d+)\)?$');
    final regexIsComplement = RegExp('complement');
    final regexFeatureDetail = RegExp(r'\/(.+)\=(.+)');
    final regexFeatureTypeAndValue = RegExp(r'^\s*([\w+]+)\s+(.+)$');
    String? currentFeatureType;
    String? lastFeatureType;
    String featureValue;
    int start = 0;
    int end = 0;
    int? strand;
    String? complementFeatureLabel;
    dynamic? complementFeatureValue;
    final productValue = <String>[];
    final translationValue = <String>[];
    final complementFeaturesData = <Map<String, dynamic>>[];

    features.forEach((feature) {
      final matchLabelAndValue = regexFeatureTypeAndValue.allMatches(feature);
      if (matchLabelAndValue.isNotEmpty) {
        if (start > 0) {
          featuresData.add(Feature(
            start: start,
            end: end,
            strand: strand!,
            type: currentFeatureType!,
            product: productValue.isNotEmpty ? productValue.join(' ') : null,
            aminoacids: translationValue.isNotEmpty ? translationValue.join() : null,
            features:
                complementFeaturesData.isNotEmpty ? complementFeaturesData.toImmutableList() : null,
          ));
          start = 0;
          end = 0;
          strand = null;
          productValue.clear();
          translationValue.clear();
          complementFeaturesData.clear();
          complementFeatureLabel = null;
        }
        currentFeatureType = matchLabelAndValue.elementAt(0).group(1);
        lastFeatureType = currentFeatureType;
        featureValue = matchLabelAndValue.elementAt(0).group(2)!;
      } else {
        currentFeatureType = lastFeatureType;
        featureValue = feature.replaceAll(RegExp(r'^\s+'), "");
      }
      if (currentFeatureType != 'FEATURES') {
        final matchLocations = regexFeatureLocations.allMatches(featureValue);
        if (matchLocations.isNotEmpty) {
          start = int.tryParse(matchLocations.elementAt(0).group(1).toString())!;
          end = int.tryParse(matchLocations.elementAt(0).group(2).toString())!;
          final matchIsComplement = regexIsComplement.allMatches(featureValue);
          strand = matchIsComplement.isEmpty ? 0 : 1;
        }
        final matchFeatureDetail = regexFeatureDetail.allMatches(featureValue);
        if (matchFeatureDetail.isNotEmpty) {
          complementFeatureLabel = matchFeatureDetail.elementAt(0).group(1);
          complementFeatureValue = matchFeatureDetail.elementAt(0).group(2).toString();
        } else {
          complementFeatureValue = featureValue;
        }
        if (complementFeatureLabel != null) {
          complementFeatureValue = complementFeatureValue.replaceAll(RegExp(r'\"'), '');
          switch (complementFeatureLabel) {
            case 'product':
              {
                productValue.add(complementFeatureValue.toString());
              }
              break;
            case 'translation':
              {
                translationValue.add(complementFeatureValue.toString());
              }
              break;
            default:
              {
                complementFeatureValue = complementFeatureValue is String
                    ? complementFeatureValue.toString()
                    : int.tryParse(complementFeatureValue.toString());
                complementFeaturesData.add({complementFeatureLabel!: complementFeatureValue});
              }
              break;
          }
        }
      }
    });
    if (start != 0) {
      featuresData.add(Feature(
        start: start,
        end: end,
        strand: strand!,
        type: currentFeatureType!,
        product: productValue.join(),
        aminoacids: translationValue.join(),
        features: complementFeaturesData.toImmutableList(),
      ));
    }

    return featuresData.toImmutableList();
  }
}
