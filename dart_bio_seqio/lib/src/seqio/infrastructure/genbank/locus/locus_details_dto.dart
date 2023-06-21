import '../../../domain/entities/locus_details.dart';

class LocusDetailsDto {
  LocusDetails fromGenbankFile(List<String> locusDetailsGenbank) {
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
      }
    });

    final LocusDetails locusDetails = LocusDetails(
      definition: definitionValue.join(' '),
      accession: accessionValue,
      version: versionValue,
      keywords: keywordsValue.join(' '),
      source: sourceValue.join(' '),
      organism: organismValue.join('; ').replaceAll(';;', ';'),
    );

    return locusDetails;
  }
}
