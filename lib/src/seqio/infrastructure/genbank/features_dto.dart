import 'package:kt_dart/kt.dart';

import '../../../core/value_transformer.dart';
import '../../domain/genbank/feature.dart';

class FeaturesDto {
  KtList<Feature> fromGenbankFile({
    required List<String> features,
    required List<String> locusSequence,
  }) {
    final featuresData = <Feature>[];
    final regexFeatureLocations = RegExp(r'\(?\<?(\d+)\.\.\>?(\d+)\)?$');
    final regexIsComplement = RegExp('complement');
    final regexFeatureDetail = RegExp(r'\/(.+)\=(.+)');
    final regexFeatureTypeAndValue = RegExp(r'^\s{5}([\w+]+)\s+(.+)$');
    String? currentFeatureType;
    String? lastFeatureType;
    String featureValue;
    String? complementFeatureLabel;
    dynamic? complementFeatureValue;
    int start = 0;
    int end = 0;
    int? strand;
    String? nameValue;
    final productValue = <String>[];
    final translationValue = <String>[];
    final noteValue = <String>[];
    final complementFeaturesData = <Map<String, dynamic>>[];
    int? codonStart;
    String? nucleotides;

    features.forEach((feature) {
      final matchLabelAndValue = regexFeatureTypeAndValue.allMatches(feature);

      if (matchLabelAndValue.isNotEmpty) {
        if (start > 0) {
          codonStart = int.tryParse(complementFeaturesData
                  .firstWhere(
                    (feature) => feature['codon_start'] != null,
                    orElse: () => {},
                  )['codon_start']
                  .toString()) ??
              1;
          nucleotides = (currentFeatureType != 'source' &&
                  currentFeatureType != 'gene' &&
                  currentFeatureType != 'mRNA')
              ? (strand == 0
                      ? getSubSequence(
                          sequence: locusSequence,
                          start: start - 1,
                          end: end,
                          codonStart: codonStart!,
                        )
                      : getSubSequence(
                          sequence: locusSequence,
                          start: start - 1,
                          end: end,
                          codonStart: codonStart!,
                        ).flatMap(getReverseSequence).flatMap(getComplementSequence))
                  .foldRight(null, (nucleotides, previous) => nucleotides.join())
              : null;
          featuresData.add(Feature(
            start: start,
            end: end,
            strand: strand!,
            type: currentFeatureType!,
            product: productValue.isNotEmpty ? productValue.join(' ') : null,
            aminoacids: translationValue.isNotEmpty ? translationValue.join() : null,
            nucleotides: nucleotides,
            name: nameValue,
            note: noteValue.isNotEmpty ? noteValue.join(' ') : null,
            features:
                complementFeaturesData.isNotEmpty ? complementFeaturesData.toImmutableList() : null,
          ));
          start = 0;
          end = 0;
          strand = null;
          nameValue = null;
          productValue.clear();
          translationValue.clear();
          noteValue.clear();
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
            case 'gene':
              {
                nameValue = complementFeatureValue.toString();
              }
              break;
            case 'note':
              {
                noteValue.add(complementFeatureValue.toString());
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
      codonStart = int.tryParse(complementFeaturesData
              .firstWhere(
                (feature) => feature['codon_start'] != null,
                orElse: () => {},
              )['codon_start']
              .toString()) ??
          1;
      nucleotides = (currentFeatureType != 'source' &&
              currentFeatureType != 'gene' &&
              currentFeatureType != 'mRNA')
          ? (strand == 0
                  ? getSubSequence(
                      sequence: locusSequence,
                      start: start - 1,
                      end: end,
                      codonStart: codonStart!,
                    )
                  : getSubSequence(
                      sequence: locusSequence,
                      start: start - 1,
                      end: end,
                      codonStart: codonStart!,
                    ).flatMap(getReverseSequence).flatMap(getComplementSequence))
              .foldRight(null, (nucleotides, previous) => nucleotides.join())
          : null;
      featuresData.add(Feature(
        start: start,
        end: end,
        strand: strand!,
        type: currentFeatureType!,
        product: productValue.join(),
        aminoacids: translationValue.join(),
        nucleotides: (currentFeatureType != 'source' &&
                currentFeatureType != 'gene' &&
                currentFeatureType != 'mRNA')
            ? (strand == 0
                    ? getSubSequence(
                        sequence: locusSequence,
                        start: start - 1,
                        end: end,
                        codonStart: codonStart!,
                      )
                    : getSubSequence(
                        sequence: locusSequence,
                        start: start - 1,
                        end: end,
                        codonStart: codonStart!,
                      ).flatMap(getReverseSequence).flatMap(getComplementSequence))
                .foldRight(null, (nucleotides, previous) => nucleotides.join())
            : null,
        name: nameValue,
        note: noteValue.isNotEmpty ? noteValue.join(' ') : null,
        features: complementFeaturesData.toImmutableList(),
      ));
    }

    return featuresData.toImmutableList();
  }
}
