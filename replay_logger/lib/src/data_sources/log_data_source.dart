import 'package:replay_logger/src/models/models.dart';

abstract class LogDataSource {
  Future<void> log(LogEntry event);
  Stream<LogEntry> getLogsStream();
  List<LogEntry> getLogs();
}
