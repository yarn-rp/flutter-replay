import 'package:json_annotation/json_annotation.dart';
import 'package:replay_logger/replay_logger.dart';

part 'generic_log_entry.g.dart';

@JsonSerializable()
class GenericLogEntry extends LogEntry {
  GenericLogEntry({
    required this.message,
    required String resource,
    required int timestamp,
    Map<String, dynamic>? metadata,
    StackTrace? stackTrace,
  }) : super(
          entryType: LogEntryType.generic,
          resource: resource,
          timestamp: timestamp,
          metadata: {
            'message': message,
            ...?metadata,
          },
          stackTrace: stackTrace,
        );

  final String message;

  factory GenericLogEntry.fromJson(Map<String, dynamic> json) =>
      _$GenericLogEntryFromJson(json);

  Map<String, dynamic> toJson() => _$GenericLogEntryToJson(this);
}
