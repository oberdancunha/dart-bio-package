import 'package:dart_bio_core/exceptions.dart';

import '../../../domain/entities/genbank/location_position.dart';
import '../../core/models/feature_identifier_positions_model.dart';
import '../../core/models/feature_location_model.dart';
import '../../core/models/feature_positions_model.dart';

class GenbankFeatureLocation {
  FeatureIdentifierPositionsModel pipelineLocation(
    String featureLocation,
    String featureLocationPattern,
  ) {
    final nameAndLocation = getNameAndLocation(featureLocation, featureLocationPattern);
    final featurePositions = getPositionsAndStrand(nameAndLocation.location);

    return FeatureIdentifierPositionsModel(
      identifier: nameAndLocation.identifier,
      featurePositions: featurePositions,
    );
  }

  FeatureLocationModel getNameAndLocation(String featureLocation, String featureLocationPattern) {
    final locationPatternRegExp = RegExp(featureLocationPattern);
    final matchLocation = locationPatternRegExp.firstMatch(featureLocation);
    if (matchLocation != null) {
      return FeatureLocationModel(
        identifier: matchLocation.group(1).toString(),
        location: matchLocation.group(2).toString(),
      );
    }
    throw FileDataFormatException();
  }

  FeaturePositionsModel getPositionsAndStrand(String location) {
    final singleLocationMatch = matchSingleLocation(location);
    var positions = <LocationPosition>[];
    if (singleLocationMatch != null) {
      positions = getSinglePosition(singleLocationMatch);
    } else {
      final multiLocationMatch = matchMultiLocation(location);
      if (multiLocationMatch != null) {
        positions = getMultiPosition(multiLocationMatch);
      }
    }
    if (positions.isNotEmpty) {
      return FeaturePositionsModel(
        positions: positions,
        strand: getStrand(location),
      );
    }

    throw FileDataFormatException();
  }

  String get _singleLocationPattern => r'\(?\<?(\d+)\.\.\>?(\d+)\)?$';

  RegExpMatch? matchSingleLocation(String location) {
    if (!location.contains(',')) {
      final singleLocationRegex = RegExp(_singleLocationPattern);

      return singleLocationRegex.firstMatch(location);
    }

    return null;
  }

  List<LocationPosition> getSinglePosition(RegExpMatch singleLocationMatch) => [
        LocationPosition(
          start: int.tryParse(singleLocationMatch.group(1).toString())!,
          end: int.tryParse(singleLocationMatch.group(2).toString())!,
        ),
      ];

  String get _multiLocationPattern => r'\(?join\(?([\d\.\,\<\>]+)\)?\)?$';

  RegExpMatch? matchMultiLocation(String locations) {
    final multiLocationRegex = RegExp(_multiLocationPattern);

    return multiLocationRegex.firstMatch(locations);
  }

  List<LocationPosition> getMultiPosition(RegExpMatch multiLocationMatch) {
    final multiPosition = multiLocationMatch.group(1)!.split(',');

    return multiPosition.map((position) {
      position = position.replaceAll(RegExp('<'), '').replaceAll(RegExp('>'), '');
      final startAndEnd = position.split('..');

      return LocationPosition(
        start: int.tryParse(startAndEnd.elementAt(0))!,
        end: int.tryParse(startAndEnd.elementAt(1))!,
      );
    }).toList();
  }

  int getStrand(String location) {
    final isComplementRegex = RegExp('complement');
    final isComplementMatch = isComplementRegex.hasMatch(location);

    return isComplementMatch ? 1 : 0;
  }
}
