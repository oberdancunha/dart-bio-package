import 'package:dart_bio_core/parse_event.dart';

import '../../../domain/entities/locus.dart';
import '../source_event_execute.dart';
import 'locus_patterns.dart';
import 'models/locus_length_model.dart';
import 'models/locus_name_model.dart';
import 'models/locus_release_date_model.dart';
import 'models/locus_shape_model.dart';
import 'models/locus_taxonomic_division_model.dart';
import 'models/locus_type_model.dart';

abstract class LocusEvent extends SourceEventExecute<Locus> {
  @override
  List<ParseEvent> get patternsList => [
        ParseEvent(
          identifierPattern: locusPatterns.namePattern,
          action: getName,
          isRecall: false,
        ),
        ParseEvent(
          identifierPattern: locusPatterns.lengthPattern,
          action: getLength,
          isRecall: false,
        ),
        ParseEvent(
          identifierPattern: locusPatterns.typePattern,
          action: getType,
          isRecall: false,
        ),
        ParseEvent(
          identifierPattern: locusPatterns.shapePattern,
          action: getShape,
          isRecall: false,
        ),
        ParseEvent(
          identifierPattern: locusPatterns.taxonomicDivision,
          action: getTaxonomicDivision,
          isRecall: false,
        ),
        ParseEvent(
          identifierPattern: locusPatterns.releaseDate,
          action: getReleaseDate,
          isRecall: false,
        ),
      ];

  LocusPatterns get locusPatterns;
  LocusNameModel getName(String locusName, String locusNamePattern);
  LocusLengthModel getLength(String locusLength, String locusLengthPattern);
  LocusTypeModel getType(String locusType, String locusTypePattern);
  LocusShapeModel getShape(String locusShape, String locusShapePattern);
  LocusTaxonomicDivisionModel getTaxonomicDivision(
    String locusTaxonomicDivision,
    String locusTaxonomicDivisionPattern,
  );
  LocusReleaseDateModel getReleaseDate(String locusReleaseDate, String locusReleaseDatePattern);

  @override
  Locus data = Locus.init();

  @override
  void initData() {
    data = Locus.init();
  }
}
