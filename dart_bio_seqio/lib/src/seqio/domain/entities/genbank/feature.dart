import 'package:dart_bio_dependency_module/dart_bio_dependency_module.dart';

class Feature extends Equatable {
  final int start;
  final int end;
  final String type;
  final int strand;
  final String? name;
  final String? note;
  final String? nucleotides;
  final String? aminoacids;
  final String? product;
  final KtList<Map<String, dynamic>>? features;

  const Feature({
    required this.start,
    required this.end,
    required this.type,
    required this.strand,
    this.name,
    this.note,
    this.nucleotides,
    this.aminoacids,
    this.product,
    this.features,
  });

  @override
  List<Object?> get props => [
        start,
        end,
        type,
        strand,
        name,
        note,
        nucleotides,
        aminoacids,
        product,
        features,
      ];
}
