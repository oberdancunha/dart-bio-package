import '../../core/feature/feature_patterns.dart';

class GenbankFeaturePatterns extends FeaturePatterns {
  @override
  String get locationPattern => r'^\s{5}([\w+]+)\s+(\S.*)(?<!\s)$';

  @override
  String get productPattern => r'^\s{21}\/product\=\"(\S.*)(?<!\s)\"?$';

  @override
  String get notePattern => r'^\s{21}\/note\=\"(\S.*)(?<!\s)\"?$';

  @override
  String get aminoacidSequencePattern => r'^\s{21}\/translation\=\"(\S.*)(?<!\s)\"?$';

  @override
  String get genePattern => r'^\s{21}\/gene\=\"(\S.*)(?<!\s)\"$';

  @override
  String get codonStartPattern => r'^\s{21}\/codon_start\=(\d{1})$';

  @override
  String get anotherFeaturesPattern =>
      r'^\s{21}\/((?!product)(?!note)(?!translation)(?!gene)(?!codon_start).+)\=(\S.*)(?<!\s)$';

  @override
  String get recallLastEventPattern => r'^\s{21}((?!\/).+)\"?$';
}
