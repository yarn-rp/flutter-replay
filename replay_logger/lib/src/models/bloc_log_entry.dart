import 'package:json_annotation/json_annotation.dart';
import 'package:replay_logger/src/models/models.dart';

part 'bloc_log_entry.g.dart';

@JsonEnum()
enum BlocEventType {
  creation,
  event,
  stateChange,
  stateTransition,
  error,
  close
}

sealed class BlocLogEntry extends LogEntry {
  BlocLogEntry({
    required this.blocEventType,
    required super.resource,
    required super.metadata,
    required super.timestamp,
    required super.entryType,
    super.stackTrace,
  });

  final BlocEventType blocEventType;

  factory BlocLogEntry.fromJson(Map<String, dynamic> json) {
    final blocEventType =
        $enumDecodeNullable(_$BlocEventTypeEnumMap, json['blocEventType']);

    if (blocEventType == null) {
      throw ArgumentError('Invalid BlocEventType');
    }

    return switch (blocEventType) {
      BlocEventType.creation => BlocCreationLogEntry.fromJson(json),
      BlocEventType.event => BlocEventLogEntry.fromJson(json),
      BlocEventType.stateChange => BlocStateChangeLogEntry.fromJson(json),
      BlocEventType.stateTransition =>
        BlocStateTransitionLogEntry.fromJson(json),
      BlocEventType.error => BlocErrorLogEntry.fromJson(json),
      BlocEventType.close => BlocCloseLogEntry.fromJson(json),
    };
  }

  Map<String, dynamic> toJson();
}

@JsonSerializable()
class BlocCreationLogEntry extends BlocLogEntry {
  BlocCreationLogEntry({
    required super.resource,
    required super.timestamp,
    super.blocEventType = BlocEventType.creation,
    super.entryType = LogEntryType.bloc,
    super.stackTrace,
  }) : super(metadata: {});

  factory BlocCreationLogEntry.fromJson(Map<String, dynamic> json) =>
      _$BlocCreationLogEntryFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$BlocCreationLogEntryToJson(this);
}

@JsonSerializable()
class BlocEventLogEntry extends BlocLogEntry {
  BlocEventLogEntry({
    required super.resource,
    required super.timestamp,
    required this.eventData,
    super.blocEventType = BlocEventType.event,
    super.entryType = LogEntryType.bloc,
    super.stackTrace,
  }) : super(
          metadata: {'event': eventData},
        );

  final Map<String, dynamic> eventData;

  factory BlocEventLogEntry.fromJson(Map<String, dynamic> json) =>
      _$BlocEventLogEntryFromJson(json);

  Map<String, dynamic> toJson() => _$BlocEventLogEntryToJson(this);
}

@JsonSerializable()
class BlocStateChangeLogEntry extends BlocLogEntry {
  BlocStateChangeLogEntry({
    required super.resource,
    required super.timestamp,
    required this.currentStateData,
    required this.nextStateData,
    super.blocEventType = BlocEventType.stateChange,
    super.entryType = LogEntryType.bloc,
    super.stackTrace,
  }) : super(
          metadata: {
            'currentState': currentStateData,
            'nextState': nextStateData,
          },
        );

  final Map<String, dynamic> currentStateData;
  final Map<String, dynamic> nextStateData;

  factory BlocStateChangeLogEntry.fromJson(Map<String, dynamic> json) =>
      _$BlocStateChangeLogEntryFromJson(json);

  Map<String, dynamic> toJson() => _$BlocStateChangeLogEntryToJson(this);
}

@JsonSerializable()
class BlocStateTransitionLogEntry extends BlocLogEntry {
  BlocStateTransitionLogEntry({
    required super.resource,
    required super.timestamp,
    required this.eventData,
    required this.currentStateData,
    required this.nextStateData,
    super.blocEventType = BlocEventType.stateTransition,
    super.entryType = LogEntryType.bloc,
    super.stackTrace,
  }) : super(
          metadata: {
            'currentState': currentStateData,
            'event': eventData,
            'nextState': nextStateData,
          },
        );

  final Map<String, dynamic> currentStateData;
  final Map<String, dynamic> eventData;
  final Map<String, dynamic> nextStateData;

  factory BlocStateTransitionLogEntry.fromJson(Map<String, dynamic> json) =>
      _$BlocStateTransitionLogEntryFromJson(json);

  Map<String, dynamic> toJson() => _$BlocStateTransitionLogEntryToJson(this);
}

@JsonSerializable()
class BlocErrorLogEntry extends BlocLogEntry {
  BlocErrorLogEntry({
    required super.resource,
    required super.timestamp,
    required this.errorData,
    super.blocEventType = BlocEventType.error,
    super.entryType = LogEntryType.bloc,
    super.stackTrace,
  }) : super(
          metadata: {'error': errorData},
        );

  final Map<String, dynamic> errorData;

  factory BlocErrorLogEntry.fromJson(Map<String, dynamic> json) =>
      _$BlocErrorLogEntryFromJson(json);

  Map<String, dynamic> toJson() => _$BlocErrorLogEntryToJson(this);
}

@JsonSerializable()
class BlocCloseLogEntry extends BlocLogEntry {
  BlocCloseLogEntry({
    required super.resource,
    required super.timestamp,
    super.blocEventType = BlocEventType.close,
    super.entryType = LogEntryType.bloc,
    super.stackTrace,
  }) : super(metadata: {});

  factory BlocCloseLogEntry.fromJson(Map<String, dynamic> json) =>
      _$BlocCloseLogEntryFromJson(json);

  Map<String, dynamic> toJson() => _$BlocCloseLogEntryToJson(this);
}
