part of 'logs_bloc_bloc.dart';

class LogsState extends Equatable {
  const LogsState({
    required this.logs,
    this.selectedResource,
  });

  final Map<String, List<LogEntry>> logs;
  final String? selectedResource;

  List<String> get resources => logs.keys.toList();

  LogsState copyWith({
    Map<String, List<LogEntry>>? logs,
    String? selectedResource,
  }) {
    return LogsState(
      logs: logs ?? this.logs,
      selectedResource: selectedResource ?? this.selectedResource,
    );
  }

  @override
  List<Object?> get props => [logs, selectedResource];
}
