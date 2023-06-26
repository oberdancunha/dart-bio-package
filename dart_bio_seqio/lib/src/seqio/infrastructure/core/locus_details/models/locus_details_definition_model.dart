import '../../../../domain/entities/locus_details.dart';
import '../../data_model.dart';

class LocusDetailsDefinitionModel implements DataModel<LocusDetails> {
  final String definition;

  LocusDetailsDefinitionModel({
    required this.definition,
  });

  @override
  LocusDetails toDomain(LocusDetails locusDetails) => locusDetails.copyWith(
        definition: locusDetails.definition!.isNotEmpty
            ? '${locusDetails.definition} $definition'
            : definition,
      );
}
