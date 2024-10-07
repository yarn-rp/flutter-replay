import 'package:json_annotation/json_annotation.dart';
import 'package:replay_logger/src/models/models.dart';

const _enableStacktraceLogging = false;

@JsonEnum()
enum LogEntryType {
  bloc,
  generic,
}

abstract class LogEntry {
  const LogEntry({
    required this.entryType,
    required this.resource,
    required this.timestamp,
    required this.metadata,
    this.stackTrace,
  });

  final String resource;
  final Map<String, dynamic>? metadata;
  final int timestamp;
  @JsonKey(
    fromJson: StackTrace.fromString,
    toJson: stackTraceToString,
    includeToJson: _enableStacktraceLogging,
    includeFromJson: _enableStacktraceLogging,
  )
  final StackTrace? stackTrace;
  final LogEntryType entryType;

  factory LogEntry.fromJson(Map<String, dynamic> json) {
    final entryType = LogEntryType.values.firstWhere(
      (e) => e.name == json['entryType'] as String,
    );

    return switch (entryType) {
      LogEntryType.bloc => BlocLogEntry.fromJson(json),
      LogEntryType.generic => GenericLogEntry.fromJson(json),
    };
  }
  Map<String, dynamic> toJson();
}

String? stackTraceToString(StackTrace? stackTrace) {
  return stackTrace?.toString();
}
