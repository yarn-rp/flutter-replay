part of 'logs_bloc_bloc.dart';

abstract class LogsEvent extends Equatable {
  const LogsEvent();

  @override
  List<Object> get props => [];
}

@visibleForTesting
class LogsUpdated extends LogsEvent {
  final List<LogEntry> logEntries;

  const LogsUpdated({required this.logEntries});

  @override
  List<Object> get props => [logEntries];
}

class LogResourceSelected extends LogsEvent {
  final String resource;

  const LogResourceSelected({required this.resource});

  @override
  List<Object> get props => [resource];
}
