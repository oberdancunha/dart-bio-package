// ignore_for_file: avoid_slow_async_io

import 'dart:io';

import 'package:dart_bio_dependency_module/dart_bio_dependency_module.dart';

import 'failures.dart';

abstract class RepositoryFile<Type> {
  Future<Either<Failure, List<String>>> open(String fileName) async {
    final file = File(fileName);
    final fileExists = await file.exists();
    if (fileExists) {
      final lines = await file.readAsLines();

      return right(lines);
    } else {
      return left(Failure.fileNotFound());
    }
  }

  Future<Either<Failure, KtList<Type>>> parse(List<String> fileOpened);
}
