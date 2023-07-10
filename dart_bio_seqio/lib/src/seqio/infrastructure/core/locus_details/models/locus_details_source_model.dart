import '../../../../domain/entities/locus_details.dart';
import '../../data_model.dart';

class LocusDetailsSourceModel implements DataModel<LocusDetails> {
  final String source;

  LocusDetailsSourceModel({
    required this.source,
  });

  @override
  LocusDetails toDomain(LocusDetails locusDetails) => locusDetails.copyWith(
        source: locusDetails.source!.isNotEmpty ? '${locusDetails.source} $source' : source,
      );
}
