import '../../../../domain/entities/locus_details.dart';
import '../../data_model.dart';

class LocusDetailsKeywordsModel implements DataModel<LocusDetails> {
  final String keywords;

  LocusDetailsKeywordsModel({
    required this.keywords,
  });

  @override
  LocusDetails toDomain(LocusDetails locusDetails) => locusDetails.copyWith(
        keywords: keywords,
      );
}
