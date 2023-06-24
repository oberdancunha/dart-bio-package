// ignore_for_file: avoid_catching_errors
import 'package:dart_bio_core/exceptions.dart';

import '../../core/feature/feature_file_event.dart';
import '../../core/feature/models/feature_aminoacid_sequence_model.dart';
import '../../core/feature/models/feature_another_model.dart';
import '../../core/feature/models/feature_codon_start_model.dart';
import '../../core/feature/models/feature_gene_model.dart';
import '../../core/feature/models/feature_identifier_positions_model.dart';
import '../../core/feature/models/feature_note_model.dart';
import '../../core/feature/models/feature_product_model.dart';
import '../../core/pattern_data.dart';
import 'genbank_feature_file_patterns.dart';
import 'genbank_feature_location.dart';

class GenbankFeatureFileEvent extends FeatureFileEvent {
  @override
  GenbankFeatureFilePatterns get featureFilePatterns => GenbankFeatureFilePatterns();

  @override
  FeatureIdentifierPositionsModel getLocations(
    String featureLocation,
    String featureLocationPattern,
  ) =>
      GenbankFeatureLocation().pipelineLocation(featureLocation, featureLocationPattern);

  @override
  FeatureProductModel getProduct(String featureProduct, String featureProductPattern) {
    final product = PatternData().getData(featureProduct, featureProductPattern);

    return FeatureProductModel(product: product);
  }

  @override
  FeatureNoteModel getNote(String featureNote, String featureNotePattern) {
    final note = PatternData().getData(featureNote, featureNotePattern);

    return FeatureNoteModel(note: note);
  }

  @override
  FeatureAminoacidSequenceModel getAminoacidSequence(
    String featureAminoacidSequence,
    String featureAminoacidSequencePattern,
  ) {
    final aminoacidSequence = PatternData().getData(
      featureAminoacidSequence,
      featureAminoacidSequencePattern,
    );

    return FeatureAminoacidSequenceModel(aminoacidSequence: aminoacidSequence);
  }

  @override
  FeatureGeneModel getGene(String featureGene, String featureGenePattern) {
    final gene = PatternData().getData(featureGene, featureGenePattern);

    return FeatureGeneModel(gene: gene);
  }

  @override
  FeatureCodonStartModel getCodonStart(String featureCodonStart, String featureCodonStartPattern) {
    final codonStart = PatternData().getData(featureCodonStart, featureCodonStartPattern);

    return FeatureCodonStartModel(codonStart: int.parse(codonStart));
  }

  @override
  FeatureAnotherModel getAnother(String featureAnother, String featuresAnotherPattern) {
    final genbankGenericFeature = PatternData();
    try {
      final another = genbankGenericFeature.getMapAnotherData(
        featureAnother,
        featuresAnotherPattern,
      );

      return FeatureAnotherModel(another: another);
    } on FileDataFormatException catch (_) {
      final data = genbankGenericFeature.getData(
        featureAnother,
        featuresAnotherPattern,
      );

      return FeatureAnotherModel(another: {'continuation_previous_feature': data});
    }
  }

  @override
  bool isNextFeature(String value) {
    final locationPattern = featureFilePatterns.locationPattern;
    final locationMatch = RegExp(locationPattern);

    return locationMatch.hasMatch(value) && data.positions.elementAt(0).start > 0;
  }
}
