import 'package:dart_bio_dependency_module/dart_bio_dependency_module.dart';

class Locus extends Equatable {
  final String name;
  final int length;
  final String? type;
  final String? shape;
  final String? taxonomicDivision;
  final String? releaseDate;
  final String? sequence;

  const Locus({
    required this.name,
    required this.length,
    this.type,
    this.shape,
    this.taxonomicDivision,
    this.releaseDate,
    this.sequence,
  });

  @override
  List<Object?> get props => [
        name,
        length,
        type,
        shape,
        taxonomicDivision,
        releaseDate,
        sequence,
      ];

  factory Locus.init() => const Locus(
        name: "",
        length: 0,
        type: "",
        shape: "",
        taxonomicDivision: "",
        releaseDate: "",
      );

  Locus copyWith({
    String? name,
    int? length,
    String? type,
    String? shape,
    String? taxonomicDivision,
    String? releaseDate,
    String? sequence,
  }) =>
      Locus(
        name: name ?? this.name,
        length: length ?? this.length,
        type: type ?? this.type,
        shape: shape ?? this.shape,
        taxonomicDivision: taxonomicDivision ?? this.taxonomicDivision,
        releaseDate: releaseDate ?? this.releaseDate,
        sequence: sequence ?? this.sequence,
      );
}
