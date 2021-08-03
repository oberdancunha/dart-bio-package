import 'package:bio/src/core/bio_result.dart';
import 'package:bio/src/core/failures.dart';
import 'package:bio/src/core/repository_file.dart';
import 'package:bio/src/seqio/domain/genbank/entities/genbank.dart';
import 'package:bio/src/seqio/domain/genbank/usecases/genbank_open_file_usecase.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../../data/SCU49845/SCU49845_genbank_data.dart';

class MockRepositoryFile extends Mock implements RepositoryFile<Genbank> {}

void main() {
  late MockRepositoryFile mockRepositoryFile;
  late GenbankOpenFileUseCase genbankOpenFileUseCase;
  late Stream<String> fileOpenedString;

  setUpAll(() {
    mockRepositoryFile = MockRepositoryFile();
    genbankOpenFileUseCase = GenbankOpenFileUseCase(repositoryFile: mockRepositoryFile);
    fileOpenedString = Stream.value('');
    registerFallbackValue(fileOpenedString);
  });

  void setUpMockRepositoryOpenSuccess() {
    when(() => mockRepositoryFile.open(any())).thenReturn(right(fileOpenedString));
  }

  group(
    'Repository success | ',
    () {
      test(
        'Should return a genbank data (SCU49845)',
        () async {
          final genbankMocked = getGenbankDataEntity();
          setUpMockRepositoryOpenSuccess();
          when(() => mockRepositoryFile.parse(any())).thenAnswer((_) async => right(genbankMocked));
          final result = await genbankOpenFileUseCase('');
          expect(result, BioResult.data(genbankMocked));
        },
      );
    },
  );

  group(
    'Repository failure | ',
    () {
      void setUpMockRepositoryParseFailure(Failure failure) {
        when(() => mockRepositoryFile.parse(any())).thenAnswer((_) async => left(failure));
      }

      test(
        'Should return a BioResult.failure(Failure.fileNotFound())',
        () async {
          const fileNotFoundFailure = Failure.fileNotFound();
          when(() => mockRepositoryFile.open(any())).thenReturn(left(fileNotFoundFailure));
          final result = await genbankOpenFileUseCase('');
          expect(result, const BioResult.failure(fileNotFoundFailure));
        },
      );

      test(
        'Should return a BioResult.failure(Failure.fileEmpty())',
        () async {
          const fileEmptyFailure = Failure.fileEmpty();
          setUpMockRepositoryOpenSuccess();
          setUpMockRepositoryParseFailure(fileEmptyFailure);
          final result = await genbankOpenFileUseCase('');
          expect(result, const BioResult.failure(fileEmptyFailure));
        },
      );

      test(
        'Should return a BioResult.failure(Failure.fileFormatIncorrect())',
        () async {
          const fileFormatIncorrectFailure = Failure.fileFormatIncorrect();
          setUpMockRepositoryOpenSuccess();
          setUpMockRepositoryParseFailure(fileFormatIncorrectFailure);
          final result = await genbankOpenFileUseCase('');
          expect(result, const BioResult.failure(fileFormatIncorrectFailure));
        },
      );
    },
  );
}
