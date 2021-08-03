import 'package:kt_dart/kt.dart';

import '../../../../core/bio_result.dart';
import '../../../../core/failures.dart';
import '../../../../core/repository_file.dart';
import '../../../../core/usecase.dart';
import '../entities/genbank.dart' as src;

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
          (failure) => BioResult<Failure, KtList<src.Genbank>>.failure(failure),
          (data) => BioResult<Failure, KtList<src.Genbank>>.data(data),
        );
      },
    );

    return result;
  }
}
