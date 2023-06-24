import 'package:dart_bio_core/parse_event.dart';

import '../../../domain/entities/feature.dart';
import '../source_event_execute.dart';
import 'feature_patterns.dart';
import 'feature_sequence.dart';
import 'models/feature_aminoacid_sequence_model.dart';
import 'models/feature_another_model.dart';
import 'models/feature_codon_start_model.dart';
import 'models/feature_gene_model.dart';
import 'models/feature_identifier_positions_model.dart';
import 'models/feature_note_model.dart';
import 'models/feature_product_model.dart';

abstract class FeatureEvent extends SourceEventExecute<Feature> {
  @override
  List<ParseEvent> get patternsList => [
        ParseEvent(
          identifierPattern: featurePatterns.locationPattern,
          action: getLocations,
          isRecall: false,
        ),
        ParseEvent(
          identifierPattern: featurePatterns.productPattern,
          action: getProduct,
          isRecall: true,
        ),
        ParseEvent(
          identifierPattern: featurePatterns.notePattern,
          action: getNote,
          isRecall: true,
        ),
        ParseEvent(
          identifierPattern: featurePatterns.aminoacidSequencePattern,
          action: getAminoacidSequence,
          isRecall: true,
        ),
        ParseEvent(
          identifierPattern: featurePatterns.genePattern,
          action: getGene,
          isRecall: false,
        ),
        ParseEvent(
          identifierPattern: featurePatterns.codonStartPattern,
          action: getCodonStart,
          isRecall: false,
        ),
        ParseEvent(
          identifierPattern: featurePatterns.anotherFeaturesPattern,
          action: getAnother,
          isRecall: true,
        ),
        ParseEvent(
          identifierPattern: featurePatterns.recallLastEventPattern,
          isRecall: true,
        ),
      ];

  void getNucleotideSequence(List<String> originalNucleotideSequence) {
    if (originalNucleotideSequence.isNotEmpty) {
      final nucleotideSubSequence = FeatureSequence().getNucleotideSubSequence(
        type: data.type,
        strand: data.strand,
        positions: data.positions,
        codonStart: data.codonStart ?? 1,
        originalNucleotideSequence: originalNucleotideSequence,
      );

      if (nucleotideSubSequence != null) {
        data = data.copyWith(nucleotides: nucleotideSubSequence);
      }
    }

    return;
  }

  bool isNextFeature(String value);
  FeaturePatterns get featurePatterns;
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

  @override
  Feature data = Feature.init();

  @override
  void initData() {
    data = Feature.init();
  }
}
