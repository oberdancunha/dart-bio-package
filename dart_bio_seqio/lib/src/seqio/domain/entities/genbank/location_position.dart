class LocationPosition {
  final int start;
  final int end;

  const LocationPosition({
    required this.start,
    required this.end,
  });

  LocationPosition copyWith({
    int? start,
    int? end,
  }) =>
      LocationPosition(
        start: start ?? this.start,
        end: end ?? this.end,
      );
}
