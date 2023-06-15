class ParseEvent {
  final String identifierPattern;
  final Function? action;
  final bool isRecall;

  ParseEvent({
    required this.identifierPattern,
    required this.isRecall,
    this.action,
  });
}
