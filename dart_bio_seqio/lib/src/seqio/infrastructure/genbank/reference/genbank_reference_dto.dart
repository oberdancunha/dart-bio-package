import '../../../domain/entities/genbank/reference.dart';

class GenbankReferenceDto {
  List<GenbankReference> fromGenbankFile(List<String> genbankReferences) {
    final regexLabelAndValue = RegExp(r'^\s*([A-Z]+)\s+(.+)$');
    String? currentLabel;
    String? lastLabel;
    String value;

    final referencesData = <GenbankReference>[];
    final referenceValue = <String>[];
    final authorValue = <String>[];
    final titleValue = <String>[];
    final journalValue = <String>[];
    int pubmedId = 0;

    genbankReferences.forEach((genbankReference) {
      final matchLabelAndValue = regexLabelAndValue.allMatches(genbankReference);
      if (matchLabelAndValue.isNotEmpty) {
        currentLabel = matchLabelAndValue.elementAt(0).group(1);
        lastLabel = currentLabel;
        value = matchLabelAndValue.elementAt(0).group(2)!;
      } else {
        currentLabel = lastLabel;
        value = genbankReference.replaceAll(RegExp(r'^\s+'), "");
      }
      switch (currentLabel) {
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

    return referencesData;
  }

  GenbankReference _getReferenceData({
    required List<String> referenceValue,
    required List<String> authorValue,
    required List<String> titleValue,
    required List<String> journalValue,
    required int pubmedId,
  }) =>
      GenbankReference(
        description: referenceValue.join(' '),
        authors: authorValue.join(' '),
        title: titleValue.join(' '),
        journal: journalValue.join(' '),
        pubmed: pubmedId > 0 ? pubmedId : null,
      );
}
