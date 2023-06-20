// ignore_for_file: avoid_dynamic_calls
import 'package:dart_bio_core/parse_event.dart';
import 'package:dart_bio_dependency_module/dart_bio_dependency_module.dart';

import '../../domain/entities/genbank/feature.dart';
import '../../domain/entities/genbank/location_position.dart';
import 'models/feature_aminoacid_sequence_model.dart';
import 'models/feature_another_model.dart';
import 'models/feature_codon_start_model.dart';
import 'models/feature_gene_model.dart';
import 'models/feature_identifier_positions_model.dart';
import 'models/feature_note_model.dart';
import 'models/feature_nucleotide_sequence_model.dart';
import 'models/feature_product_model.dart';
import 'source_feature_file_patterns.dart';

abstract class SourceFeatureFileExecute {
  Function? _lastEvent;
  Feature _feature = Feature.init();

  List<ParseEvent> get patternsList => [
        ParseEvent(
          identifierPattern: sourceFeatureFilePatterns.locationPattern,
          action: getLocations,
          isRecall: false,
        ),
        ParseEvent(
          identifierPattern: sourceFeatureFilePatterns.productPattern,
          action: getProduct,
          isRecall: true,
        ),
        ParseEvent(
          identifierPattern: sourceFeatureFilePatterns.notePattern,
          action: getNote,
          isRecall: true,
        ),
        ParseEvent(
          identifierPattern: sourceFeatureFilePatterns.aminoacidSequencePattern,
          action: getAminoacidSequence,
          isRecall: true,
        ),
        ParseEvent(
          identifierPattern: sourceFeatureFilePatterns.genePattern,
          action: getGene,
          isRecall: false,
        ),
        ParseEvent(
          identifierPattern: sourceFeatureFilePatterns.codonStartPattern,
          action: getCodonStart,
          isRecall: false,
        ),
        ParseEvent(
          identifierPattern: sourceFeatureFilePatterns.anotherFeaturesPattern,
          action: getAnother,
          isRecall: true,
        ),
        ParseEvent(
          identifierPattern: sourceFeatureFilePatterns.recallLastEventPattern,
          isRecall: true,
        ),
      ];

  void callActionByPattern(String value) {
    patternsList.forEach((pattern) {
      final regexPattern = RegExp(pattern.identifierPattern);
      if (regexPattern.hasMatch(value)) {
        final action = pattern.action ?? _lastEvent;
        if (action != null) {
          orchestrateParseEventsToRun(
            value,
            () => action.call(
              value,
              pattern.identifierPattern,
            ),
          );
          _lastEvent = pattern.isRecall ? action : null;
        }

        return;
      }
    });

    return;
  }

  void orchestrateParseEventsToRun(String value, Function callAction) {
    final featureData = callAction();
    switch (featureData.runtimeType) {
      case FeatureIdentifierPositionsModel:
        {
          _feature = _feature.copyWith(
            type: (featureData as FeatureIdentifierPositionsModel).identifier,
            positions: featureData.featurePositions.positions,
            strand: featureData.featurePositions.strand,
          );
        }
        break;
      case FeatureProductModel:
        {
          final product = (featureData as FeatureProductModel).product;
          _feature = _feature.copyWith(
            product: _feature.product != null ? "${_feature.product} $product" : product,
          );
        }
        break;
      case FeatureNoteModel:
        {
          final note = (featureData as FeatureNoteModel).note;
          _feature = _feature.copyWith(
            note: _feature.note != null ? "${_feature.note} $note" : note,
          );
        }
        break;
      case FeatureAminoacidSequenceModel:
        {
          final aminoacidSequence =
              (featureData as FeatureAminoacidSequenceModel).aminoacidSequence;
          _feature = _feature.copyWith(
            aminoacids: _feature.aminoacids != null
                ? "${_feature.aminoacids}$aminoacidSequence"
                : aminoacidSequence,
          );
        }
        break;
      case FeatureGeneModel:
        {
          final gene = (featureData as FeatureGeneModel).gene;
          _feature = _feature.copyWith(
            name: gene,
          );
        }
        break;
      case FeatureCodonStartModel:
        {
          final codonStart = (featureData as FeatureCodonStartModel).codonStart;
          _feature = _feature.copyWith(
            codonStart: codonStart,
          );
        }
        break;
      case FeatureAnotherModel:
        {
          final featureAnother = (featureData as FeatureAnotherModel).another;
          final featuresAlreadyAdded = _feature.features != null
              ? _feature.features!.toMutableList().asList()
              : <Map<String, dynamic>>[];
          final isContinuationPreviousFeature =
              featureAnother.keys.first == 'continuation_previous_feature';
          if (isContinuationPreviousFeature) {
            final lastFeatureAddedKey = featuresAlreadyAdded.last.keys.elementAt(0);
            featuresAlreadyAdded.last[lastFeatureAddedKey] += ' ${featureAnother.values.first}';
          } else {
            featuresAlreadyAdded.add(featureAnother);
          }
          _feature = _feature.copyWith(
            features: featuresAlreadyAdded.toImmutableList(),
          );
        }
        break;
    }

    return;
  }

  void parseNucleotide(List<String> locusSequence) {
    if (locusSequence.isNotEmpty) {
      final featureNucleotideSequence = getNucleotideSequence(
        type: _feature.type,
        strand: _feature.strand,
        positions: _feature.positions,
        codonStart: _feature.codonStart ?? 1,
        originalNucleotideSequence: locusSequence,
      );
      _feature = _feature.copyWith(
        nucleotides: featureNucleotideSequence.nucleotideSequence,
      );
    }
  }

  Feature get featureData => _feature;

  bool _isFinishFeature(value) => value == "";

  void initFeature() {
    _feature = Feature.init();
  }

  bool isNextFeature(String value);
  SourceFeatureFilePatterns get sourceFeatureFilePatterns;
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
  FeatureNucleotideSequenceModel getNucleotideSequence({
    required String type,
    required int strand,
    required List<LocationPosition> positions,
    required int codonStart,
    required List<String> originalNucleotideSequence,
  });
}
