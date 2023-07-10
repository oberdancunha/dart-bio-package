import 'package:dart_bio_core/exceptions.dart';

import '../../../domain/entities/locus.dart';
import 'locus_event.dart';

class LocusDto {
  final LocusEvent _locusEvent;

  LocusDto(this._locusEvent);

  Locus fromFile({
    required List<String> locusList,
    required String locusSequence,
  }) {
    locusList.forEach(_locusEvent.identifyActionByPattern);
    if (_locusEvent.data == Locus.init()) {
      throw FileDataFormatException();
    }
    final locus = _locusEvent.data.copyWith(
      sequence: locusSequence,
    );
    _locusEvent.initData();

    return locus;
  }
}
