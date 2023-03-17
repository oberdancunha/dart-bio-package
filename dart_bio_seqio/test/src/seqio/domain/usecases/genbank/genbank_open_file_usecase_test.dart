import 'package:dart_bio_core/bio_result.dart';
import 'package:dart_bio_core/failures.dart';
import 'package:dart_bio_core/repository_file.dart';
import 'package:dart_bio_dependency_module/dart_bio_dependency_module.dart';
import 'package:dart_bio_seqio/src/seqio/domain/entities/genbank/genbank.dart';
import 'package:dart_bio_seqio/src/seqio/domain/usecases/genbank/genbank_open_file_usecase.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../../data/genbank/SCU49845/scu49845_genbank_data.dart';

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
          expect(result, BioResult<Failure, KtList<Genbank>>.data(genbankMocked));
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
          final fileNotFoundFailure = Failure.fileNotFound();
          when(() => mockRepositoryFile.open(any())).thenReturn(left(fileNotFoundFailure));
          final result = await genbankOpenFileUseCase('');
          expect(result, BioResult<Failure, KtList<Genbank>>.failure(fileNotFoundFailure));
        },
      );

      test(
        'Should return a BioResult.failure(Failure.fileEmpty())',
        () async {
          final fileEmptyFailure = Failure.fileEmpty();
          setUpMockRepositoryOpenSuccess();
          setUpMockRepositoryParseFailure(fileEmptyFailure);
          final result = await genbankOpenFileUseCase('');
          expect(result, BioResult<Failure, KtList<Genbank>>.failure(fileEmptyFailure));
        },
      );

      test(
        'Should return a BioResult.failure(Failure.fileFormatIncorrect())',
        () async {
          final fileFormatIncorrectFailure = Failure.fileFormatIncorrect();
          setUpMockRepositoryOpenSuccess();
          setUpMockRepositoryParseFailure(fileFormatIncorrectFailure);
          final result = await genbankOpenFileUseCase('');
          expect(result, BioResult<Failure, KtList<Genbank>>.failure(fileFormatIncorrectFailure));
        },
      );
    },
  );
}
