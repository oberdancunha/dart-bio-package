import '../../../../domain/entities/feature.dart';
import 'feature_model.dart';

class FeatureProductModel implements FeatureModel {
  final String product;

  FeatureProductModel({
    required this.product,
  });

  @override
  Feature toDomain(Feature feature) => feature.copyWith(
        product: feature.product != null ? "${feature.product} $product" : product,
      );
}
