import 'package:dart_bio_core/bio_result.dart';
import 'package:dart_bio_core/failures.dart';
import 'package:dart_bio_core/repository_file.dart';
import 'package:dart_bio_core/usecase.dart';
import 'package:dart_bio_dependency_module/dart_bio_dependency_module.dart';

import '../../entities/genbank/genbank.dart' as src;

class GenbankOpenFileUseCase implements UseCase<KtList<src.Genbank>, String> {
  final RepositoryFile<src.Genbank> repositoryFile;

  GenbankOpenFileUseCase({required this.repositoryFile});

  @override
  Future<BioResult<Failure, KtList<src.Genbank>>> call(String fileName) async {
    final fileOpened = repositoryFile.open(fileName);

    final result = await fileOpened.fold(
      (failure) => Future.value(BioResult<Failure, KtList<src.Genbank>>.failure(failure)),
      (fileOpenedData) async {
        final genbankResult = await repositoryFile.parse(fileOpenedData);

        return genbankResult.fold(
          BioResult<Failure, KtList<src.Genbank>>.failure,
          BioResult<Failure, KtList<src.Genbank>>.data,
        );
      },
    );

    return result;
  }
}
