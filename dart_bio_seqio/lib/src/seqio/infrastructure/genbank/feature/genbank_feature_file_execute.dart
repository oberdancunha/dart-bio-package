// ignore_for_file: avoid_catching_errors

import 'package:dart_bio_core/exceptions.dart';

import '../../../domain/entities/genbank/location_position.dart';
import '../../core/feature_sequence.dart';
import '../../core/models/feature_aminoacid_sequence_model.dart';
import '../../core/models/feature_another_model.dart';
import '../../core/models/feature_codon_start_model.dart';
import '../../core/models/feature_gene_model.dart';
import '../../core/models/feature_identifier_positions_model.dart';
import '../../core/models/feature_note_model.dart';
import '../../core/models/feature_nucleotide_sequence_model.dart';
import '../../core/models/feature_product_model.dart';
import '../../core/source_feature_file_execute.dart';
import 'genbank_feature_file_patterns.dart';
import 'genbank_feature_location.dart';
import 'genbank_generic_feature.dart';

class GenbankFeatureFileExecute extends SourceFeatureFileExecute {
  @override
  GenbankFeatureFilePatterns get sourceFeatureFilePatterns => GenbankFeatureFilePatterns();

  @override
  FeatureIdentifierPositionsModel getLocations(
    String featureLocation,
    String featureLocationPattern,
  ) =>
      GenbankFeatureLocation().pipelineLocation(featureLocation, featureLocationPattern);

  @override
  FeatureProductModel getProduct(String featureProduct, String featureProductPattern) {
    final product = GenbankGenericFeature().getData(featureProduct, featureProductPattern);

    return FeatureProductModel(product: product);
  }

  @override
  FeatureNoteModel getNote(String featureNote, String featureNotePattern) {
    final note = GenbankGenericFeature().getData(featureNote, featureNotePattern);

    return FeatureNoteModel(note: note);
  }

  @override
  FeatureAminoacidSequenceModel getAminoacidSequence(
    String featureAminoacidSequence,
    String featureAminoacidSequencePattern,
  ) {
    final aminoacidSequence = GenbankGenericFeature().getData(
      featureAminoacidSequence,
      featureAminoacidSequencePattern,
    );

    return FeatureAminoacidSequenceModel(aminoacidSequence: aminoacidSequence);
  }

  @override
  FeatureGeneModel getGene(String featureGene, String featureGenePattern) {
    final gene = GenbankGenericFeature().getData(featureGene, featureGenePattern);

    return FeatureGeneModel(gene: gene);
  }

  @override
  FeatureCodonStartModel getCodonStart(String featureCodonStart, String featureCodonStartPattern) {
    final codonStart = GenbankGenericFeature().getData(featureCodonStart, featureCodonStartPattern);

    return FeatureCodonStartModel(codonStart: int.parse(codonStart));
  }

  @override
  FeatureAnotherModel getAnother(String featureAnother, String featuresAnotherPattern) {
    final genbankGenericFeature = GenbankGenericFeature();
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
  FeatureNucleotideSequenceModel getNucleotideSequence({
    required String type,
    required int strand,
    required List<LocationPosition> positions,
    required int codonStart,
    required List<String> originalNucleotideSequence,
  }) {
    final nucleotideSubSequence = FeatureSequence().getNucleotideSubSequence(
      type: type,
      strand: strand,
      positions: positions,
      codonStart: codonStart,
      originalNucleotideSequence: originalNucleotideSequence,
    );

    return FeatureNucleotideSequenceModel(nucleotideSequence: nucleotideSubSequence);
  }

  @override
  bool isNextFeature(String value) {
    final locationPattern = sourceFeatureFilePatterns.locationPattern;
    final locationMatch = RegExp(locationPattern);

    return locationMatch.hasMatch(value) && featureData.positions.elementAt(0).start > 0;
  }
}
