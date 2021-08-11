import '../../domain/entities/genbank/locus.dart';

class LocusDto {
  Locus fromGenbankFile({
    required String locusData,
    required String locusSequence,
  }) {
    final locusDataSplitted = locusData.split(RegExp(r'\s+'));

    return Locus(
      name: locusDataSplitted[1],
      length: int.tryParse(locusDataSplitted[2].toString())!,
      type: locusDataSplitted[4],
      shape: locusDataSplitted[5],
      taxonomicDivision: locusDataSplitted[6],
      releaseDate: locusDataSplitted[7],
      sequence: locusSequence,
    );
  }
}
