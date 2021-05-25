import 'package:dartz/dartz.dart';
import 'package:kt_dart/kt.dart';

import '../src/core/failures.dart';
import '../src/seqio/domain/genbank/genbank.dart' as src;
import '../src/seqio/domain/genbank/i_genbank_repository_file.dart';

class Genbank {
  IGenbankRepositoryFile genbankRepositoryFile;

  Genbank({required this.genbankRepositoryFile});

  Either<Failure, Stream<String>> open(String fileName) => genbankRepositoryFile.open(fileName);

  Future<Either<Failure, KtList<src.Genbank>>> parser(Stream<String> fileOpened) =>
      genbankRepositoryFile.parser(fileOpened);
}
