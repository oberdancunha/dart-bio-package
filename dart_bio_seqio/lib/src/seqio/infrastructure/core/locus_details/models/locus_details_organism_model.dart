import '../../../../domain/entities/locus_details.dart';
import '../../data_model.dart';

class LocusDetailsOrganismModel implements DataModel<LocusDetails> {
  final String organism;

  LocusDetailsOrganismModel({
    required this.organism,
  });

  @override
  LocusDetails toDomain(LocusDetails locusDetails) {
    late String organism;
    // ignore: prefer-conditional-expressions
    if (locusDetails.organism!.isNotEmpty) {
      organism = locusDetails.organism!.endsWith(';')
          ? '${locusDetails.organism} ${this.organism}'
          : '${locusDetails.organism}; ${this.organism}';
    } else {
      organism = this.organism;
    }

    return locusDetails.copyWith(
      organism: organism,
    );
  }
}
