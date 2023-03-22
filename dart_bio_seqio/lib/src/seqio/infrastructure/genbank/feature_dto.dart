import 'package:dart_bio_core/value_transformer.dart';
import 'package:dart_bio_dependency_module/dart_bio_dependency_module.dart';

import '../../domain/entities/genbank/feature.dart';
import '../../domain/entities/genbank/location_position.dart';
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
    dynamic additionalFeatureValue;
    final positions = <LocationPosition>[];
    int strand = 0;
    String? nameValue;
    final productValue = <String>[];
    final translationValue = <String>[];
    final noteValue = <String>[];
    final additionalFeaturesData = <Map<String, dynamic>>[];
    features.forEach((feature) {
      final featureNameAndValue = _getFeatureNameAndValue(feature);
      if (featureNameAndValue.currentFeatureName.isNotEmpty) {
        if (positions.isNotEmpty) {
          featuresData.add(
            Feature(
              positions: positions
                  .map(
                    (position) => position.copyWith(),
                  )
                  .toList(),
              strand: strand,
              type: currentFeatureName!,
              product: _getProduct(productValue),
              aminoacids: _getTranslation(translationValue),
              nucleotides: _getNucleotides(
                currentFeatureName: currentFeatureName!,
                strand: strand,
                locusSequence: locusSequence,
                positions: positions,
                additionalFeaturesData: additionalFeaturesData,
              ),
              name: nameValue,
              note: _getNote(noteValue),
              features: _getAdditionalFeatures(additionalFeaturesData),
            ),
          );
          positions.clear();
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
        final locations = getLocations(currentFeatureValue);
        if (locations.positions.isNotEmpty) {
          positions.addAll(locations.positions.map((position) => position));
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
    if (positions.isNotEmpty) {
      featuresData.add(
        Feature(
          positions: positions,
          strand: strand,
          type: currentFeatureName!,
          product: _getProduct(productValue),
          aminoacids: _getTranslation(translationValue),
          nucleotides: _getNucleotides(
            currentFeatureName: currentFeatureName!,
            strand: strand,
            locusSequence: locusSequence,
            positions: positions,
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

  LocationsType getLocations(String featureValue) {
    final positions = _isMultipleLocations(featureValue)
        ? getMultiplePositions(featureValue)
        : getSinglePosition(featureValue);

    if (positions.isNotEmpty) {
      return LocationsType(
        positions: positions,
        strand: _getStrand(featureValue),
      );
    }

    return LocationsType.empty();
  }

  // Values:
  // join(<147594..151006,151097..>151166)
  // join(147594..151006,151097..151166)
  bool _isMultipleLocations(String featureValue) => featureValue.contains('join(');

  Iterable<RegExpMatch> _matchLocations(String featureValue, String locationPattern) {
    final regexLocations = RegExp(locationPattern);
    final matchLocations = regexLocations.allMatches(featureValue);

    return matchLocations;
  }

  // Values:
  // <143707..>147531
  // 143707..147531
  // complement(<139503..>141431)
  // complement(139503..141431)
  String get _singleLocationPattern => r'\(?\<?(\d+)\.\.\>?(\d+)\)?$';

  List<LocationPosition> getSinglePosition(String featureValue) {
    final matchLocations = _matchLocations(featureValue, _singleLocationPattern);
    if (matchLocations.isNotEmpty) {
      return [
        LocationPosition(
          start: int.tryParse(matchLocations.elementAt(0).group(1).toString())!,
          end: int.tryParse(matchLocations.elementAt(0).group(2).toString())!,
        ),
      ];
    }

    return List<LocationPosition>.empty();
  }

  // Values:
  // join(<147594..151006,151097..>151166)
  // join(147594..151006,151097..151166)
  // complement(join(<147594..151006,151097..>151166))
  // complement(join(147594..151006,151097..151166))
  String get _multipleLocationsPattern => r'\(?join\(?([\d\.\,]+)\)?\)?$';

  List<LocationPosition> getMultiplePositions(String featureValue) {
    final matchLocations = _matchLocations(featureValue, _multipleLocationsPattern);
    if (matchLocations.isNotEmpty) {
      final positions = matchLocations.elementAt(0).group(1)!.split(',');

      return positions.map((position) {
        final startAndEnd = position.split('..');

        return LocationPosition(
          start: int.tryParse(startAndEnd.elementAt(0))!,
          end: int.tryParse(startAndEnd.elementAt(1))!,
        );
      }).toList();
    }

    return List<LocationPosition>.empty();
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
    required List<LocationPosition> positions,
    required List<Map<String, dynamic>> additionalFeaturesData,
  }) {
    if (currentFeatureName != 'source' &&
        currentFeatureName != 'gene' &&
        currentFeatureName != 'mRNA') {
      final nucleotidesList = positions
          .map(
            (position) => getSubSequence(
              sequence: locusSequence,
              start: position.start - 1,
              end: position.end,
              codonStart: getCodonStart(additionalFeaturesData),
            ).flatMap(getSequenceToUpperCase).foldRight(
                  "",
                  (_, nucleotides) => nucleotides.join(),
                ),
          )
          .toList();
      Either<Unit, List<String>> nucleotides = right(nucleotidesList.join().split(''));
      if (strand != 0) {
        nucleotides = nucleotides.flatMap(getReverseSequence).flatMap(getComplementSequence);
      }

      return nucleotides.foldRight("", (_, nucleotides) => nucleotides.join());
    }

    return null;
  }

  int getCodonStart(List<Map<String, dynamic>> additionalFeaturesData) =>
      int.tryParse(
        additionalFeaturesData
            .firstWhere(
              (feature) => feature['codon_start'] != null,
              orElse: () => {},
            )['codon_start']
            .toString(),
      ) ??
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
