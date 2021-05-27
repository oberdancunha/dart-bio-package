import 'package:kt_dart/kt.dart';

import '../src/core/bio_result.dart';
import '../src/core/failures.dart';
import '../src/seqio/domain/genbank/genbank.dart' as src;
import '../src/seqio/infrastructure/genbank/genbank_repository_file.dart';

class Genbank {
  Future<BioResult<Failure, KtList<src.Genbank>>> open(String fileName) async {
    final genbankRepositoryFile = GenbankRepositoryFile();
    final fileOpened = genbankRepositoryFile.open(fileName);

    final result = await fileOpened.fold(
      (failure) => Future.value(BioResult<Failure, KtList<src.Genbank>>.failure(failure)),
      (fileOpenedData) async {
        final genbankResult = await genbankRepositoryFile.parse(fileOpenedData);

        return genbankResult.fold(
          (failure) => BioResult<Failure, KtList<src.Genbank>>.failure(failure),
          (data) => BioResult<Failure, KtList<src.Genbank>>.data(data),
        );
      },
    );

    return result;
  }
}
