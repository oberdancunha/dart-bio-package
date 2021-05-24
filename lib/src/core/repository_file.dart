import 'dart:convert';
import 'dart:io';

import 'package:dartz/dartz.dart';

import 'failures.dart';

class RepositoryFile {
  Either<Failure, Stream<String>> open(String fileName) {
    final file = File(fileName);
    if (file.existsSync()) {
      final lines = file.openRead().transform(utf8.decoder).transform(const LineSplitter());

      return right(lines);
    } else {
      return left(Failure.fileNotFound(fileName));
    }
  }
}
