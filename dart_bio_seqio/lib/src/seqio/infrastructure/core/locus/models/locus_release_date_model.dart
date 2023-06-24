import '../../../../domain/entities/locus.dart';
import '../../data_model.dart';

class LocusReleaseDateModel implements DataModel<Locus> {
  final String releaseDate;

  LocusReleaseDateModel({
    required this.releaseDate,
  });

  @override
  Locus toDomain(Locus locus) => locus.copyWith(
        releaseDate: releaseDate,
      );
}
