import 'package:dart_bio_dependency_module/dart_bio_dependency_module.dart';

class LocusDetails extends Equatable {
  final String? definition;
  final String? accession;
  final int? version;
  final String? keywords;
  final String? source;
  final String? organism;

  const LocusDetails({
    this.definition,
    this.accession,
    this.version,
    this.keywords,
    this.source,
    this.organism,
  });

  @override
  List<Object?> get props => [
        definition,
        accession,
        version,
        keywords,
        source,
        organism,
      ];
}
