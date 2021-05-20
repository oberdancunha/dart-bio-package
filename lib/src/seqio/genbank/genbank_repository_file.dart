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

  LocusDetails getLocusDetails(List<String> locusDetailsGenbank) {
    String? currentDetail;
    String? lastDetail;
    final definitionDescription = <String>[];
    String? accessionDescription;
    int? versionDescription;
    final keywordsDescription = <String>[];
    final sourceDescription = <String>[];
    final organismDescription = <String>[];
    final referenceDescription = <String>[];
    final authorDescription = <String>[];
    final titleDescription = <String>[];
    final journalDescription = <String>[];
    final pubmedDescription = <String>[];
    final referencesData = <Reference>[];

    locusDetailsGenbank.forEach(
      (locusDetail) {
        locusDetail = locusDetail.replaceFirst(RegExp(r'^\s{2,3}'), "");
        const regex = r'^([A-Z]+)\s+(.+)$';
        final regexp = RegExp(regex);
        final match = regexp.allMatches(locusDetail);
        String locusDetailData;
        if (match.isNotEmpty) {
          currentDetail = match.elementAt(0).group(1);
          lastDetail = currentDetail;
          locusDetailData = match.elementAt(0).group(2)!;
        } else {
          currentDetail = lastDetail;
          locusDetailData = locusDetail.replaceAll(RegExp(r'^\s+'), "");
        }
        switch (currentDetail) {
          case 'DEFINITION':
            {
              definitionDescription.add(locusDetailData);
            }
            break;
          case 'ACCESSION':
            {
              accessionDescription = locusDetailData;
            }
            break;
          case 'VERSION':
            {
              final originalVersion = locusDetailData;
              final versionOnlyNumberString = originalVersion.split('.')[1];
              versionDescription = int.tryParse(versionOnlyNumberString);
            }
            break;
          case 'KEYWORDS':
            {
              keywordsDescription.add(locusDetailData);
            }
            break;
          case 'SOURCE':
            {
              sourceDescription.add(locusDetailData);
            }
            break;
          case 'ORGANISM':
            {
              organismDescription.add(locusDetailData);
            }
            break;
          case 'REFERENCE':
            {
              if (referenceDescription.isNotEmpty) {
                final referenceData = _getReferenceData(
                  referenceDescription: referenceDescription,
                  authorDescription: authorDescription,
                  titleDescription: titleDescription,
                  journalDescription: journalDescription,
                  pubmedDescription: pubmedDescription,
                );
                referencesData.add(referenceData);
                referenceDescription.clear();
                authorDescription.clear();
                titleDescription.clear();
                journalDescription.clear();
                pubmedDescription.clear();
              }
              referenceDescription.add(locusDetailData);
            }
            break;
          case 'AUTHORS':
            {
              authorDescription.add(locusDetailData);
            }
            break;
          case 'TITLE':
            {
              titleDescription.add(locusDetailData);
            }
            break;
          case 'JOURNAL':
            {
              journalDescription.add(locusDetailData);
            }
            break;
          case 'PUBMED':
            {
              pubmedDescription.add(locusDetailData);
            }
            break;
        }
      },
    );
    if (referenceDescription.isNotEmpty) {
      final referenceData = _getReferenceData(
        referenceDescription: referenceDescription,
        authorDescription: authorDescription,
        titleDescription: titleDescription,
        journalDescription: journalDescription,
        pubmedDescription: pubmedDescription,
      );
      referencesData.add(referenceData);
    }

    final LocusDetails locusDetails = LocusDetails(
      definition: definitionDescription.join(' '),
      accession: accessionDescription,
      version: versionDescription,
      keywords: keywordsDescription.join(' '),
      source: sourceDescription.join(' '),
      organism: organismDescription.join('; ').replaceAll(';;', ';'),
      references: referencesData.toImmutableList(),
    );

    return locusDetails;
  }

  Reference _getReferenceData({
    required List<String>? referenceDescription,
    required List<String>? authorDescription,
    required List<String>? titleDescription,
    required List<String>? journalDescription,
    required List<String>? pubmedDescription,
  }) =>
      Reference(
        description: referenceDescription!.join(' '),
        authors: authorDescription!.join(' '),
        title: titleDescription!.join(' '),
        journal: journalDescription!.join(' '),
        pubmed:
            pubmedDescription!.isNotEmpty ? pubmedDescription.join(' ') : null,
      );

  String formatLocusSequence(String locusSequence) => locusSequence
      .replaceAll(RegExp(r'\s'), '')
      .replaceAll(RegExp('[0-9]'), '')
      .replaceAll(RegExp(r'\n'), '');
}
