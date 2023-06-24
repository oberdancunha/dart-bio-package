import 'package:dart_bio_core/exceptions.dart';

class PatternData {
  String getData(String dataData, String dataPattern) {
    final dataRegex = RegExp(dataPattern);
    final dataMatch = dataRegex.firstMatch(dataData);
    if (dataMatch != null) {
      final String dataData = dataMatch.group(1).toString().replaceAll('"', "");

      return dataData;
    }

    throw FileDataFormatException();
  }

  Map<String, String> getMapAnotherData(String dataData, String dataPattern) {
    final dataRegex = RegExp(dataPattern);
    final dataMatch = dataRegex.firstMatch(dataData);
    if (dataMatch != null && dataMatch.groupCount == 2) {
      final String dataKey = dataMatch.group(1).toString().replaceAll('"', "");
      final String dataData = dataMatch.group(2).toString().replaceAll('"', "");

      return {dataKey: dataData};
    }

    throw FileDataFormatException();
  }
}
