import 'dart:convert';
import 'dart:io';

import 'package:dart_bio_dependency_module/dart_bio_dependency_module.dart';

import 'failures.dart';

abstract class RepositoryFile<Type> {
  Either<Failure, Stream<String>> open(String fileName) {
    final file = File(fileName);
    if (file.existsSync()) {
      final lines = file.openRead().transform(utf8.decoder).transform(const LineSplitter());

      return right(lines);
    } else {
      return left(Failure.fileNotFound());
    }
  }

  Future<Either<Failure, KtList<Type>>> parse(Stream<String> fileOpened);
}
