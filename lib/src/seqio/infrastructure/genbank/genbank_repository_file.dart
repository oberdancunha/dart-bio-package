import 'package:kt_dart/collection.dart';

import '../../core/i_repository_file.dart';
import '../../domain/genbank/genbank.dart';
import '../../domain/genbank/i_genbank_repository_file.dart';
import 'features_dto.dart';
import 'locus_details_dto.dart';
import 'locus_dto.dart';

class GenbankRepositoryFile extends IRepositoryFile implements IGenbankRepositoryFile {
  final locusDto = LocusDto();
  final locusDetailsDto = LocusDetailsDto();
  final featuresDto = FeaturesDto();

  @override
  Future<KtList<Genbank>> parser(Stream<String> lines) async {
    try {
      final genbankData = <Genbank>[];
      String? currentLabel;
      String? lastLabel;
      String? value;
      String? locusData;
      final locusDetailsData = <String>[];
      final featuresValues = <String>[];
      final locusSequence = <String>[];
      final regexLabelAndValue = RegExp(r'^\s*([A-Z//]+)\s*(.*)$');
      final mainLabels = ['LOCUS', 'DEFINITION', 'FEATURES', 'ORIGIN'];

      (await lines.toList()).forEach((line) {
        final matchLabelAndValue = regexLabelAndValue.allMatches(line);
        if (matchLabelAndValue.isNotEmpty) {
          currentLabel = matchLabelAndValue.elementAt(0).group(1);
          if (mainLabels.contains(currentLabel)) {
            lastLabel = currentLabel;
          } else {
            currentLabel = lastLabel;
          }
          value = matchLabelAndValue.elementAt(0).group(2);
        } else {
          currentLabel = lastLabel;
          value = line;
        }
        switch (currentLabel) {
          case 'LOCUS':
            {
              locusData = line;
            }
            break;
          case 'DEFINITION':
            {
              locusDetailsData.add(line);
            }
            break;
          case 'FEATURES':
            {
              featuresValues.add(line);
            }
            break;
          case 'ORIGIN':
            {
              if (value!.isNotEmpty) {
                locusSequence.add(value!);
              }
            }
            break;
        }
      });
      genbankData.add(
        Genbank(
          locus: locusDto.fromGenbankFile(
            locusData: locusData!,
            locusSequence: locusSequence,
          ),
          locusDetails: locusDetailsDto.fromGenbankFile(locusDetailsData),
          features: featuresDto.fromGenbankFile(featuresValues),
        ),
      );

      return genbankData.toImmutableList();
    } on Exception {
      throw Error();
    }
  }
}
