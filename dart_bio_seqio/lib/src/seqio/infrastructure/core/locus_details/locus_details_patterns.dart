import '../source_patterns.dart';

abstract class LocusDetailsPatterns extends SourcePatterns {
  String get definitionPattern;
  String get accessionPattern;
  String get versionPattern;
  String get keywordsPattern;
  String get sourcePattern;
  String get organismPattern;
}
