import 'package:kt_dart/kt.dart';

import '../../domain/entities/genbank/locus_details.dart';
import '../../domain/entities/genbank/reference.dart';

class LocusDetailsDto {
  // ignore: long-method
  LocusDetails fromGenbankFile(List<String> locusDetailsGenbank) {
    final referencesData = <Reference>[];
    final regexLabelAndValue = RegExp(r'^\s*([A-Z]+)\s+(.+)$');
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
}
