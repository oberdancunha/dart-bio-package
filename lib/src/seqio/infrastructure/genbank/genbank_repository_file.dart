import 'package:dartz/dartz.dart';
import 'package:kt_dart/collection.dart';

import '../../../core/failures.dart';
import '../../../core/repository_file.dart';
import '../../domain/genbank/genbank.dart';
import 'features_dto.dart';
import 'locus_details_dto.dart';
import 'locus_dto.dart';

class GenbankRepositoryFile extends RepositoryFile {
  final locusDto = LocusDto();
  final locusDetailsDto = LocusDetailsDto();
  final featuresDto = FeaturesDto();

  Future<Either<Failure, KtList<Genbank>>> parse(Stream<String> fileOpened) async {
    final genbankData = <Genbank>[];
    final regexLabelAndValue = RegExp(r'^\s*([A-Z//]+)\s*(.*)$');
    final mainLabels = ['LOCUS', 'DEFINITION', 'FEATURES', 'ORIGIN'];
    String? currentLabel;
    String? lastLabel;
    String? value;
    String? locusData;
    final locusDetailsData = <String>[];
    final featuresValues = <String>[];
    final locusSequence = <String>[];

    try {
      final lines = await fileOpened.toList();
      if (lines.isEmpty) {
        return left(const Failure.fileIsEmpty());
      }
      lines.toList().forEach((line) {
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
      if (locusData != null) {
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
      } else {
        return left(const Failure.fileFormatIncorrect());
      }

      return right(genbankData.toImmutableList());
    } catch (error) {
      return left(Failure.fileParserError(error: error));
    }
  }
}
