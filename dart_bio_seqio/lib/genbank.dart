import 'package:dart_bio_core/bio_result.dart';
import 'package:dart_bio_core/failures.dart';
import 'package:dart_bio_dependency_module/dart_bio_dependency_module.dart';

import 'src/seqio/domain/entities/genbank/genbank.dart' as src;
import 'src/seqio/domain/usecases/genbank/genbank_open_file_usecase.dart';
import 'src/seqio/infrastructure/genbank/genbank_repository_file.dart';

class Genbank {
  Future<BioResult<Failure, KtList<src.Genbank>>> open(String fileName) async {
    final genbankRepositoryFile = GenbankRepositoryFile();
    final genbankOpenFileUseCase = GenbankOpenFileUseCase(repositoryFile: genbankRepositoryFile);

    return genbankOpenFileUseCase(fileName);
  }
}
