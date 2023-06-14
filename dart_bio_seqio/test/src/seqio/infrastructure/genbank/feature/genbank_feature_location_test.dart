import 'package:dart_bio_core/exceptions.dart';
import 'package:dart_bio_seqio/src/seqio/infrastructure/genbank/feature/genbank_feature_location.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late GenbankFeatureLocation genbankFeatureLocation;
  late String location;
  late String locations;

  setUpAll(() {
    genbankFeatureLocation = GenbankFeatureLocation();
    location = '1..5028';
    locations = 'join(<147594..151006,151097..>151166)';
  });

  group('pipelineLocation function |', () {
    test(
      'Should throw a FileDataFormatException when name and locations is not in the pattern',
      () {
        const featureLocation = "source          1..5028";
        final callPipelineLocation = genbankFeatureLocation.pipelineLocation;
        expect(
          () => callPipelineLocation(featureLocation),
          throwsA(isA<FileDataFormatException>()),
        );
      },
    );

    test('Should identify location name and positions', () {
      const featureLocation = "     source          1..5028";
      final featureIdentifierPositions = genbankFeatureLocation.pipelineLocation(featureLocation);
      expect(featureIdentifierPositions.name, equals('source'));
      expect(
        featureIdentifierPositions.featurePositions.positions.elementAt(0).start,
        equals(1),
      );
      expect(
        featureIdentifierPositions.featurePositions.positions.elementAt(0).end,
        equals(5028),
      );
      expect(featureIdentifierPositions.featurePositions.strand, equals(0));
    });

    test('Should identify location name and positions for complement multi-location feature', () {
      const featureComplementMultiLocation =
          "     CDS          complement(join(<147594..151006,151097..>151166))";
      final featureIdentifierPositions =
          genbankFeatureLocation.pipelineLocation(featureComplementMultiLocation);
      expect(featureIdentifierPositions.name, equals('CDS'));
      expect(
        featureIdentifierPositions.featurePositions.positions.elementAt(0).start,
        equals(147594),
      );
      expect(
        featureIdentifierPositions.featurePositions.positions.elementAt(0).end,
        equals(151006),
      );
      expect(
        featureIdentifierPositions.featurePositions.positions.elementAt(1).start,
        equals(151097),
      );
      expect(
        featureIdentifierPositions.featurePositions.positions.elementAt(1).end,
        equals(151166),
      );
      expect(featureIdentifierPositions.featurePositions.strand, equals(1));
    });
  });

  group('getNameAndLocation function |', () {
    test(
      'Should throw a FileDataFormatException when name and locations is not in the pattern',
      () {
        const featureLocation = "source          1..5028";
        final callGetLocation = genbankFeatureLocation.getNameAndLocation;
        expect(() => callGetLocation(featureLocation), throwsA(isA<FileDataFormatException>()));
      },
    );

    test('Should identify location name and position', () {
      const featureLocation = "     source          1..5028";
      final featureLocationModel = genbankFeatureLocation.getNameAndLocation(featureLocation);
      expect(featureLocationModel.name, equals('source'));
      expect(featureLocationModel.location, equals('1..5028'));
    });
  });

  group('getPositionsAndStrand function |', () {
    test('Should throw a FileDataFormatException when locations is not in the pattern', () {
      const invalidLocation = '..5028';
      final callGetPositionsAndStrand = genbankFeatureLocation.getPositionsAndStrand;
      expect(
        () => callGetPositionsAndStrand(invalidLocation),
        throwsA(isA<FileDataFormatException>()),
      );
    });

    test('Should get start, end and strand', () {
      final positionsAndStrand = genbankFeatureLocation.getPositionsAndStrand(location);
      expect(positionsAndStrand.positions.elementAt(0).start, equals(1));
      expect(positionsAndStrand.positions.elementAt(0).end, equals(5028));
      expect(positionsAndStrand.strand, equals(0));
    });
  });

  group('matchSingleLocation function |', () {
    test('Should return null when feature is not a single location', () {
      final singleLocationMatch = genbankFeatureLocation.matchSingleLocation(locations);
      expect(singleLocationMatch, isNull);
    });

    test('Should return a RegExpMatch when feature is a single location', () {
      final singleLocationMatch = genbankFeatureLocation.matchSingleLocation(location);
      expect(singleLocationMatch, isA<RegExpMatch>());
      expect(singleLocationMatch!.group(1), equals('1'));
      expect(singleLocationMatch.group(2), equals('5028'));
    });
  });

  group('matchMultiLocation function |', () {
    test('Should return null when feature is not a multi-location', () {
      final multiLocationMatch = genbankFeatureLocation.matchMultiLocation(location);
      expect(multiLocationMatch, isNull);
    });

    test('Should return a RegExpMatch when feature is a multi-location', () {
      final multiLocationMatch = genbankFeatureLocation.matchMultiLocation(locations);
      expect(multiLocationMatch, isA<RegExpMatch>());
      expect(multiLocationMatch!.group(1), equals('<147594..151006,151097..>151166'));
    });
  });

  group('getSinglePosition function |', () {
    test('Should get start and end for simple position feature', () {
      final singleLocationMatch = genbankFeatureLocation.matchSingleLocation(location)!;
      final singlePosition = genbankFeatureLocation.getSinglePosition(singleLocationMatch);
      expect(singlePosition.elementAt(0).start, equals(1));
      expect(singlePosition.elementAt(0).end, equals(5028));
    });

    test('Should get start and end for simple complement position feature', () {
      const complementLocation = 'complement(1..5028)';
      final singleLocationMatch = genbankFeatureLocation.matchSingleLocation(complementLocation)!;
      final singlePosition = genbankFeatureLocation.getSinglePosition(singleLocationMatch);
      expect(singlePosition.elementAt(0).start, equals(1));
      expect(singlePosition.elementAt(0).end, equals(5028));
    });
  });

  group('getMultiPosition function |', () {
    test('Should get all starts and ends for multiposition feature', () {
      final multiLocationMatch = genbankFeatureLocation.matchMultiLocation(locations)!;
      final multiLocation = genbankFeatureLocation.getMultiPosition(multiLocationMatch);
      expect(multiLocation.elementAt(0).start, equals(147594));
      expect(multiLocation.elementAt(0).end, equals(151006));
      expect(multiLocation.elementAt(1).start, equals(151097));
      expect(multiLocation.elementAt(1).end, equals(151166));
    });

    test('Should get all starts and ends for complement multiposition feature', () {
      const complementLocations = 'complement(join(<147594..151006,151097..>151166))';
      final multiLocationMatch = genbankFeatureLocation.matchMultiLocation(complementLocations)!;
      final multiLocation = genbankFeatureLocation.getMultiPosition(multiLocationMatch);
      expect(multiLocation.elementAt(0).start, equals(147594));
      expect(multiLocation.elementAt(0).end, equals(151006));
      expect(multiLocation.elementAt(1).start, equals(151097));
      expect(multiLocation.elementAt(1).end, equals(151166));
    });
  });

  group('getStrand function |', () {
    test('Should return strand 0 when location does not contain complement word', () {
      final strand = genbankFeatureLocation.getStrand(location);
      expect(strand, equals(0));
    });

    test('Should return strand 1 when location contains complement word', () {
      const locationComplement = 'complement(1..5028)';
      final strand = genbankFeatureLocation.getStrand(locationComplement);
      expect(strand, equals(1));
    });
  });
}
