import '../../../../domain/entities/locus.dart';
import '../../data_model.dart';

class LocusShapeModel implements DataModel<Locus> {
  final String shape;

  LocusShapeModel({
    required this.shape,
  });

  @override
  Locus toDomain(Locus locus) => locus.copyWith(
        shape: shape,
      );
}
