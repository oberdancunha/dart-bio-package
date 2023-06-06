// ignore: avoid_classes_with_only_static_members
class ValueValidation {
  static String genbankDateValidation(String date) {
    final genbankDatePattern = RegExp(r'\d{2}\-[A-Z]{3}\-\d{4}');
    if (!genbankDatePattern.hasMatch(date)) {
      throw const FormatException();
    }

    return date;
  }
}
