import '../../../domain/entities/feature.dart';
import 'feature_model.dart';

class FeatureCodonStartModel implements FeatureModel {
  final int codonStart;

  FeatureCodonStartModel({
    required this.codonStart,
  });

  @override
  Feature toDomain(Feature feature) => feature.copyWith(
        codonStart: codonStart,
      );
}
