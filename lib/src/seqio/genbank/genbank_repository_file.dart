import 'dart:convert';
import 'dart:io';

import 'package:kt_dart/collection.dart';

import '../../core/exceptions.dart';
import '../genbank/genbank.dart';
import '../genbank/locus.dart';
import '../genbank/locus_details.dart';
import '../genbank/reference.dart';

class GenbankRepositoryFile {
  Stream<String> open(String fileName) {
    final file = File(fileName);
    if (file.existsSync()) {
      final lines = file
          .openRead()
          .transform(utf8.decoder)
          .transform(const LineSplitter());

      return lines;
    } else {
      throw FileNotFoundException();
    }
  }

  Future<KtList<Genbank>> parser(Stream<String> lines) async {
    try {
      String locusData;
      List<String>? locusSequence;
      String locusSequenceFormatted;
      bool isLocusSequence = false;
      bool isDefinitionSection = false;
      bool isFeaturesSection = false;
      List<String>? locusDetailsData;
      List<String>? featuresData;
      (await lines.toList()).forEach((line) {
        final lineSplitted = line.split(RegExp(r'\s+'));
        if (lineSplitted[0] == 'LOCUS') {
          locusData = lineSplitted[0];
        } else if (lineSplitted[0] == 'DEFINITION' ||
            isDefinitionSection == true) {
          isDefinitionSection = true;
          locusDetailsData!.add(line);
        } else if (lineSplitted[0] == 'FEATURES' || isFeaturesSection == true) {
          isDefinitionSection = false;
          isFeaturesSection = true;
          featuresData!.add(line);
        } else if (lineSplitted[0] == 'ORIGIN') {
          isFeaturesSection = false;
          isLocusSequence = true;
        } else if (isLocusSequence == true) {
          locusSequence!.add(line);
        } else if (lineSplitted[0] == '//') {
          isFeaturesSection = false;
          isLocusSequence = false;
          if (locusDetailsData!.isNotEmpty) {}
          if (locusSequence!.isNotEmpty) {
            locusSequenceFormatted = formatLocusSequence(locusSequence.join());
          }
        }
      });
      return const KtList.empty();
    } on Exception {
      throw Error();
    }
  }

  Locus _getLocusData(List<String> locusData) => Locus(
        name: locusData[1],
        length: int.tryParse(locusData[2].toString())!,
        type: locusData[5],
        shape: locusData[6],
        taxonomicDivision: locusData[7],
        releaseDate: locusData[8],
      );

  // ignore: long-method
  LocusDetails getLocusDetails(List<String> locusDetailsGenbank) {
    final referencesData = <Reference>[];
    String? currentLabel;
    String? lastLabel;
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

    locusDetailsGenbank.forEach((locusDetail) {
      final regexLabelAndValue = RegExp(r'^\s*([A-Z]+)\s+(.+)$');
      final matchLabelAndValue = regexLabelAndValue.allMatches(locusDetail);
      String value;
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
}
