import '../source_file_patterns.dart';

abstract class FeatureFilePatterns extends SourceFilePatterns {
  String get locationPattern;
  String get productPattern;
  String get notePattern;
  String get aminoacidSequencePattern;
  String get genePattern;
  String get codonStartPattern;
  String get anotherFeaturesPattern;
}
