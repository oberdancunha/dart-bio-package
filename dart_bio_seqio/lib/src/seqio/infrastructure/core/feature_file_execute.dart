// ignore_for_file: avoid_dynamic_calls
import 'package:dart_bio_core/parse_event.dart';

import '../../domain/entities/genbank/feature.dart';
import '../../domain/entities/genbank/location_position.dart';
import 'feature_file_patterns.dart';
import 'feature_sequence.dart';
import 'models/feature_aminoacid_sequence_model.dart';
import 'models/feature_another_model.dart';
import 'models/feature_codon_start_model.dart';
import 'models/feature_gene_model.dart';
import 'models/feature_identifier_positions_model.dart';
import 'models/feature_model.dart';
import 'models/feature_note_model.dart';
import 'models/feature_nucleotide_sequence_model.dart';
import 'models/feature_product_model.dart';

abstract class FeatureFileExecute {
  Function? _lastEvent;
  Feature _feature = Feature.init();

  List<ParseEvent> get patternsList => [
        ParseEvent(
          identifierPattern: featureFilePatterns.locationPattern,
          action: getLocations,
          isRecall: false,
        ),
        ParseEvent(
          identifierPattern: featureFilePatterns.productPattern,
          action: getProduct,
          isRecall: true,
        ),
        ParseEvent(
          identifierPattern: featureFilePatterns.notePattern,
          action: getNote,
          isRecall: true,
        ),
        ParseEvent(
          identifierPattern: featureFilePatterns.aminoacidSequencePattern,
          action: getAminoacidSequence,
          isRecall: true,
        ),
        ParseEvent(
          identifierPattern: featureFilePatterns.genePattern,
          action: getGene,
          isRecall: false,
        ),
        ParseEvent(
          identifierPattern: featureFilePatterns.codonStartPattern,
          action: getCodonStart,
          isRecall: false,
        ),
        ParseEvent(
          identifierPattern: featureFilePatterns.anotherFeaturesPattern,
          action: getAnother,
          isRecall: true,
        ),
        ParseEvent(
          identifierPattern: featureFilePatterns.recallLastEventPattern,
          isRecall: true,
        ),
      ];

  void identifyActionByPattern({
    required String currentFeature,
    required bool isNextFeature,
    required bool isFinishFeature,
    required List<String> locusSequence,
  }) {
    patternsList.forEach((pattern) {
      final regexPattern = RegExp(pattern.identifierPattern);
      if (regexPattern.hasMatch(currentFeature)) {
        final action = pattern.action ?? _lastEvent;
        if (action != null) {
          runParseAction(
            () => action.call(
              currentFeature,
              pattern.identifierPattern,
            ),
          );
          _lastEvent = pattern.isRecall ? action : null;
        }

        return;
      }
    });
    if (isNextFeature || isFinishFeature) {
      if (locusSequence.isNotEmpty) {
        runParseAction(
          () => getNucleotideSequence(
            type: _feature.type,
            strand: _feature.strand,
            positions: _feature.positions,
            codonStart: _feature.codonStart ?? 1,
            originalNucleotideSequence: locusSequence,
          ),
        );
      }
    }

    return;
  }

  void runParseAction(Function callAction) {
    final featureData = callAction() as FeatureModel;
    _feature = featureData.toDomain(_feature);

    return;
  }

  Feature get featureData => _feature;

  void initFeature() {
    _feature = Feature.init();
  }

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

  bool isNextFeature(String value);
  FeatureFilePatterns get featureFilePatterns;
  FeatureIdentifierPositionsModel getLocations(
    String featureLocation,
    String featureLocationPattern,
  );
  FeatureProductModel getProduct(String featureProduct, String featureProductPattern);
  FeatureNoteModel getNote(String featureNote, String featureNotePattern);
  FeatureAminoacidSequenceModel getAminoacidSequence(
    String featureAminoacidSequence,
    String featureAminoacidSequencePattern,
  );
  FeatureGeneModel getGene(String featureGene, String featureGenePattern);
  FeatureCodonStartModel getCodonStart(String featureCodonStart, String featureCodonStartPattern);
  FeatureAnotherModel getAnother(String featureAnother, String featuresAnotherPattern);
}
