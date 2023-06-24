import '../../../../domain/entities/locus.dart';
import '../../data_model.dart';

class LocusTaxonomicDivisionModel implements DataModel<Locus> {
  final String taxonomicDivision;

  LocusTaxonomicDivisionModel({
    required this.taxonomicDivision,
  });

  @override
  Locus toDomain(Locus locus) => locus.copyWith(
        taxonomicDivision: taxonomicDivision,
      );
}
