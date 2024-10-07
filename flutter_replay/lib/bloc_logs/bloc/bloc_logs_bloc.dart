import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:replay_logger_dev_ext/replay_logger_dev_ext.dart';

part 'bloc_logs_event.dart';
part 'bloc_logs_state.dart';

class BlocLogsBloc extends Bloc<BlocLogsEvent, BlocLogsState> {
  BlocLogsBloc({required this.replayLoggerClient})
      : super(const BlocLogsState(logs: {})) {
    on<BlocLogsUpdated>(_onBlocLogsUpdated);
    on<BlocResourceSelected>(_onBlocResourceSelected);

    replayLoggerClient.pollBlocLogs().listen((logs) {
      if (logs == null) {
        return;
      }
      add(BlocLogsUpdated(logEntries: logs));
    });
  }

  final ReplayLoggerClient replayLoggerClient;

  Future<void> _onBlocResourceSelected(
    BlocResourceSelected event,
    Emitter<BlocLogsState> emit,
  ) async {
    emit(state.copyWith(selectedResource: event.resource));
  }

  Future<void> _onBlocLogsUpdated(
    BlocLogsUpdated event,
    Emitter<BlocLogsState> emit,
  ) async {
    final keys = event.logEntries.map((e) => e.resource).toList();

    final logs = <String, List<BlocLogEntry>>{};

    for (final key in keys) {
      logs[key] = event.logEntries.where((e) => e.resource == key).toList();
    }

    emit(state.copyWith(logs: logs));
  }
}
