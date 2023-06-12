import 'package:dart_bio_dependency_module/dart_bio_dependency_module.dart';

import 'location_position.dart';

class Feature extends Equatable {
  final List<LocationPosition> positions;
  final String type;
  final int strand;
  final String? name;
  final String? note;
  final String? nucleotides;
  final String? aminoacids;
  final String? product;
  final KtList<Map<String, dynamic>>? features;

  const Feature({
    required this.positions,
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
        positions,
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
