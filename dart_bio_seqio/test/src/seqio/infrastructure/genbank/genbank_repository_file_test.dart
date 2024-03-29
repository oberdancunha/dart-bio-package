import 'dart:io' show Platform;

import 'package:dart_bio_core/failures.dart';
import 'package:dart_bio_dependency_module/dart_bio_dependency_module.dart';
import 'package:dart_bio_seqio/src/seqio/domain/entities/genbank/genbank.dart';
import 'package:dart_bio_seqio/src/seqio/infrastructure/genbank/genbank_repository_file.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:path/path.dart' as path;
import "package:path/path.dart" show dirname;

import '../../../../data/genbank/SCU49845/scu49845_genbank_data.dart';
import '../../../../data/genbank/SCU49845_KX189121_genbank_data.dart';

void main() {
  GenbankRepositoryFile? genbankRepositoryFile;
  String basePath;
  String? genbankFile;
  String? genbankFileIncorrectDataFormat;
  String? genbankFileNotFound;
  String? genbankFileIncorrectFormat;
  String? genbankFileException;
  KtList<Genbank>? genbankDataMocked;
  String? multiGenbankFile;
  KtList<Genbank>? multiGenbankDataMocked;

  setUpAll(() {
    genbankRepositoryFile = GenbankRepositoryFile();
    basePath = path.fromUri(dirname(Platform.script.toString()));
    genbankFile = path.join(basePath, 'test/data/genbank/SCU49845/SCU49845.gb');
    genbankFileIncorrectDataFormat = path.join(
      basePath,
      'test/data/genbank/SCU49845/SCU49845_incorrect_data_format.gb',
    );
    genbankFileNotFound = path.join(basePath, 'test/data/genbank/sequence.gb1');
    genbankFileIncorrectFormat = path.join(
      basePath,
      'test/data/sequence_invalid_format.gb',
    );
    genbankFileException = path.join(basePath, 'test/data/genbank/CP003200.gb');
    genbankDataMocked = getGenbankDataEntity();
    multiGenbankFile = path.join(basePath, 'test/data/genbank/SCU49845_KX189121_sequences.gb');
    multiGenbankDataMocked = getGenbankMultiDataEntity();
  });

  group('Open file |', () {
    test(
      'Should open genbank file',
      () async {
        final fileOpened = await genbankRepositoryFile!.open(genbankFile!);
        final firstLine = await fileOpened.fold(
          (l) => null,
          (lines) async => (lines.first).split(RegExp(r'\s+')),
        );
        expect(firstLine![1], equals('SCU49845'));
        expect(firstLine[2], equals('5028'));
        expect(firstLine[4], equals('DNA'));
      },
    );

    test(
      'Should return a Failure.fileFormatIncorrect when the file is not a valid gbk',
      () async {
        final fileOpened = await genbankRepositoryFile!.open(genbankFileNotFound!);
        expect(fileOpened, left(Failure.fileNotFound()));
      },
    );
  });

  group(
    'Parser file |',
    () {
      group('Success |', () {
        test(
          'Should return a Genbank entity',
          () async {
            final fileOpened = (await genbankRepositoryFile!.open(genbankFile!))
                .fold((l) => null, (fileOpened) => fileOpened);
            final genbankData = (await genbankRepositoryFile!.parse(fileOpened!)).fold(
              (l) => null,
              (genbankData) => genbankData,
            );
            expect(genbankData.toString(), equals(genbankDataMocked.toString()));
          },
        );

        test(
          'Should return a Genbank with more than one locus',
          () async {
            final fileOpened = (await genbankRepositoryFile!.open(multiGenbankFile!))
                .fold((l) => null, (fileOpened) => fileOpened);
            final genbankMultiData = (await genbankRepositoryFile!.parse(fileOpened!)).fold(
              (l) => null,
              (genbankMultiData) => genbankMultiData,
            );
            expect(genbankMultiData!.asList().length, equals(2));
            expect(genbankMultiData.toString(), equals(multiGenbankDataMocked.toString()));
          },
        );
      });

      group('Failure |', () {
        test(
          'Should return a Failure.fileDataFormatIncorrect when gbk file has an incorrect data',
          () async {
            final fileOpened = (await genbankRepositoryFile!.open(genbankFileIncorrectDataFormat!))
                .fold((l) => null, (fileOpened) => fileOpened);
            final genbankData = await genbankRepositoryFile!.parse(fileOpened!);
            expect(genbankData.isLeft(), isTrue);
            expect(genbankData, left(Failure.fileDataFormatIncorrect()));
          },
        );

        test(
          'Should return a Failure.fileEmpty when file is empty',
          () async {
            final genbankData = await genbankRepositoryFile!.parse(const []);
            expect(genbankData, equals(left<Failure, KtList<Genbank>>(Failure.fileEmpty())));
          },
        );

        test(
          'Should return a Failure.fileFormatIncorrect when file is not a gbk',
          () async {
            final fileOpened = (await genbankRepositoryFile!.open(genbankFileIncorrectFormat!))
                .fold((l) => null, (fileOpened) => fileOpened);
            final genbankData = await genbankRepositoryFile!.parse(fileOpened!);
            expect(genbankData.isLeft(), isTrue);
            expect(
              genbankData,
              equals(left<Failure, KtList<Genbank>>(Failure.fileFormatIncorrect())),
            );
          },
        );

        test(
          'Should return a Failure.fileParserError when there is an exception',
          () async {
            final fileOpened = (await genbankRepositoryFile!.open(genbankFileException!))
                .fold((l) => null, (fileOpened) => fileOpened);
            final genbankData = await genbankRepositoryFile!.parse(fileOpened!);
            expect(genbankData.isLeft(), isTrue);
            expect(
              genbankData,
              equals(
                left<Failure, KtList<Genbank>>(
                  Failure.fileParseError('Null check operator used on a null value'),
                ),
              ),
            );
          },
        );
      });
    },
  );
}
