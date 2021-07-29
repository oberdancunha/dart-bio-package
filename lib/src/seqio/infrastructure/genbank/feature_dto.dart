import 'package:kt_dart/kt.dart';

import '../../../core/value_transformer.dart';
import '../../domain/genbank/feature.dart';
import 'feature_dto_typing.dart';

class FeatureDto {
  KtList<Feature> fromGenbankFile({
    required List<String> features,
    required List<String> locusSequence,
  }) {
    final featuresData = <Feature>[];
    String? currentFeatureName;
    String? lastFeatureName;
    String currentFeatureValue;
    String additionalFeatureName = '';
    dynamic? additionalFeatureValue;
    int start = 0;
    int end = 0;
    int strand = 0;
    String? nameValue;
    final productValue = <String>[];
    final translationValue = <String>[];
    final noteValue = <String>[];
    final additionalFeaturesData = <Map<String, dynamic>>[];
    features.forEach((feature) {
      final featureNameAndValue = _getFeatureNameAndValue(feature);
      if (featureNameAndValue.currentFeatureName.isNotEmpty) {
        if (start > 0) {
          featuresData.add(
            Feature(
              start: start,
              end: end,
              strand: strand,
              type: currentFeatureName!,
              product: _getProduct(productValue),
              aminoacids: _getTranslation(translationValue),
              nucleotides: _getNucleotides(
                currentFeatureName: currentFeatureName!,
                strand: strand,
                locusSequence: locusSequence,
                start: start,
                end: end,
                additionalFeaturesData: additionalFeaturesData,
              ),
              name: nameValue,
              note: _getNote(noteValue),
              features: _getAdditionalFeatures(additionalFeaturesData),
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
          additionalFeatureName = '';
        }
        currentFeatureName = featureNameAndValue.currentFeatureName;
        lastFeatureName = currentFeatureName;
        currentFeatureValue = featureNameAndValue.currentFeatureValue;
      } else {
        currentFeatureName = lastFeatureName;
        currentFeatureValue = _removeBeginningWhitespaces(feature);
      }
      if (currentFeatureName != 'FEATURES') {
        final locations = _getLocations(currentFeatureValue);
        if (locations.start != 0) {
          start = locations.start;
          end = locations.end;
          strand = locations.strand;
        }
        final additionalFeature = _getAdditionalFeature(
          currentFeatureValue: currentFeatureValue,
          currentAdditionalFeatureName: additionalFeatureName,
        );
        additionalFeatureName = additionalFeature.additionalFeatureName;
        additionalFeatureValue = additionalFeature.additionalFeatureValue;
        if (additionalFeatureName != '') {
          additionalFeatureValue = _removeDoubleQuotes(additionalFeatureValue);
          switch (additionalFeatureName) {
            case 'product':
              {
                productValue.add(additionalFeatureValue.toString());
              }
              break;
            case 'translation':
              {
                translationValue.add(additionalFeatureValue.toString());
              }
              break;
            case 'gene':
              {
                nameValue = additionalFeatureValue.toString();
              }
              break;
            case 'note':
              {
                noteValue.add(additionalFeatureValue.toString());
              }
              break;
            default:
              {
                additionalFeaturesData.add({additionalFeatureName: additionalFeatureValue});
              }
              break;
          }
        }
      }
    });
    if (start != 0) {
      featuresData.add(
        Feature(
          start: start,
          end: end,
          strand: strand,
          type: currentFeatureName!,
          product: _getProduct(productValue),
          aminoacids: _getTranslation(translationValue),
          nucleotides: _getNucleotides(
            currentFeatureName: currentFeatureName!,
            strand: strand,
            locusSequence: locusSequence,
            start: start,
            end: end,
            additionalFeaturesData: additionalFeaturesData,
          ),
          name: nameValue,
          note: _getNote(noteValue),
          features: _getAdditionalFeatures(additionalFeaturesData),
        ),
      );
    }

    return featuresData.toImmutableList();
  }

  FeatureNameAndValueType _getFeatureNameAndValue(String feature) {
    final regexFeatureNameAndValue = RegExp(r'^\s{5}([\w+]+)\s+(.+)$');
    final matchNameAndValue = regexFeatureNameAndValue.allMatches(feature);
    if (matchNameAndValue.isNotEmpty) {
      return FeatureNameAndValueType(
        currentFeatureName: matchNameAndValue.elementAt(0).group(1)!,
        currentFeatureValue: matchNameAndValue.elementAt(0).group(2)!,
      );
    }

    return FeatureNameAndValueType.empty();
  }

  LocationsType _getLocations(String featureValue) {
    final regexLocations = RegExp(r'\(?\<?(\d+)\.\.\>?(\d+)\)?$');
    final matchLocations = regexLocations.allMatches(featureValue);
    if (matchLocations.isNotEmpty) {
      return LocationsType(
        start: int.tryParse(matchLocations.elementAt(0).group(1).toString())!,
        end: int.tryParse(matchLocations.elementAt(0).group(2).toString())!,
        strand: _getStrand(featureValue),
      );
    }

    return LocationsType.empty();
  }

  int _getStrand(String featureValue) {
    final regexIsComplement = RegExp('complement');
    final matchIsComplement = regexIsComplement.allMatches(featureValue);

    return matchIsComplement.isEmpty ? 0 : 1;
  }

  String _removeBeginningWhitespaces(String line) => line.replaceAll(RegExp(r'^\s+'), "");

  String _removeDoubleQuotes(value) => value.toString().replaceAll(RegExp(r'\"'), '');

  AdditionalFeatureType _getAdditionalFeature({
    required String currentFeatureValue,
    required String currentAdditionalFeatureName,
  }) {
    final regexAdditionalFeatures = RegExp(r'\/(.+)\=(.+)');
    final matchFeatureDetail = regexAdditionalFeatures.allMatches(currentFeatureValue);
    String? additionalFeatureName = currentAdditionalFeatureName;
    String? additionalFeatureValue;
    if (matchFeatureDetail.isNotEmpty) {
      additionalFeatureName = matchFeatureDetail.elementAt(0).group(1);
      additionalFeatureValue = matchFeatureDetail.elementAt(0).group(2);
    } else {
      additionalFeatureValue = currentFeatureValue;
    }

    return AdditionalFeatureType(
      additionalFeatureName: additionalFeatureName!,
      additionalFeatureValue: additionalFeatureValue,
    );
  }

  String? _getNucleotides({
    required String currentFeatureName,
    required int strand,
    required List<String> locusSequence,
    required int start,
    required int end,
    required List<Map<String, dynamic>> additionalFeaturesData,
  }) {
    if (currentFeatureName != 'source' &&
        currentFeatureName != 'gene' &&
        currentFeatureName != 'mRNA') {
      var nucleotides = getSubSequence(
        sequence: locusSequence,
        start: start - 1,
        end: end,
        codonStart: _getCodonStart(additionalFeaturesData),
      );
      if (strand != 0) {
        nucleotides = nucleotides.flatMap(getReverseSequence).flatMap(getComplementSequence);
      }

      return nucleotides.foldRight(null, (nucleotides, previous) => nucleotides.join());
    }

    return null;
  }

  int _getCodonStart(List<Map<String, dynamic>> additionalFeaturesData) =>
      int.tryParse(additionalFeaturesData
          .firstWhere(
            (feature) => feature['codon_start'] != null,
            orElse: () => {},
          )['codon_start']
          .toString()) ??
      1;

  String? _getProduct(List<String> productValue) =>
      productValue.isNotEmpty ? productValue.join(' ') : null;

  String? _getTranslation(List<String> translationValue) =>
      translationValue.isNotEmpty ? translationValue.join() : null;

  String? _getNote(List<String> noteValue) => noteValue.isNotEmpty ? noteValue.join(' ') : null;

  KtList<Map<String, dynamic>>? _getAdditionalFeatures(
    List<Map<String, dynamic>> additionalFeaturesData,
  ) =>
      additionalFeaturesData.isNotEmpty ? additionalFeaturesData.toImmutableList() : null;
}
