import 'package:dart_bio_dependency_module/dart_bio_dependency_module.dart';

class Locus extends Equatable {
  final String name;
  final int length;
  final String type;
  final String shape;
  final String taxonomicDivision;
  final String releaseDate;
  final String? sequence;

  const Locus({
    required this.name,
    required this.length,
    required this.type,
    required this.shape,
    required this.taxonomicDivision,
    required this.releaseDate,
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
}
