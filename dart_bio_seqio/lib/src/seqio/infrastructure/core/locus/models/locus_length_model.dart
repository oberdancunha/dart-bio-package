import '../../../../domain/entities/locus.dart';
import '../../data_model.dart';

class LocusLengthModel implements DataModel<Locus> {
  final int length;

  LocusLengthModel({
    required this.length,
  });

  @override
  Locus toDomain(Locus locus) => locus.copyWith(
        length: length,
      );
}
