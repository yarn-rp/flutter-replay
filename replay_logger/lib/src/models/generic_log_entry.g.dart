// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'generic_log_entry.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GenericLogEntry _$GenericLogEntryFromJson(Map<String, dynamic> json) =>
    GenericLogEntry(
      message: json['message'] as String,
      resource: json['resource'] as String,
      timestamp: (json['timestamp'] as num).toInt(),
      metadata: json['metadata'] as Map<String, dynamic>?,
    );

Map<String, dynamic> _$GenericLogEntryToJson(GenericLogEntry instance) =>
    <String, dynamic>{
      'resource': instance.resource,
      'metadata': instance.metadata,
      'timestamp': instance.timestamp,
      'message': instance.message,
    };
