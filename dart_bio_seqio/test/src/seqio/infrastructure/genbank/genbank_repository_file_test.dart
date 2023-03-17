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
  String? genbankFileNotFound;
  KtList<Genbank>? genbankDataMocked;
  String? multiGenbankFile;
  KtList<Genbank>? multiGenbankDataMocked;

  setUpAll(() {
    genbankRepositoryFile = GenbankRepositoryFile();
    basePath = path.fromUri(dirname(Platform.script.toString()));
    genbankFile = path.join(basePath, 'test/data/genbank/SCU49845/SCU49845.gb');
    genbankFileNotFound = path.join(basePath, 'test/data/genbank/sequence.gb1');
    genbankDataMocked = getGenbankDataEntity();
    multiGenbankFile = path.join(basePath, 'test/data/genbank/SCU49845_KX189121_sequences.gb');
    multiGenbankDataMocked = getGenbankMultiDataEntity();
  });

  group('Open file | ', () {
    test(
      'Should open genbank file',
      () async {
        final fileOpened = genbankRepositoryFile!.open(genbankFile!);
        final firstLine = await fileOpened.fold(
          (l) => null,
          (lines) async => (await lines.first).split(RegExp(r'\s+')),
        );
        expect(firstLine![1], equals('SCU49845'));
        expect(firstLine[2], equals('5028'));
        expect(firstLine[4], equals('DNA'));
      },
    );

    test(
      'Should return a Failure.fileNotFound when not finding the file',
      () {
        final fileOpened = genbankRepositoryFile!.open(genbankFileNotFound!);
        expect(fileOpened, left(Failure.fileNotFound()));
      },
    );
  });

  group(
    'Parser file',
    () {
      group('Success', () {
        test(
          'Should return a Genbank entity',
          () async {
            final fileOpened = genbankRepositoryFile!
                .open(genbankFile!)
                .fold((l) => null, (fileOpened) => fileOpened);
            final genbankData = (await genbankRepositoryFile!.parse(fileOpened!)).fold(
              (l) => null,
              (genbankData) => genbankData,
            );
            expect(genbankData.toString(), equals(genbankDataMocked.toString()));
          },
        );

        test(
          'Should return a Genbank with more than one locuus',
          () async {
            final fileOpened = genbankRepositoryFile!
                .open(multiGenbankFile!)
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

      group('Failure', () {
        test(
          'Should return a Failure.fileEmpty when file is empty',
          () async {
            final genbankData = await genbankRepositoryFile!.parse(const Stream.empty());
            expect(genbankData, equals(left<Failure, KtList<Genbank>>(Failure.fileEmpty())));
          },
        );

        test(
          'Should return a Failure.fileFormatIncorrect when file is not a gbk',
          () async {
            final genbankData =
                await genbankRepositoryFile!.parse(Stream.value('Value Not Format'));
            expect(
              genbankData,
              equals(
                left<Failure, KtList<Genbank>>(Failure.fileFormatIncorrect()),
              ),
            );
          },
        );

        test(
          'Should return a Failure.fileParserError when there is an exception',
          () async {
            final genbankData = await genbankRepositoryFile!.parse(Stream.error('parserError'));
            expect(
              genbankData,
              equals(
                left<Failure, KtList<Genbank>>(Failure.fileParseError('parserError')),
              ),
            );
          },
        );
      });
    },
  );
}
