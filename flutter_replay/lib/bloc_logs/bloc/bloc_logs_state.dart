part of 'bloc_logs_bloc.dart';

class BlocLogsState extends Equatable {
  const BlocLogsState({
    required this.logs,
    this.selectedResource,
  });

  final Map<String, List<BlocLogEntry>> logs;
  final String? selectedResource;

  List<String> get resources => logs.keys.toList();

  BlocLogsState copyWith({
    Map<String, List<BlocLogEntry>>? logs,
    String? selectedResource,
  }) {
    return BlocLogsState(
      logs: logs ?? this.logs,
      selectedResource: selectedResource ?? this.selectedResource,
    );
  }

  @override
  List<Object?> get props => [logs, selectedResource];
}
