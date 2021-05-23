import 'dart:convert';
import 'dart:io';

import '../../core/exceptions.dart';

class IRepositoryFile {
  Stream<String> open(String fileName) {
    final file = File(fileName);
    if (file.existsSync()) {
      final lines = file.openRead().transform(utf8.decoder).transform(const LineSplitter());

      return lines;
    } else {
      throw FileNotFoundException();
    }
  }
}
