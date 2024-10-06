import 'dart:async';

import 'package:replay_logger/src/data_sources/log_data_source.dart';
import 'package:replay_logger/src/models/models.dart';

class InMemoryLogDataSource implements LogDataSource {
  InMemoryLogDataSource() {
    _logs = [];
    _logsStreamController = StreamController<LogEntry>.broadcast();
  }

  late List<LogEntry> _logs;
  late StreamController<LogEntry> _logsStreamController;

  @override
  Future<void> log(LogEntry event) async {
    print('Logging event: ${event.toJson()}');
    _logs.add(event);
    _logsStreamController.add(event);
  }

  @override
  Stream<LogEntry> getLogsStream() {
    print('Getting logs stream');
    return _logsStreamController.stream;
  }

  @override
  List<LogEntry> getLogs() {
    return _logs;
  }
}
