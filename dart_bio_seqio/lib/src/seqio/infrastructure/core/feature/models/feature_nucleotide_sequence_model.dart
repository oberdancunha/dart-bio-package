import '../../../../domain/entities/feature.dart';
import '../../data_model.dart';

class FeatureNucleotideSequenceModel implements DataModel<Feature> {
  final String? nucleotideSequence;

  FeatureNucleotideSequenceModel({
    this.nucleotideSequence,
  });

  @override
  Feature toDomain(Feature feature) => feature.copyWith(
        nucleotides: nucleotideSequence,
      );
}
