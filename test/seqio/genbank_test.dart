import 'dart:io' show Platform;

import 'package:bio/seqio/genbank.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:path/path.dart' as path;
import "package:path/path.dart" show dirname;

import '../data/SCU49845/SCU49845_genbank_data.dart';

void main() {
  late Genbank genbank;
  String basePath;
  late String genbankFile;
  late String genbankFileNotFound;
  late String genbankFileEmpty;
  late String genbankFileInvalidFormat;

  setUpAll(() {
    genbank = Genbank();
    basePath = path.fromUri(dirname(Platform.script.toString()));
    genbankFile = path.join(basePath, 'test/data/SCU49845/SCU49845.gb');
    genbankFileNotFound = path.join(basePath, 'test/data/sequence1.gb');
    genbankFileEmpty = path.join(basePath, 'test/data/sequence_empty.gb');
    genbankFileInvalidFormat = path.join(basePath, 'test/data/sequence_invalid_format.gb');
  });

  dynamic testResult(String fileName) async {
    final result = await genbank.open(fileName);
    return result.when(
      failure: (genbankFailure) => genbankFailure.maybeMap(
        fileNotFound: (_) => 'File $fileName not found',
        fileIsEmpty: (_) => 'File $fileName is empty',
        fileFormatIncorrect: (_) => 'File $fileName is not a genbank',
        fileParseError: (_) => 'An unexpected error occurred while reading the file',
        orElse: () => null,
      ),
      data: (genbankData) => genbankData,
    );
  }

  test(
    'Should return a file not found message',
    () async {
      final result = await testResult(genbankFileNotFound);
      expect(result, equals('File $genbankFileNotFound not found'));
    },
  );

  test(
    'Should return a file is empty message',
    () async {
      final result = await testResult(genbankFileEmpty);
      expect(result, equals('File $genbankFileEmpty is empty'));
    },
  );

  test(
    'Should return a file is not a genbank message',
    () async {
      final result = await testResult(genbankFileInvalidFormat);
      expect(result, equals('File $genbankFileInvalidFormat is not a genbank'));
    },
  );

  test(
    'Should return a genbank data',
    () async {
      final genbankMocked = getGenbankDataEntity();
      final genbank = await testResult(genbankFile);
      expect(genbank.toString(), equals(genbankMocked.toString()));
    },
  );
}
