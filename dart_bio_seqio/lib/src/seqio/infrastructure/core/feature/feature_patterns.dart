import '../source_patterns.dart';

abstract class FeaturePatterns extends SourcePatterns {
  String get locationPattern;
  String get productPattern;
  String get notePattern;
  String get aminoacidSequencePattern;
  String get genePattern;
  String get codonStartPattern;
  String get anotherFeaturesPattern;
}
