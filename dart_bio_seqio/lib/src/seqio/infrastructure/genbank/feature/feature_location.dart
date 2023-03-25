import '../../../domain/entities/genbank/location_position.dart';
import 'feature_typing.dart';

class FeatureLocation {
  LocationsType getLocations(String featureValue) {
    final positions = _isMultipleLocations(featureValue)
        ? getMultiplePositions(featureValue)
        : getSinglePosition(featureValue);

    if (positions.isNotEmpty) {
      return LocationsType(
        positions: positions,
        strand: _getStrand(featureValue),
      );
    }

    return LocationsType.empty();
  }

  // Values:
  // join(<147594..151006,151097..>151166)
  // join(147594..151006,151097..151166)
  bool _isMultipleLocations(String featureValue) => featureValue.contains('join(');

  Iterable<RegExpMatch> _matchLocations(String featureValue, String locationPattern) {
    final regexLocations = RegExp(locationPattern);
    final matchLocations = regexLocations.allMatches(featureValue);

    return matchLocations;
  }

  // Values:
  // <143707..>147531
  // 143707..147531
  // complement(<139503..>141431)
  // complement(139503..141431)
  String get _singleLocationPattern => r'\(?\<?(\d+)\.\.\>?(\d+)\)?$';

  List<LocationPosition> getSinglePosition(String featureValue) {
    final matchLocations = _matchLocations(featureValue, _singleLocationPattern);
    if (matchLocations.isNotEmpty) {
      return [
        LocationPosition(
          start: int.tryParse(matchLocations.elementAt(0).group(1).toString())!,
          end: int.tryParse(matchLocations.elementAt(0).group(2).toString())!,
        ),
      ];
    }

    return List<LocationPosition>.empty();
  }

  // Values:
  // join(<147594..151006,151097..>151166)
  // join(147594..151006,151097..151166)
  // complement(join(<147594..151006,151097..>151166))
  // complement(join(147594..151006,151097..151166))
  String get _multipleLocationsPattern => r'\(?join\(?([\d\.\,]+)\)?\)?$';

  List<LocationPosition> getMultiplePositions(String featureValue) {
    final matchLocations = _matchLocations(featureValue, _multipleLocationsPattern);
    if (matchLocations.isNotEmpty) {
      final positions = matchLocations.elementAt(0).group(1)!.split(',');

      return positions.map((position) {
        final startAndEnd = position.split('..');

        return LocationPosition(
          start: int.tryParse(startAndEnd.elementAt(0))!,
          end: int.tryParse(startAndEnd.elementAt(1))!,
        );
      }).toList();
    }

    return List<LocationPosition>.empty();
  }

  int _getStrand(String featureValue) {
    final regexIsComplement = RegExp('complement');
    final matchIsComplement = regexIsComplement.allMatches(featureValue);

    return matchIsComplement.isEmpty ? 0 : 1;
  }
}
