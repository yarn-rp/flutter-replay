part of 'bloc_logs_bloc.dart';

abstract class BlocLogsEvent extends Equatable {
  const BlocLogsEvent();

  @override
  List<Object> get props => [];
}

@visibleForTesting
class BlocLogsUpdated extends BlocLogsEvent {
  final List<BlocLogEntry> logEntries;

  const BlocLogsUpdated({required this.logEntries});

  @override
  List<Object> get props => [logEntries];
}

class BlocResourceSelected extends BlocLogsEvent {
  final String resource;

  const BlocResourceSelected({required this.resource});

  @override
  List<Object> get props => [resource];
}
