import 'package:kt_dart/kt.dart';

import '../../../core/value_transformer.dart';
import '../../domain/genbank/feature.dart';

class FeaturesDto {
  KtList<Feature> fromGenbankFile({
    required List<String> features,
    required List<String> locusSequence,
  }) {
    final featuresData = <Feature>[];
    final regexFeatureTypeAndValue = RegExp(r'^\s{5}([\w+]+)\s+(.+)$');
    String? currentFeatureType;
    String? lastFeatureType;
    String featureValues;
    String additionalFeatureLabel = '';
    dynamic? additionalFeatureValues;
    int start = 0;
    int end = 0;
    int strand = 0;
    String? nameValue;
    final productValue = <String>[];
    final translationValue = <String>[];
    final noteValue = <String>[];
    final additionalFeaturesData = <Map<String, dynamic>>[];

    features.forEach((feature) {
      final matchLabelAndValue = regexFeatureTypeAndValue.allMatches(feature);
      if (matchLabelAndValue.isNotEmpty) {
        if (start > 0) {
          featuresData.add(
            Feature(
              start: start,
              end: end,
              strand: strand,
              type: currentFeatureType!,
              product: productValue.isNotEmpty ? productValue.join(' ') : null,
              aminoacids: translationValue.isNotEmpty ? translationValue.join() : null,
              nucleotides: _getNucleotides(
                currentFeatureType: currentFeatureType!,
                strand: strand,
                locusSequence: locusSequence,
                start: start,
                end: end,
                additionalFeaturesData: additionalFeaturesData,
              ),
              name: nameValue,
              note: noteValue.isNotEmpty ? noteValue.join(' ') : null,
              features: additionalFeaturesData.isNotEmpty
                  ? additionalFeaturesData.toImmutableList()
                  : null,
            ),
          );
          start = 0;
          end = 0;
          strand = 0;
          nameValue = null;
          productValue.clear();
          translationValue.clear();
          noteValue.clear();
          additionalFeaturesData.clear();
          additionalFeatureLabel = '';
        }
        currentFeatureType = matchLabelAndValue.elementAt(0).group(1);
        lastFeatureType = currentFeatureType;
        featureValues = matchLabelAndValue.elementAt(0).group(2)!;
      } else {
        currentFeatureType = lastFeatureType;
        featureValues = feature.replaceAll(RegExp(r'^\s+'), "");
      }
      if (currentFeatureType != 'FEATURES') {
        final locations = _getLocations(featureValues);
        if (locations.isNotEmpty) {
          start = locations['start']!;
          end = locations['end']!;
          strand = locations['strand']!;
        }
        final additionalFeature = _getAdditionalFeature(
          featureValues: featureValues,
          currentAdditionalFeatureLabel: additionalFeatureLabel,
        );
        additionalFeatureLabel = additionalFeature['additionalFeatureLabel'].toString();
        additionalFeatureValues = additionalFeature['additionalFeatureValues'];
        if (additionalFeatureLabel != '') {
          additionalFeatureValues = additionalFeatureValues.replaceAll(RegExp(r'\"'), '');
          switch (additionalFeatureLabel) {
            case 'product':
              {
                productValue.add(additionalFeatureValues.toString());
              }
              break;
            case 'translation':
              {
                translationValue.add(additionalFeatureValues.toString());
              }
              break;
            case 'gene':
              {
                nameValue = additionalFeatureValues.toString();
              }
              break;
            case 'note':
              {
                noteValue.add(additionalFeatureValues.toString());
              }
              break;
            default:
              {
                additionalFeatureValues = additionalFeatureValues is String
                    ? additionalFeatureValues.toString()
                    : int.tryParse(additionalFeatureValues.toString());
                additionalFeaturesData.add({additionalFeatureLabel: additionalFeatureValues});
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
        strand: strand,
        type: currentFeatureType!,
        product: productValue.join(),
        aminoacids: translationValue.join(),
        nucleotides: _getNucleotides(
          currentFeatureType: currentFeatureType!,
          strand: strand,
          locusSequence: locusSequence,
          start: start,
          end: end,
          additionalFeaturesData: additionalFeaturesData,
        ),
        name: nameValue,
        note: noteValue.isNotEmpty ? noteValue.join(' ') : null,
        features: additionalFeaturesData.toImmutableList(),
      ));
    }

    return featuresData.toImmutableList();
  }

  Map<String, dynamic> _getAdditionalFeature({
    required String featureValues,
    required String currentAdditionalFeatureLabel,
  }) {
    final regexAdditionalFeatures = RegExp(r'\/(.+)\=(.+)');
    final matchFeatureDetail = regexAdditionalFeatures.allMatches(featureValues);
    String? additionalFeatureLabel = currentAdditionalFeatureLabel;
    String? additionalFeatureValues;
    if (matchFeatureDetail.isNotEmpty) {
      additionalFeatureLabel = matchFeatureDetail.elementAt(0).group(1);
      additionalFeatureValues = matchFeatureDetail.elementAt(0).group(2);
    } else {
      additionalFeatureValues = featureValues;
    }

    return {
      'additionalFeatureLabel': additionalFeatureLabel,
      'additionalFeatureValues': additionalFeatureValues,
    };
  }

  Map<String, int> _getLocations(String featureValues) {
    final regexLocations = RegExp(r'\(?\<?(\d+)\.\.\>?(\d+)\)?$');
    final matchLocations = regexLocations.allMatches(featureValues);
    if (matchLocations.isNotEmpty) {
      return {
        'start': int.tryParse(matchLocations.elementAt(0).group(1).toString())!,
        'end': int.tryParse(matchLocations.elementAt(0).group(2).toString())!,
        'strand': _getStrand(featureValues),
      };
    }

    return {};
  }

  int _getStrand(String featureValues) {
    final regexIsComplement = RegExp('complement');
    final matchIsComplement = regexIsComplement.allMatches(featureValues);

    return matchIsComplement.isEmpty ? 0 : 1;
  }

  int _getCodonStart(List<Map<String, dynamic>> additionalFeaturesData) =>
      int.tryParse(additionalFeaturesData
          .firstWhere(
            (feature) => feature['codon_start'] != null,
            orElse: () => {},
          )['codon_start']
          .toString()) ??
      1;

  String? _getNucleotides({
    required String currentFeatureType,
    required int strand,
    required List<String> locusSequence,
    required int start,
    required int end,
    required List<Map<String, dynamic>> additionalFeaturesData,
  }) =>
      (currentFeatureType != 'source' &&
              currentFeatureType != 'gene' &&
              currentFeatureType != 'mRNA')
          ? (strand == 0
                  ? getSubSequence(
                      sequence: locusSequence,
                      start: start - 1,
                      end: end,
                      codonStart: _getCodonStart(additionalFeaturesData),
                    )
                  : getSubSequence(
                      sequence: locusSequence,
                      start: start - 1,
                      end: end,
                      codonStart: _getCodonStart(additionalFeaturesData),
                    ).flatMap(getReverseSequence).flatMap(getComplementSequence))
              .foldRight(null, (nucleotides, previous) => nucleotides.join())
          : null;
}
