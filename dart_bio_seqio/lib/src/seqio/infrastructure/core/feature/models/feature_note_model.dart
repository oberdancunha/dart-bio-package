import '../../../../domain/entities/feature.dart';
import '../../data_model.dart';

class FeatureNoteModel implements DataModel<Feature> {
  final String note;

  FeatureNoteModel({
    required this.note,
  });

  @override
  Feature toDomain(Feature feature) => feature.copyWith(
        note: feature.note != null ? "${feature.note} $note" : note,
      );
}
