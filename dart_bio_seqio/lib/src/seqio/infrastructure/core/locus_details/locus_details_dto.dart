import 'package:dart_bio_core/exceptions.dart';

import '../../../domain/entities/locus_details.dart';
import 'locus_details_event.dart';

class LocusDetailsDto {
  final LocusDetailsEvent _locusDetailsEvent;

  LocusDetailsDto(this._locusDetailsEvent);

  LocusDetails fromFile(List<String> locusDetailsList) {
    locusDetailsList.forEach(_locusDetailsEvent.identifyActionByPattern);
    if (_locusDetailsEvent.data == LocusDetails.init()) {
      throw FileDataFormatException();
    }
    final locusDetails = _locusDetailsEvent.data;
    _locusDetailsEvent.initData();

    return locusDetails;
  }
}
