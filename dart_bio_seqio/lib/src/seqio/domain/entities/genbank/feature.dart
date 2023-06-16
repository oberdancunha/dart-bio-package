// ignore_for_file: public_member_api_docs, sort_constructors_first
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
  final int? codonStart;
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
    this.codonStart,
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
        codonStart,
        features,
      ];

  Feature copyWith({
    List<LocationPosition>? positions,
    String? type,
    int? strand,
    String? name,
    String? note,
    String? nucleotides,
    String? aminoacids,
    String? product,
    int? codonStart,
    KtList<Map<String, dynamic>>? features,
  }) =>
      Feature(
        positions: positions ?? this.positions,
        type: type ?? this.type,
        strand: strand ?? this.strand,
        name: name ?? this.name,
        note: note ?? this.note,
        nucleotides: nucleotides ?? this.nucleotides,
        aminoacids: aminoacids ?? this.aminoacids,
        product: product ?? this.product,
        codonStart: codonStart ?? this.codonStart,
        features: features ?? this.features,
      );
}
