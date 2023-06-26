import '../../core/locus_details/locus_details_event.dart';
import '../../core/locus_details/locus_details_patterns.dart';
import '../../core/locus_details/models/locus_details_accession_model.dart';
import '../../core/locus_details/models/locus_details_definition_model.dart';
import '../../core/locus_details/models/locus_details_keywords_model.dart';
import '../../core/locus_details/models/locus_details_organism_model.dart';
import '../../core/locus_details/models/locus_details_source_model.dart';
import '../../core/locus_details/models/locus_details_version_model.dart';
import '../../core/pattern_data.dart';
import 'genbank_locus_details_patterns.dart';

class GenbankLocusDetailsEvent extends LocusDetailsEvent {
  @override
  LocusDetailsPatterns get locusDetailsPatterns => GenbankLocusDetailsPatterns();

  @override
  LocusDetailsDefinitionModel getDefinition(
    String locusDetailsDefinition,
    String locusDetailsDefinitionPattern,
  ) {
    final definition = PatternData().getData(locusDetailsDefinition, locusDetailsDefinitionPattern);

    return LocusDetailsDefinitionModel(definition: definition);
  }

  @override
  LocusDetailsAccessionModel getAccession(
    String locusDetailsAccession,
    String locusDetailsAccessionPattern,
  ) {
    final accession = PatternData().getData(
      locusDetailsAccession,
      locusDetailsAccessionPattern,
    );

    return LocusDetailsAccessionModel(accession: accession);
  }

  @override
  LocusDetailsVersionModel getVersion(
    String locusDetailsVersion,
    String locusDetailsVersionPattern,
  ) {
    final version = PatternData().getData(locusDetailsVersion, locusDetailsVersionPattern);

    return LocusDetailsVersionModel(version: version);
  }

  @override
  LocusDetailsKeywordsModel getKeywords(
    String locusDetailsKeywords,
    String locusDetailsKeywordsPattern,
  ) {
    final keywords = PatternData().getData(locusDetailsKeywords, locusDetailsKeywordsPattern);

    return LocusDetailsKeywordsModel(keywords: keywords);
  }

  @override
  LocusDetailsSourceModel getSource(String locusDetailsSource, String locusDetailsSourcePattern) {
    final source = PatternData().getData(locusDetailsSource, locusDetailsSourcePattern);

    return LocusDetailsSourceModel(source: source);
  }

  @override
  LocusDetailsOrganismModel getOrganism(
    String locusDetailsOrganism,
    String locusDetailsOrganismPattern,
  ) {
    final organism = PatternData().getData(locusDetailsOrganism, locusDetailsOrganismPattern);

    return LocusDetailsOrganismModel(organism: organism);
  }
}
