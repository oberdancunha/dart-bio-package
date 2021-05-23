import 'package:kt_dart/collection.dart';

import '../../core/i_repository_file.dart';
import '../../domain/genbank/feature.dart';
import '../../domain/genbank/genbank.dart';
import '../../domain/genbank/i_genbank_repository_file.dart';
import 'locus_details_dto.dart';
import 'locus_dto.dart';

class GenbankRepositoryFile extends IRepositoryFile implements IGenbankRepositoryFile {
  final locusDto = LocusDto();
  final locusDetailsDto = LocusDetailsDto();

  @override
  Future<KtList<Genbank>> parser(Stream<String> lines) async {
    try {
      final genbankData = <Genbank>[];
      String? currentLabel;
      String? lastLabel;
      String? value;
      String? locusData;
      final locusDetailsData = <String>[];
      final featuresValues = <String>[];
      final locusSequence = <String>[];
      final regexLabelAndValue = RegExp(r'^\s*([A-Z//]+)\s*(.*)$');
      final mainLabels = ['LOCUS', 'DEFINITION', 'FEATURES', 'ORIGIN'];

      (await lines.toList()).forEach((line) {
        final matchLabelAndValue = regexLabelAndValue.allMatches(line);
        if (matchLabelAndValue.isNotEmpty) {
          currentLabel = matchLabelAndValue.elementAt(0).group(1);
          if (mainLabels.contains(currentLabel)) {
            lastLabel = currentLabel;
          } else {
            currentLabel = lastLabel;
          }
          value = matchLabelAndValue.elementAt(0).group(2);
        } else {
          currentLabel = lastLabel;
          value = line;
        }
        switch (currentLabel) {
          case 'LOCUS':
            {
              locusData = line;
            }
            break;
          case 'DEFINITION':
            {
              locusDetailsData.add(line);
            }
            break;
          case 'FEATURES':
            {
              featuresValues.add(line);
            }
            break;
          case 'ORIGIN':
            {
              if (value!.isNotEmpty) {
                locusSequence.add(value!);
              }
            }
            break;
        }
      });
      genbankData.add(
        Genbank(
          locus: locusDto.fromGenbankFile(
            locusData: locusData!,
            locusSequence: locusSequence,
          ),
          locusDetails: locusDetailsDto.fromGenbankFile(locusDetailsData),
          features: getFeatures(featuresValues),
        ),
      );

      return genbankData.toImmutableList();
    } on Exception {
      throw Error();
    }
  }

  KtList<Feature> getFeatures(List<String> features) {
    final featuresData = <Feature>[];
    String? currentLabel;
    String? lastLabel;
    String value;
    final regexFeatureLocations = RegExp(r'\(?\<?(\d+)\.\.\>?(\d+)\)?$');
    final regexIsComplement = RegExp('complement');
    final regexFeatureDetail = RegExp(r'\/(.+)\=(.+)');
    int start = 0;
    int end = 0;
    int? strand;
    String? anotherFeatureLabel;
    dynamic? anotherFeatureValue;
    final productValue = <String>[];
    final translationValue = <String>[];
    final anotherFeaturesData = <Map<String, dynamic>>[];

    features.forEach((feature) {
      final regexLabelAndValue = RegExp(r'^\s*([\w+]+)\s+(.+)$');
      final matchLabelAndValue = regexLabelAndValue.allMatches(feature);
      if (matchLabelAndValue.isNotEmpty) {
        if (start > 0) {
          featuresData.add(Feature(
            start: start,
            end: end,
            strand: strand!,
            type: currentLabel!,
            product: productValue.isNotEmpty ? productValue.join(' ') : null,
            aminoacids: translationValue.isNotEmpty ? translationValue.join() : null,
            features: anotherFeaturesData.isNotEmpty ? anotherFeaturesData.toImmutableList() : null,
          ));
          start = 0;
          end = 0;
          strand = null;
          productValue.clear();
          translationValue.clear();
          anotherFeaturesData.clear();
          anotherFeatureLabel = null;
        }
        currentLabel = matchLabelAndValue.elementAt(0).group(1);
        lastLabel = currentLabel;
        value = matchLabelAndValue.elementAt(0).group(2)!;
      } else {
        currentLabel = lastLabel;
        value = feature.replaceAll(RegExp(r'^\s+'), "");
      }
      if (currentLabel != 'FEATURES') {
        final matchLocations = regexFeatureLocations.allMatches(value);
        if (matchLocations.isNotEmpty) {
          start = int.tryParse(matchLocations.elementAt(0).group(1).toString())!;
          end = int.tryParse(matchLocations.elementAt(0).group(2).toString())!;
          final matchIsComplement = regexIsComplement.allMatches(value);
          strand = matchIsComplement.isEmpty ? 0 : 1;
        }
        final matchFeatureDetail = regexFeatureDetail.allMatches(value);
        if (matchFeatureDetail.isNotEmpty) {
          anotherFeatureLabel = matchFeatureDetail.elementAt(0).group(1);
          anotherFeatureValue = matchFeatureDetail.elementAt(0).group(2).toString();
        } else {
          anotherFeatureValue = value;
        }
        if (anotherFeatureLabel != null) {
          anotherFeatureValue = anotherFeatureValue.replaceAll(RegExp(r'\"'), '');
          switch (anotherFeatureLabel) {
            case 'product':
              {
                productValue.add(anotherFeatureValue.toString());
              }
              break;
            case 'translation':
              {
                translationValue.add(anotherFeatureValue.toString());
              }
              break;
            default:
              {
                anotherFeatureValue = anotherFeatureValue is String
                    ? anotherFeatureValue.toString()
                    : int.tryParse(anotherFeatureValue.toString());
                anotherFeaturesData.add({anotherFeatureLabel!: anotherFeatureValue});
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
        type: currentLabel!,
        product: productValue.join(),
        aminoacids: translationValue.join(),
        features: anotherFeaturesData.toImmutableList(),
      ));
    }

    return featuresData.toImmutableList();
  }
}
