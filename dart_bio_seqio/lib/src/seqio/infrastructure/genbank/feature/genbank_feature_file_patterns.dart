import '../../core/source_feature_file_patterns.dart';

class GenbankFeatureFilePatterns implements SourceFeatureFilePatterns {
  @override
  RegExp get locationPatternRegExp => RegExp(r'^\s{5}([\w+]+)\s+(.+)$');
}
