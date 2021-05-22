import 'dart:convert';
import 'dart:io';

import 'package:kt_dart/collection.dart';

import '../../core/exceptions.dart';
import '../genbank/feature.dart';
import '../genbank/genbank.dart';
import '../genbank/locus.dart';
import '../genbank/locus_details.dart';
import '../genbank/reference.dart';

class GenbankRepositoryFile {
  Stream<String> open(String fileName) {
    final file = File(fileName);
    if (file.existsSync()) {
      final lines = file.openRead().transform(utf8.decoder).transform(const LineSplitter());

      return lines;
    } else {
      throw FileNotFoundException();
    }
  }

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
      final regexLabelAndValue = RegExp(r'^\s*([A-Z]+)\s*(.*)$');

      (await lines.toList()).forEach((line) {
        final matchLabelAndValue = regexLabelAndValue.allMatches(line);
        if (matchLabelAndValue.isNotEmpty) {
          currentLabel = matchLabelAndValue.elementAt(0).group(1);
          lastLabel = currentLabel;
          value = matchLabelAndValue.elementAt(0).group(2);
        } else {
          currentLabel = lastLabel;
        }
        switch (currentLabel) {
          case 'LOCUS':
            {
              if (locusData!.isNotEmpty) {
                genbankData.add(
                  Genbank(
                    locus: getLocus(
                      locusData: locusData!,
                      locusSequence: locusSequence,
                    ),
                    locusDetails: getLocusDetails(locusDetailsData),
                    features: const KtList.empty(),
                  ),
                );
              }
              locusData = line;
            }
            break;
          case 'DEFINITION':
            {
              locusDetailsData.add(value!);
            }
            break;
          case 'FEATURES':
            {
              featuresValues.add(value!);
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
          locus: getLocus(
            locusData: locusData!,
            locusSequence: locusSequence,
          ),
          locusDetails: getLocusDetails(locusDetailsData),
          features: const KtList.empty(),
        ),
      );

      return genbankData.toImmutableList();
    } on Exception {
      throw Error();
    }
  }

  Locus getLocus({
    required String locusData,
    required List<String> locusSequence,
  }) {
    final locusDataSplitted = locusData.split(RegExp(r'\s+'));

    return Locus(
      name: locusDataSplitted[1],
      length: int.tryParse(locusDataSplitted[2].toString())!,
      type: locusDataSplitted[4],
      shape: locusDataSplitted[5],
      taxonomicDivision: locusDataSplitted[6],
      releaseDate: locusDataSplitted[7],
      sequence: formatLocusSequence(locusSequence.join()),
    );
  }

  // ignore: long-method
  LocusDetails getLocusDetails(List<String> locusDetailsGenbank) {
    final referencesData = <Reference>[];
    String? currentLabel;
    String? lastLabel;
    String value;
    final definitionValue = <String>[];
    String? accessionValue;
    int? versionValue;
    final keywordsValue = <String>[];
    final sourceValue = <String>[];
    final organismValue = <String>[];
    final referenceValue = <String>[];
    final authorValue = <String>[];
    final titleValue = <String>[];
    final journalValue = <String>[];
    int pubmedId = 0;
    final regexLabelAndValue = RegExp(r'^\s*([A-Z]+)\s+(.+)$');

    locusDetailsGenbank.forEach((locusDetail) {
      final matchLabelAndValue = regexLabelAndValue.allMatches(locusDetail);
      if (matchLabelAndValue.isNotEmpty) {
        currentLabel = matchLabelAndValue.elementAt(0).group(1);
        lastLabel = currentLabel;
        value = matchLabelAndValue.elementAt(0).group(2)!;
      } else {
        currentLabel = lastLabel;
        value = locusDetail.replaceAll(RegExp(r'^\s+'), "");
      }
      switch (currentLabel) {
        case 'DEFINITION':
          {
            definitionValue.add(value);
          }
          break;
        case 'ACCESSION':
          {
            accessionValue = value;
          }
          break;
        case 'VERSION':
          {
            final versionOnlyNumberString = value.split('.')[1];
            versionValue = int.tryParse(versionOnlyNumberString);
          }
          break;
        case 'KEYWORDS':
          {
            keywordsValue.add(value);
          }
          break;
        case 'SOURCE':
          {
            sourceValue.add(value);
          }
          break;
        case 'ORGANISM':
          {
            organismValue.add(value);
          }
          break;
        case 'REFERENCE':
          {
            if (referenceValue.isNotEmpty) {
              final referenceData = _getReferenceData(
                referenceValue: referenceValue,
                authorValue: authorValue,
                titleValue: titleValue,
                journalValue: journalValue,
                pubmedId: pubmedId,
              );
              referencesData.add(referenceData);
              referenceValue.clear();
              authorValue.clear();
              titleValue.clear();
              journalValue.clear();
              pubmedId = 0;
            }
            referenceValue.add(value);
          }
          break;
        case 'AUTHORS':
          {
            authorValue.add(value);
          }
          break;
        case 'TITLE':
          {
            titleValue.add(value);
          }
          break;
        case 'JOURNAL':
          {
            journalValue.add(value);
          }
          break;
        case 'PUBMED':
          {
            pubmedId = int.tryParse(value)!;
          }
          break;
      }
    });
    if (referenceValue.isNotEmpty) {
      final referenceData = _getReferenceData(
        referenceValue: referenceValue,
        authorValue: authorValue,
        titleValue: titleValue,
        journalValue: journalValue,
        pubmedId: pubmedId,
      );
      referencesData.add(referenceData);
    }
    final LocusDetails locusDetails = LocusDetails(
      definition: definitionValue.join(' '),
      accession: accessionValue,
      version: versionValue,
      keywords: keywordsValue.join(' '),
      source: sourceValue.join(' '),
      organism: organismValue.join('; ').replaceAll(';;', ';'),
      references: referencesData.toImmutableList(),
    );

    return locusDetails;
  }

  // ignore: long-parameter-list
  Reference _getReferenceData({
    required List<String> referenceValue,
    required List<String> authorValue,
    required List<String> titleValue,
    required List<String> journalValue,
    required int pubmedId,
  }) =>
      Reference(
        description: referenceValue.join(' '),
        authors: authorValue.join(' '),
        title: titleValue.join(' '),
        journal: journalValue.join(' '),
        pubmed: pubmedId > 0 ? pubmedId : null,
      );

  String formatLocusSequence(String locusSequence) => locusSequence
      .replaceAll(RegExp(r'\s'), '')
      .replaceAll(RegExp('[0-9]'), '')
      .replaceAll(RegExp(r'\n'), '');

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
