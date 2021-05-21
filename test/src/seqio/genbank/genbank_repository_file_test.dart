import 'dart:io' show Platform;

import 'package:bio/src/core/exceptions.dart';
import 'package:bio/src/seqio/genbank/genbank.dart';
import 'package:bio/src/seqio/genbank/genbank_repository_file.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kt_dart/kt.dart';
import 'package:matcher/matcher.dart';
import 'package:path/path.dart' as path;
import "package:path/path.dart" show dirname;

import '../../../data/genbank_data.dart';
import '../../../data/genbank_original_format_data.dart';

void main() {
  GenbankRepositoryFile? genbankRepositoryFile;
  String basePath;
  String? genbankFile;
  String? genbankFileNotFound;
  KtList<Genbank>? genbankDataMocked;

  setUpAll(() {
    genbankRepositoryFile = GenbankRepositoryFile();
    basePath = path.fromUri(dirname(Platform.script.toString()));
    genbankFile = path.join(basePath, 'test/data/sequence.gb');
    genbankFileNotFound = path.join(basePath, 'test/data/sequence.gb1');
    genbankDataMocked = getGenbankDataEntity();
  });

  group('Open file | ', () {
    test(
      'Should open genbank file',
      () async {
        final lines = genbankRepositoryFile!.open(genbankFile!);
        final firstLine = (await lines.first).split(RegExp(r'\s+'));
        expect(firstLine[1], equals('SCU49845'));
        expect(firstLine[2], equals('5028'));
        expect(firstLine[4], equals('DNA'));
      },
    );

    test(
      'Should throw a FileNotFoundException when not finding the file',
      () {
        final callOpenFile = genbankRepositoryFile!.open;
        expect(
          () => callOpenFile(genbankFileNotFound!),
          throwsA(const TypeMatcher<FileNotFoundException>()),
        );
      },
    );
  });

  group(
    'Parser file',
    () {
      test(
        'Should return a Genbank entity',
        () async {
          final lines = genbankRepositoryFile!.open(genbankFile!);
          final genbankData = await genbankRepositoryFile!.parser(lines);
          expect(genbankData, equals(genbankDataMocked));
        },
      );

      test(
        'Should format the genbank locus sequence by removing numbers, blanks and line breaks',
        () {
          final genbankLocusSequenceMocked = getGenbankLocusSequence().join();
          final locusSequenceFormattedMocked = getLocusSequenceFormatted();
          final locusSequenceFormatted = genbankRepositoryFile!
              .formatLocusSequence(genbankLocusSequenceMocked);
          expect(locusSequenceFormatted, equals(locusSequenceFormattedMocked));
        },
      );

      test(
        'Should get locus details (LocusDetails entity)',
        () {
          final locusDetailsGenbank = getGenbankLocusDetails();
          final locusDetailsMocked = getLocusDetails();
          final locusDetails =
              genbankRepositoryFile!.getLocusDetails(locusDetailsGenbank);
          expect(locusDetails, equals(locusDetailsMocked));
        },
      );
    },
  );
}
