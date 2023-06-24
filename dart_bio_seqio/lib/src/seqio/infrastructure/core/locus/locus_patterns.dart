import '../source_file_patterns.dart';

abstract class LocusPatterns extends SourceFilePatterns {
  String get namePattern;
  String get lengthPattern;
  String get typePattern;
  String get shapePattern;
  String get taxonomicDivision;
  String get releaseDate;
}
