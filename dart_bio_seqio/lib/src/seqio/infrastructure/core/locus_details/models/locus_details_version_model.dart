import '../../../../domain/entities/locus_details.dart';
import '../../data_model.dart';

class LocusDetailsVersionModel implements DataModel<LocusDetails> {
  final String version;

  LocusDetailsVersionModel({
    required this.version,
  });

  @override
  LocusDetails toDomain(LocusDetails locusDetails) {
    late int version;
    const versionPattern = r'\S+\.(\d+)';
    final versionRegex = RegExp(versionPattern);
    final versionMatch = versionRegex.firstMatch(this.version);
    version = versionMatch != null ? int.parse(versionMatch.group(1).toString()) : 1;

    return locusDetails.copyWith(
      version: version,
    );
  }
}
