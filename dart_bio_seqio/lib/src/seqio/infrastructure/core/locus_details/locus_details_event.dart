import 'package:dart_bio_core/parse_event.dart';

import '../../../domain/entities/locus_details.dart';
import '../source_event_execute.dart';
import 'locus_details_patterns.dart';
import 'models/locus_details_accession_model.dart';
import 'models/locus_details_definition_model.dart';
import 'models/locus_details_keywords_model.dart';
import 'models/locus_details_organism_model.dart';
import 'models/locus_details_source_model.dart';
import 'models/locus_details_version_model.dart';

abstract class LocusDetailsEvent extends SourceEventExecute<LocusDetails> {
  @override
  List<ParseEvent> get patternsList => [
        ParseEvent(
          identifierPattern: locusDetailsPatterns.definitionPattern,
          action: getDefinition,
          isRecall: true,
        ),
        ParseEvent(
          identifierPattern: locusDetailsPatterns.accessionPattern,
          action: getAccession,
          isRecall: false,
        ),
        ParseEvent(
          identifierPattern: locusDetailsPatterns.versionPattern,
          action: getVersion,
          isRecall: false,
        ),
        ParseEvent(
          identifierPattern: locusDetailsPatterns.keywordsPattern,
          action: getKeywords,
          isRecall: false,
        ),
        ParseEvent(
          identifierPattern: locusDetailsPatterns.sourcePattern,
          action: getSource,
          isRecall: true,
        ),
        ParseEvent(
          identifierPattern: locusDetailsPatterns.organismPattern,
          action: getOrganism,
          isRecall: true,
        ),
        ParseEvent(
          identifierPattern: locusDetailsPatterns.recallLastEventPattern,
          isRecall: true,
        ),
      ];

  LocusDetailsPatterns get locusDetailsPatterns;
  LocusDetailsDefinitionModel getDefinition(
    String locusDetailsDefinition,
    String locusDetailsDefinitionPattern,
  );
  LocusDetailsAccessionModel getAccession(
    String locusDetailsAccession,
    String locusDetailsAccessionPattern,
  );
  LocusDetailsVersionModel getVersion(
    String locusDetailsVersion,
    String locusDetailsVersionPattern,
  );
  LocusDetailsKeywordsModel getKeywords(
    String locusDetailsKeywords,
    String locusDetailsKeywordsPattern,
  );
  LocusDetailsSourceModel getSource(String locusDetailsSource, String locusDetailsSourcePattern);
  LocusDetailsOrganismModel getOrganism(
    String locusDetailsOrganism,
    String locusDetailsOrganismPattern,
  );

  @override
  LocusDetails data = LocusDetails.init();

  @override
  void initData() {
    data = LocusDetails.init();
  }
}
