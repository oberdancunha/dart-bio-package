import '../../../domain/entities/feature.dart';
import 'feature_model.dart';

class FeatureNucleotideSequenceModel implements FeatureModel {
  final String? nucleotideSequence;

  FeatureNucleotideSequenceModel({
    this.nucleotideSequence,
  });

  @override
  Feature toDomain(Feature feature) => feature.copyWith(
        nucleotides: nucleotideSequence,
      );
}
