import 'package:dartz/dartz.dart';
import 'package:kt_dart/kt.dart';

import '../../../core/failures.dart';
import '../../../core/repository_file.dart';
import 'genbank.dart';

abstract class IGenbankRepositoryFile implements RepositoryFile {
  Future<Either<Failure, KtList<Genbank>>> parser(Stream<String> lines);
}
