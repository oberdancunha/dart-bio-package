import '../../../../domain/entities/feature.dart';
import '../../data_model.dart';

class FeatureCodonStartModel implements DataModel<Feature> {
  final int codonStart;

  FeatureCodonStartModel({
    required this.codonStart,
  });

  @override
  Feature toDomain(Feature feature) => feature.copyWith(
        codonStart: codonStart,
      );
}
