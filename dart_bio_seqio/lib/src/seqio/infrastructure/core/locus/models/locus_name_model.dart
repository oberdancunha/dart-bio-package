import '../../../../domain/entities/locus.dart';
import '../../data_model.dart';

class LocusNameModel implements DataModel<Locus> {
  final String name;

  LocusNameModel({
    required this.name,
  });

  @override
  Locus toDomain(Locus locus) => locus.copyWith(
        name: name,
      );
}
