// ignore_for_file: avoid_dynamic_calls
import 'package:dart_bio_core/parse_event.dart';

import '../../domain/entities/genbank/feature.dart';
import 'models/feature_aminoacid_sequence_model.dart';
import 'models/feature_gene_model.dart';
import 'models/feature_identifier_positions_model.dart';
import 'models/feature_note_model.dart';
import 'models/feature_product_model.dart';
import 'source_feature_file_patterns.dart';

abstract class SourceFeatureFileExecute {
  var _parseEvents = <Function>[];
  Function? _lastEvent;

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
          identifierPattern: sourceFeatureFilePatterns.recallLastEventPattern,
          isRecall: true,
        ),
      ];

  void callActionByPattern(String value) {
    final eventsLength = _parseEvents.length;
    patternsList.forEach((pattern) {
      final regexPattern = RegExp(pattern.identifierPattern);
      if (regexPattern.hasMatch(value)) {
        final action = pattern.action ?? _lastEvent;
        if (action != null) {
          _parseEvents.add(
            () => action.call(value, pattern.identifierPattern),
          );
          _lastEvent = pattern.isRecall ? action : null;
        }

        return;
      }
    });
    if (_noEventAdded(eventsLength)) {
      _lastEvent = null;
    }
  }

  Feature? orchestrateParseEventsToRun(String value) {
    if ((isNextFeature(value) || _isFinishFeature(value)) && _parseEvents.isNotEmpty) {
      late Feature feature;
      _parseEvents.forEach((event) {
        final featureData = event.call();
        switch (featureData.runtimeType) {
          case FeatureIdentifierPositionsModel:
            {
              feature = Feature(
                type: (featureData as FeatureIdentifierPositionsModel).identifier,
                positions: featureData.featurePositions.positions,
                strand: featureData.featurePositions.strand,
              );
            }
            break;
          case FeatureProductModel:
            {
              final product = (featureData as FeatureProductModel).product;
              feature = feature.copyWith(
                product: feature.product != null ? "${feature.product} $product" : product,
              );
            }
            break;
          case FeatureNoteModel:
            {
              final note = (featureData as FeatureNoteModel).note;
              feature = feature.copyWith(
                note: feature.note != null ? "${feature.note} $note" : note,
              );
            }
            break;
          case FeatureAminoacidSequenceModel:
            {
              final aminoacidSequence =
                  (featureData as FeatureAminoacidSequenceModel).aminoacidSequence;
              feature = feature.copyWith(
                aminoacids: feature.aminoacids != null
                    ? "${feature.aminoacids}$aminoacidSequence"
                    : aminoacidSequence,
              );
            }
            break;
          case FeatureGeneModel:
            {
              final gene = (featureData as FeatureGeneModel).gene;
              feature = feature.copyWith(
                name: gene,
              );
            }
            break;
        }
      });
      _restartEvents();

      return feature;
    }

    return null;
  }

  bool _isFinishFeature(value) => value == "";

  bool _noEventAdded(int eventsLength) => eventsLength == _parseEvents.length;

  void _restartEvents() {
    _parseEvents = <Function>[];
    _lastEvent = null;
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
}
