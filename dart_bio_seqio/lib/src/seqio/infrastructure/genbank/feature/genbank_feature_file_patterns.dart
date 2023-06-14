import '../../core/source_feature_file_patterns.dart';

class GenbankFeatureFilePatterns implements SourceFeatureFilePatterns {
  @override
  String get locationPattern => r'^\s{5}([\w+]+)\s+(.+)$';
}
