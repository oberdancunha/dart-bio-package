import '../../core/models/feature_aminoacid_sequence_model.dart';
import '../../core/models/feature_identifier_positions_model.dart';
import '../../core/models/feature_note_model.dart';
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
  FeatureNoteModel getNote(String featureNote, String notePattern) {
    final note = GenbankGenericFeature().getData(featureNote, notePattern);

    return FeatureNoteModel(note: note);
  }

  @override
  FeatureAminoacidSequenceModel getAminoacidSequence(
    String featureAminoacidSequence,
    String aminoacidSequencePattern,
  ) {
    final aminoacidSequence = GenbankGenericFeature().getData(
      featureAminoacidSequence,
      aminoacidSequencePattern,
    );

    return FeatureAminoacidSequenceModel(aminoacidSequence: aminoacidSequence);
  }

  @override
  bool isNextFeature(String value) {
    final locationPattern = sourceFeatureFilePatterns.locationPattern;
    final locationMatch = RegExp(locationPattern);

    return locationMatch.hasMatch(value);
  }
}
