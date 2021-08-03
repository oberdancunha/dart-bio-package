import 'dart:convert';
import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:kt_dart/kt.dart';

import 'failures.dart';

abstract class RepositoryFile<Type> {
  Either<Failure, Stream<String>> open(String fileName) {
    final file = File(fileName);
    if (file.existsSync()) {
      final lines = file.openRead().transform(utf8.decoder).transform(const LineSplitter());

      return right(lines);
    } else {
      return left(const Failure.fileNotFound());
    }
  }

  Future<Either<Failure, KtList<Type>>> parse(Stream<String> fileOpened);
}
