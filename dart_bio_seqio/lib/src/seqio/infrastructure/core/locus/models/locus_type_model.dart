import '../../../../domain/entities/locus.dart';
import '../../data_model.dart';

class LocusTypeModel implements DataModel<Locus> {
  final String type;

  LocusTypeModel({
    required this.type,
  });

  @override
  Locus toDomain(Locus locus) => locus.copyWith(
        type: type,
      );
}
