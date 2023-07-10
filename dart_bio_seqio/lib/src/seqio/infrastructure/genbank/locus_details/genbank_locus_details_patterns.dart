import '../../core/locus_details/locus_details_patterns.dart';

class GenbankLocusDetailsPatterns extends LocusDetailsPatterns {
  @override
  String get definitionPattern => r'^DEFINITION\s+(\S.*)(?<!\s)$';

  @override
  String get accessionPattern => r'^ACCESSION\s+(\S.*)(?<!\s)$';

  @override
  String get versionPattern => r'^VERSION\s+(\S.*)(?<!\s)$';

  @override
  String get keywordsPattern => r'^KEYWORDS\s+(\S.*)(?<!\s)$';

  @override
  String get sourcePattern => r'^SOURCE\s+(\S.*)(?<!\s)$';

  @override
  String get organismPattern => r'^\s{2}ORGANISM\s+(\S.*)(?<!\s)$';

  @override
  String get recallLastEventPattern => r'^\s{12}(\S.*)(?<!\s)$';
}
