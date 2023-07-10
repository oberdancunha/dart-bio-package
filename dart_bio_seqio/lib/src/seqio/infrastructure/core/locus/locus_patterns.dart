import '../source_patterns.dart';

abstract class LocusPatterns extends SourcePatterns {
  String get namePattern;
  String get lengthPattern;
  String get typePattern;
  String get shapePattern;
  String get taxonomicDivision;
  String get releaseDate;
}
