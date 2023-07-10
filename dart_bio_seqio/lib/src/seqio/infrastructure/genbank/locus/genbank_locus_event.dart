import '../../core/locus/locus_event.dart';
import '../../core/locus/locus_patterns.dart';
import '../../core/locus/models/locus_length_model.dart';
import '../../core/locus/models/locus_name_model.dart';
import '../../core/locus/models/locus_release_date_model.dart';
import '../../core/locus/models/locus_shape_model.dart';
import '../../core/locus/models/locus_taxonomic_division_model.dart';
import '../../core/locus/models/locus_type_model.dart';
import '../../core/pattern_data.dart';
import 'genbank_locus_patterns.dart';

class GenbankLocusEvent extends LocusEvent {
  @override
  LocusNameModel getName(String locusName, String locusNamePattern) {
    final name = PatternData().getData(locusName, locusNamePattern);

    return LocusNameModel(name: name);
  }

  @override
  LocusPatterns get locusPatterns => GenbankLocusPatterns();

  @override
  LocusLengthModel getLength(String locusLength, String locusLengthPattern) {
    final length = PatternData().getData(locusLength, locusLengthPattern);

    return LocusLengthModel(length: int.parse(length));
  }

  @override
  LocusTypeModel getType(String locusType, String locusTypePattern) {
    final type = PatternData().getData(locusType, locusTypePattern);

    return LocusTypeModel(type: type);
  }

  @override
  LocusShapeModel getShape(String locusShape, String locusShapePattern) {
    final shape = PatternData().getData(locusShape, locusShapePattern);

    return LocusShapeModel(shape: shape);
  }

  @override
  LocusTaxonomicDivisionModel getTaxonomicDivision(
    String locusTaxonomicDivision,
    String locusTaxonomicDivisionPattern,
  ) {
    final taxonomicDivision = PatternData().getData(
      locusTaxonomicDivision,
      locusTaxonomicDivisionPattern,
    );

    return LocusTaxonomicDivisionModel(taxonomicDivision: taxonomicDivision);
  }

  @override
  LocusReleaseDateModel getReleaseDate(String locusReleaseDate, String locusReleaseDatePattern) {
    final releaseDate = PatternData().getData(locusReleaseDate, locusReleaseDatePattern);

    return LocusReleaseDateModel(releaseDate: releaseDate);
  }
}
