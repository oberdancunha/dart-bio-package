import '../../core/models/feature_identifier_positions.dart';
import '../../core/source_feature_file_execute.dart';
import 'genbank_feature_file_patterns.dart';
import 'genbank_feature_location.dart';

class GenbankFeatureFileExecute extends SourceFeatureFileExecute {
  @override
  GenbankFeatureFilePatterns get sourceFeatureFilePatterns => GenbankFeatureFilePatterns();

  @override
  FeatureIdentifierPositions getLocations(String featureLocation) =>
      GenbankFeatureLocation().pipelineLocation(featureLocation);
}
