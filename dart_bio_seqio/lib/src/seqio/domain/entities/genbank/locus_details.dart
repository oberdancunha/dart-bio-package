import 'package:dart_bio_dependency_module/dart_bio_dependency_module.dart';

import 'reference.dart';

class LocusDetails extends Equatable {
  final String? definition;
  final String? accession;
  final int? version;
  final String? keywords;
  final String? source;
  final String? organism;
  final KtList<Reference>? references;

  const LocusDetails({
    this.definition,
    this.accession,
    this.version,
    this.keywords,
    this.source,
    this.organism,
    this.references,
  });

  @override
  List<Object?> get props => [
        definition,
        accession,
        version,
        keywords,
        source,
        organism,
        references,
      ];
}
