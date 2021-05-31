import 'dart:io' show Platform;

import 'package:bio/src/core/failures.dart';
import 'package:bio/src/seqio/domain/genbank/genbank.dart';
import 'package:bio/src/seqio/infrastructure/genbank/genbank_repository_file.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kt_dart/kt.dart';
import 'package:path/path.dart' as path;
import "package:path/path.dart" show dirname;

import '../../../../data/SCU49845/SCU49845_genbank_data.dart';
import '../../../../data/SCU49845_KX189121_genbank_data.dart';

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
    genbankFile = path.join(basePath, 'test/data/SCU49845/SCU49845.gb');
    genbankFileNotFound = path.join(basePath, 'test/data/sequence.gb1');
    genbankDataMocked = getGenbankDataEntity();
    multiGenbankFile = path.join(basePath, 'test/data/SCU49845_KX189121_sequences.gb');
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
        expect(fileOpened, left(const Failure.fileNotFound()));
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
          'Should return a Failure.fileIsEmpty when file is empty',
          () async {
            final genbankData = await genbankRepositoryFile!.parse(const Stream.empty());
            expect(genbankData, equals(left(const Failure.fileIsEmpty())));
          },
        );

        test(
          'Should return a Failure.fileFormatIncorrect when file is not a gbk',
          () async {
            final genbankData =
                await genbankRepositoryFile!.parse(Stream.value('Value Not Format'));
            expect(genbankData, equals(left(const Failure.fileFormatIncorrect())));
          },
        );

        test(
          'Should return a Failure.fileParserError when there is an exception',
          () async {
            final genbankData = await genbankRepositoryFile!.parse(Stream.error('parserError'));
            expect(genbankData, equals(left(const Failure.fileParserError(error: 'parserError'))));
          },
        );
      });
    },
  );
}
