import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:replay_logger_dev_ext/replay_logger_dev_ext.dart';

part 'logs_bloc_event.dart';
part 'logs_bloc_state.dart';

class LogsBloc extends Bloc<LogsEvent, LogsState> {
  LogsBloc({required this.replayLoggerClient})
      : super(const LogsState(logs: {})) {
    on<LogsUpdated>(_onLogsUpdated);
    on<LogResourceSelected>(_onLogResourceSelected);

    replayLoggerClient.pollLogs().listen((logs) {
      add(LogsUpdated(logEntries: logs ?? []));
    });
  }

  final ReplayLoggerClient replayLoggerClient;

  Future<void> _onLogResourceSelected(
    LogResourceSelected event,
    Emitter<LogsState> emit,
  ) async {
    emit(state.copyWith(selectedResource: event.resource));
  }

  Future<void> _onLogsUpdated(
    LogsUpdated event,
    Emitter<LogsState> emit,
  ) async {
    final keys = event.logEntries.map((e) => e.resource).toList();

    final logs = <String, List<LogEntry>>{};

    for (final key in keys) {
      logs[key] = event.logEntries.where((e) => e.resource == key).toList();
    }

    emit(state.copyWith(logs: logs));
  }
}
