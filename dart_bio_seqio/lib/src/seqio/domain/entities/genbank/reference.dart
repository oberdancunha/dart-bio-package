import 'package:dart_bio_dependency_module/dart_bio_dependency_module.dart';

class Reference extends Equatable {
  final String description;
  final String authors;
  final String title;
  final String journal;
  final int? pubmed;

  const Reference({
    required this.description,
    required this.authors,
    required this.title,
    required this.journal,
    this.pubmed,
  });

  @override
  List<Object?> get props => [
        description,
        authors,
        title,
        journal,
        pubmed,
      ];
}
