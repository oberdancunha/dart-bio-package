// ignore_for_file: public_member_api_docs, sort_constructors_first
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

  factory LocusDetails.init() => const LocusDetails(
        definition: "",
        accession: "",
        version: 0,
        keywords: "",
        source: "",
        organism: "",
      );

  LocusDetails copyWith({
    String? definition,
    String? accession,
    int? version,
    String? keywords,
    String? source,
    String? organism,
  }) =>
      LocusDetails(
        definition: definition ?? this.definition,
        accession: accession ?? this.accession,
        version: version ?? this.version,
        keywords: keywords ?? this.keywords,
        source: source ?? this.source,
        organism: organism ?? this.organism,
      );
}
