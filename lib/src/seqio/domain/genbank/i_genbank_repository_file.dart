import 'package:kt_dart/kt.dart';

import 'genbank.dart';

abstract class IGenbankRepositoryFile {
  Future<KtList<Genbank>> parser(Stream<String> lines);
}
