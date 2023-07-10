import '../../../../domain/entities/locus_details.dart';
import '../../data_model.dart';

class LocusDetailsAccessionModel implements DataModel<LocusDetails> {
  final String accession;

  LocusDetailsAccessionModel({
    required this.accession,
  });

  @override
  LocusDetails toDomain(LocusDetails locusDetails) => locusDetails.copyWith(
        accession: accession,
      );
}
