// ignore_for_file: avoid_dynamic_calls
import 'package:dart_bio_core/parse_event.dart';

import 'data_model.dart';

abstract class SourceEventExecute<Data> {
  Function? _lastEvent;
  List<ParseEvent> get patternsList;
  late Data _data;

  void identifyActionByPattern(String currentData) {
    final patterns = patternsList.where(
      (pattern) {
        final regexPattern = RegExp(pattern.identifierPattern);

        return regexPattern.hasMatch(currentData);
      },
    ).toList();
    if (patterns.isEmpty) {
      _lastEvent = null;
    }
    for (final pattern in patterns) {
      final action = pattern.action ?? _lastEvent;
      if (action != null) {
        final dataModel = runParseAction(
          () => action.call(
            currentData,
            pattern.identifierPattern,
          ),
        );
        data = dataModel.toDomain(data);
        _lastEvent = pattern.isRecall ? action : null;
      }
    }

    return;
  }

  DataModel<Data> runParseAction(Function callAction) {
    final dataModel = callAction() as DataModel<Data>;

    return dataModel;
  }

  set data(Data domain) => _data = domain;

  Data get data => _data;

  void initData();
}
