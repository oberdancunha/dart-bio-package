import 'package:kt_dart/kt.dart';

import '../src/core/bio_result.dart';
import '../src/core/failures.dart';
import '../src/seqio/domain/genbank/entities/genbank.dart' as src;
import '../src/seqio/domain/genbank/usecases/genbank_open_file_usecase.dart';
import '../src/seqio/infrastructure/genbank/genbank_repository_file.dart';

class Genbank {
  Future<BioResult<Failure, KtList<src.Genbank>>> open(String fileName) async {
    final genbankRepositoryFile = GenbankRepositoryFile();
    final genbankOpenFileUseCase = GenbankOpenFileUseCase(repositoryFile: genbankRepositoryFile);

    return genbankOpenFileUseCase(fileName);
  }
}
