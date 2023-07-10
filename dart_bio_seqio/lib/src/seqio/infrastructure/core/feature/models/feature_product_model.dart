import '../../../../domain/entities/feature.dart';
import '../../data_model.dart';

class FeatureProductModel implements DataModel<Feature> {
  final String product;

  FeatureProductModel({
    required this.product,
  });

  @override
  Feature toDomain(Feature feature) => feature.copyWith(
        product: feature.product != null ? "${feature.product} $product" : product,
      );
}
