import '../../core/locus/locus_patterns.dart';

class GenbankLocusPatterns extends LocusPatterns {
  @override
  String get namePattern =>
      r'^LOCUS\s+(\S+)\s+\d+\sbp\s+[A-Za-z]+\s+[A-Za-z]+\s+[A-Za-z]+\s+\d{2}\-[A-Z]{3}\-\d{4}$';

  @override
  String get lengthPattern =>
      r'^LOCUS\s+\S+\s+(\d+)\sbp\s+[A-Za-z]+\s+[A-Za-z]+\s+[A-Za-z]+\s+\d{2}\-[A-Z]{3}\-\d{4}$';

  @override
  String get typePattern =>
      r'^LOCUS\s+\S+\s+\d+\sbp\s+([A-Za-z]+)\s+[A-Za-z]+\s+[A-Za-z]+\s+\d{2}\-[A-Z]{3}\-\d{4}$';

  @override
  String get shapePattern =>
      r'^LOCUS\s+\S+\s+\d+\sbp\s+[A-Za-z]+\s+([A-Za-z]+)\s+[A-Za-z]+\s+\d{2}\-[A-Z]{3}\-\d{4}$';

  @override
  String get taxonomicDivision =>
      r'^LOCUS\s+\S+\s+\d+\sbp\s+[A-Za-z]+\s+[A-Za-z]+\s+([A-Za-z]+)\s+\d{2}\-[A-Z]{3}\-\d{4}$';

  @override
  String get releaseDate =>
      r'^LOCUS\s+\S+\s+\d+\sbp\s+[A-Za-z]+\s+[A-Za-z]+\s+[A-Za-z]+\s+(\d{2}\-[A-Z]{3}\-\d{4})$';

  @override
  String get recallLastEventPattern => throw UnimplementedError();
}
