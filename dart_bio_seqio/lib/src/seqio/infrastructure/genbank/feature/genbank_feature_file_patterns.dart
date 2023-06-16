import '../../core/source_feature_file_patterns.dart';

class GenbankFeatureFilePatterns implements SourceFeatureFilePatterns {
  @override
  String get locationPattern => r'^\s{5}([\w+]+)\s+(.+)$';

  @override
  String get productPattern => r'^\s{21}\/product\=\"(.+)\"?$';

  @override
  String get notePattern => r'^\s{21}\/note\=\"(.+)\"?$';

  @override
  String get aminoacidSequencePattern => r'^\s{21}\/translation\=\"(.+)\"?$';

  @override
  String get genePattern => r'^\s{21}\/gene\=\"(.+)\"$';

  @override
  String get codonStartPattern => r'^\s{21}\/codon_start\=(\d{1})$';

  @override
  String get recallLastEventPattern => r'^\s{21}((?!\/).+)\"?$';
}
