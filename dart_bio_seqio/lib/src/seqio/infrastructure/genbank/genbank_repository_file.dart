import 'package:dart_bio_core/exceptions.dart';
import 'package:dart_bio_core/failures.dart';
import 'package:dart_bio_core/repository_file.dart';
import 'package:dart_bio_core/value_transformer.dart';
import 'package:dart_bio_dependency_module/dart_bio_dependency_module.dart';

import '../../domain/entities/genbank/genbank.dart';
import '../core/feature/feature_dto.dart';
import 'feature/genbank_feature_file_execute.dart';
import 'locus/locus_details_dto.dart';
import 'locus/locus_dto.dart';
import 'reference/genbank_reference_dto.dart';

class GenbankRepositoryFile extends RepositoryFile<Genbank> {
  final locusDto = LocusDto();
  final locusDetailsDto = LocusDetailsDto();
  final genbankReferenceDto = GenbankReferenceDto();
  final featureDto = FeatureDto(GenbankFeatureFileExecute());

  @override
  Future<Either<Failure, KtList<Genbank>>> parse(Stream<String> fileOpened) async {
    final genbankData = <Genbank>[];
    final regexLabelAndValue = RegExp(r'^\s*([A-Z//]+)\s*(.*)$');
    final mainLabels = ['LOCUS', 'DEFINITION', 'REFERENCE', 'FEATURES', 'ORIGIN'];
    String? currentLabel;
    String? lastLabel;
    String? value;
    String? locusData;
    final locusDetailsData = <String>[];
    final genbankReferenceData = <String>[];
    final featuresValues = <String>[];
    final locusSequence = <String>[];
    String? locusSequenceFormatted;

    try {
      final lines = await fileOpened.toList();
      if (lines.isEmpty) {
        return left(Failure.fileEmpty());
      }
      lines.forEach((line) {
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
              if (locusData != null) {
                locusSequenceFormatted = locusSequence.isNotEmpty
                    ? formatGenbankLocusSequence(locusSequence.join())
                    : null;
                genbankData.add(
                  Genbank(
                    locus: locusDto.fromGenbankFile(
                      locusData: locusData!,
                      locusSequence: locusSequenceFormatted!,
                    ),
                    locusDetails: locusDetailsDto.fromGenbankFile(locusDetailsData),
                    references:
                        genbankReferenceDto.fromGenbankFile(genbankReferenceData).toImmutableList(),
                    features: featureDto.fromFile(
                      features: featuresValues,
                      locusSequence: locusSequenceFormatted!.split(''),
                    ),
                  ),
                );
                locusDetailsData.clear();
                featuresValues.clear();
                genbankReferenceData.clear();
                locusSequence.clear();
              }
              locusData = line;
            }
            break;
          case 'DEFINITION':
            {
              locusDetailsData.add(line);
            }
            break;
          case 'REFERENCE':
            {
              genbankReferenceData.add(line);
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
        locusSequenceFormatted =
            locusSequence.isNotEmpty ? formatGenbankLocusSequence(locusSequence.join()) : null;
        genbankData.add(
          Genbank(
            locus: locusDto.fromGenbankFile(
              locusData: locusData!,
              locusSequence: locusSequenceFormatted!,
            ),
            locusDetails: locusDetailsDto.fromGenbankFile(locusDetailsData),
            references: genbankReferenceDto.fromGenbankFile(genbankReferenceData).toImmutableList(),
            features: featureDto.fromFile(
              features: featuresValues,
              locusSequence: locusSequenceFormatted!.split(''),
            ),
          ),
        );
      } else {
        return left(Failure.fileFormatIncorrect());
      }

      return right(genbankData.toImmutableList());
      // ignore: avoid_catching_errors
    } on FileDataFormatException catch (_) {
      return left(Failure.fileDataFormatIncorrect());
      // ignore: avoid_catches_without_on_clauses
    } catch (error) {
      return left(Failure.fileParseError(error));
    }
  }
}
