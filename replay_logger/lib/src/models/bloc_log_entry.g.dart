// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bloc_log_entry.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BlocCreationLogEntry _$BlocCreationLogEntryFromJson(
        Map<String, dynamic> json) =>
    BlocCreationLogEntry(
      resource: json['resource'] as String,
      timestamp: (json['timestamp'] as num).toInt(),
      blocEventType:
          $enumDecodeNullable(_$BlocEventTypeEnumMap, json['blocEventType']) ??
              BlocEventType.creation,
      entryType:
          $enumDecodeNullable(_$LogEntryTypeEnumMap, json['entryType']) ??
              LogEntryType.bloc,
    );

Map<String, dynamic> _$BlocCreationLogEntryToJson(
        BlocCreationLogEntry instance) =>
    <String, dynamic>{
      'resource': instance.resource,
      'timestamp': instance.timestamp,
      'entryType': _$LogEntryTypeEnumMap[instance.entryType]!,
      'blocEventType': _$BlocEventTypeEnumMap[instance.blocEventType]!,
    };

const _$BlocEventTypeEnumMap = {
  BlocEventType.creation: 'creation',
  BlocEventType.event: 'event',
  BlocEventType.stateChange: 'stateChange',
  BlocEventType.stateTransition: 'stateTransition',
  BlocEventType.error: 'error',
  BlocEventType.close: 'close',
};

const _$LogEntryTypeEnumMap = {
  LogEntryType.bloc: 'bloc',
  LogEntryType.generic: 'generic',
};

BlocEventLogEntry _$BlocEventLogEntryFromJson(Map<String, dynamic> json) =>
    BlocEventLogEntry(
      resource: json['resource'] as String,
      timestamp: (json['timestamp'] as num).toInt(),
      eventData: json['eventData'] as Map<String, dynamic>,
      blocEventType:
          $enumDecodeNullable(_$BlocEventTypeEnumMap, json['blocEventType']) ??
              BlocEventType.event,
      entryType:
          $enumDecodeNullable(_$LogEntryTypeEnumMap, json['entryType']) ??
              LogEntryType.bloc,
    );

Map<String, dynamic> _$BlocEventLogEntryToJson(BlocEventLogEntry instance) =>
    <String, dynamic>{
      'resource': instance.resource,
      'timestamp': instance.timestamp,
      'entryType': _$LogEntryTypeEnumMap[instance.entryType]!,
      'blocEventType': _$BlocEventTypeEnumMap[instance.blocEventType]!,
      'eventData': instance.eventData,
    };

BlocStateChangeLogEntry _$BlocStateChangeLogEntryFromJson(
        Map<String, dynamic> json) =>
    BlocStateChangeLogEntry(
      resource: json['resource'] as String,
      timestamp: (json['timestamp'] as num).toInt(),
      currentStateData: json['currentStateData'] as Map<String, dynamic>,
      nextStateData: json['nextStateData'] as Map<String, dynamic>,
      blocEventType:
          $enumDecodeNullable(_$BlocEventTypeEnumMap, json['blocEventType']) ??
              BlocEventType.stateChange,
      entryType:
          $enumDecodeNullable(_$LogEntryTypeEnumMap, json['entryType']) ??
              LogEntryType.bloc,
    );

Map<String, dynamic> _$BlocStateChangeLogEntryToJson(
        BlocStateChangeLogEntry instance) =>
    <String, dynamic>{
      'resource': instance.resource,
      'timestamp': instance.timestamp,
      'entryType': _$LogEntryTypeEnumMap[instance.entryType]!,
      'blocEventType': _$BlocEventTypeEnumMap[instance.blocEventType]!,
      'currentStateData': instance.currentStateData,
      'nextStateData': instance.nextStateData,
    };

BlocStateTransitionLogEntry _$BlocStateTransitionLogEntryFromJson(
        Map<String, dynamic> json) =>
    BlocStateTransitionLogEntry(
      resource: json['resource'] as String,
      timestamp: (json['timestamp'] as num).toInt(),
      eventData: json['eventData'] as Map<String, dynamic>,
      currentStateData: json['currentStateData'] as Map<String, dynamic>,
      nextStateData: json['nextStateData'] as Map<String, dynamic>,
      blocEventType:
          $enumDecodeNullable(_$BlocEventTypeEnumMap, json['blocEventType']) ??
              BlocEventType.stateTransition,
      entryType:
          $enumDecodeNullable(_$LogEntryTypeEnumMap, json['entryType']) ??
              LogEntryType.bloc,
    );

Map<String, dynamic> _$BlocStateTransitionLogEntryToJson(
        BlocStateTransitionLogEntry instance) =>
    <String, dynamic>{
      'resource': instance.resource,
      'timestamp': instance.timestamp,
      'entryType': _$LogEntryTypeEnumMap[instance.entryType]!,
      'blocEventType': _$BlocEventTypeEnumMap[instance.blocEventType]!,
      'currentStateData': instance.currentStateData,
      'eventData': instance.eventData,
      'nextStateData': instance.nextStateData,
    };

BlocErrorLogEntry _$BlocErrorLogEntryFromJson(Map<String, dynamic> json) =>
    BlocErrorLogEntry(
      resource: json['resource'] as String,
      timestamp: (json['timestamp'] as num).toInt(),
      errorData: json['errorData'] as Map<String, dynamic>,
      blocEventType:
          $enumDecodeNullable(_$BlocEventTypeEnumMap, json['blocEventType']) ??
              BlocEventType.error,
      entryType:
          $enumDecodeNullable(_$LogEntryTypeEnumMap, json['entryType']) ??
              LogEntryType.bloc,
    );

Map<String, dynamic> _$BlocErrorLogEntryToJson(BlocErrorLogEntry instance) =>
    <String, dynamic>{
      'resource': instance.resource,
      'timestamp': instance.timestamp,
      'entryType': _$LogEntryTypeEnumMap[instance.entryType]!,
      'blocEventType': _$BlocEventTypeEnumMap[instance.blocEventType]!,
      'errorData': instance.errorData,
    };

BlocCloseLogEntry _$BlocCloseLogEntryFromJson(Map<String, dynamic> json) =>
    BlocCloseLogEntry(
      resource: json['resource'] as String,
      timestamp: (json['timestamp'] as num).toInt(),
      blocEventType:
          $enumDecodeNullable(_$BlocEventTypeEnumMap, json['blocEventType']) ??
              BlocEventType.close,
      entryType:
          $enumDecodeNullable(_$LogEntryTypeEnumMap, json['entryType']) ??
              LogEntryType.bloc,
    );

Map<String, dynamic> _$BlocCloseLogEntryToJson(BlocCloseLogEntry instance) =>
    <String, dynamic>{
      'resource': instance.resource,
      'timestamp': instance.timestamp,
      'entryType': _$LogEntryTypeEnumMap[instance.entryType]!,
      'blocEventType': _$BlocEventTypeEnumMap[instance.blocEventType]!,
    };
