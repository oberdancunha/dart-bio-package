import '../../core/models/feature_identifier_positions.dart';
import '../../core/models/feature_product_model.dart';
import '../../core/source_feature_file_execute.dart';
import 'genbank_feature_file_patterns.dart';
import 'genbank_feature_location.dart';
import 'genbank_generic_feature.dart';

class GenbankFeatureFileExecute extends SourceFeatureFileExecute {
  @override
  GenbankFeatureFilePatterns get sourceFeatureFilePatterns => GenbankFeatureFilePatterns();

  @override
  FeatureIdentifierPositionsModel getLocations(String featureLocation, String locationPattern) =>
      GenbankFeatureLocation().pipelineLocation(featureLocation, locationPattern);

  @override
  FeatureProductModel getProduct(String featureProduct, String productPattern) {
    final product = GenbankGenericFeature().getData(featureProduct, productPattern);

    return FeatureProductModel(product: product);
  }

  @override
  bool isNextFeature(String value) {
    final locationPattern = sourceFeatureFilePatterns.locationPattern;
    final locationMatch = RegExp(locationPattern);

    return locationMatch.hasMatch(value);
  }
}
