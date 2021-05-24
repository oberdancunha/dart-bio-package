import 'package:dartz/dartz.dart';
import 'package:kt_dart/kt.dart';

import '../../../core/failures.dart';
import 'genbank.dart';

abstract class IGenbankRepositoryFile {
  Future<Either<Failure, KtList<Genbank>>> parser(Stream<String> lines);
}
