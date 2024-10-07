import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:replay_logger/src/data_sources/data_sources.dart';
import 'package:replay_logger/src/models/models.dart';

const _extensionName = 'ext.flutterReplay.getMessages';

/// {@template replay_logger}
/// A Custom Logger that supports built in timestamp for replay purposes.
/// {@endtemplate}
class ReplayLogger {
  /// {@macro replay_logger}
  ReplayLogger({
    required this.dataSource,
    required this.initialElapsedMilliseconds,
  }) {
    // This extension registers a method that can get a value from the state of
    // the app.
    registerExtension(_extensionName, (method, parameters) async {
      // Respond with a JSON message, indicating the value.
      final logs = dataSource.getLogs();
      final logsJson =
          // ignore: unnecessary_cast
          logs.map((log) => jsonEncode(log.toJson())).toList();

      return ServiceExtensionResponse.result(
        jsonEncode({'messages': jsonEncode(logsJson)}),
      );
    });
  }

  /// The initial elapsed milliseconds since epoch.
  final int initialElapsedMilliseconds;

  /// A data source containing the logs.
  final LogDataSource dataSource;

  /// Utility method to get the relative elapsed milliseconds.
  int relativeElapsedMilliseconds(int timestamp) =>
      timestamp - initialElapsedMilliseconds;

  /// Logs a message with the given [message] and [stackTrace].
  Future<void> logMessage({
    required String resource,
    required String message,
    required Map<String, dynamic> metadata,
    StackTrace? stackTrace,
  }) async {
    final relativeTime = relativeElapsedMilliseconds(
      DateTime.now().millisecondsSinceEpoch,
    );

    final logEvent = GenericLogEntry(
      message: message,
      resource: resource,
      metadata: metadata,
      timestamp: relativeTime,
      stackTrace: stackTrace,
    );

    await dataSource.log(logEvent);
  }

  /// Logs a creation event.
  Future<void> logBlocCreation({
    required String resource,
    StackTrace? stackTrace,
  }) async {
    final relativeTime = relativeElapsedMilliseconds(
      DateTime.now().millisecondsSinceEpoch,
    );

    final logEvent = BlocCreationLogEntry(
      blocEventType: BlocEventType.creation,
      resource: resource,
      timestamp: relativeTime,
      stackTrace: stackTrace,
    );

    await dataSource.log(logEvent);
  }

  /// Logs an event.
  Future<void> logBlocEvent({
    required String resource,
    required Map<String, dynamic> eventData,
    StackTrace? stackTrace,
  }) async {
    final relativeTime = relativeElapsedMilliseconds(
      DateTime.now().millisecondsSinceEpoch,
    );

    final logEvent = BlocEventLogEntry(
      blocEventType: BlocEventType.event,
      resource: resource,
      timestamp: relativeTime,
      eventData: eventData,
      stackTrace: stackTrace,
    );

    await dataSource.log(logEvent);
  }

  /// Logs a state change.
  Future<void> logBlocStateChange({
    required String resource,
    required Map<String, dynamic> currentStateData,
    required Map<String, dynamic> nextStateData,
    StackTrace? stackTrace,
  }) async {
    final relativeTime = relativeElapsedMilliseconds(
      DateTime.now().millisecondsSinceEpoch,
    );

    final logEvent = BlocStateChangeLogEntry(
      blocEventType: BlocEventType.stateChange,
      resource: resource,
      timestamp: relativeTime,
      currentStateData: currentStateData,
      nextStateData: nextStateData,
      stackTrace: stackTrace,
    );

    await dataSource.log(logEvent);
  }

  /// Logs a state transition.
  Future<void> logBlocStateTransition({
    required String resource,
    required Map<String, dynamic> currentStateData,
    required Map<String, dynamic> eventData,
    required Map<String, dynamic> nextStateData,
    StackTrace? stackTrace,
  }) async {
    final relativeTime = relativeElapsedMilliseconds(
      DateTime.now().millisecondsSinceEpoch,
    );

    final logEvent = BlocStateTransitionLogEntry(
      blocEventType: BlocEventType.stateTransition,
      resource: resource,
      timestamp: relativeTime,
      currentStateData: currentStateData,
      eventData: eventData,
      nextStateData: nextStateData,
      stackTrace: stackTrace,
    );

    await dataSource.log(logEvent);
  }

  /// Logs an error.
  Future<void> logBlocError({
    required String resource,
    required Map<String, dynamic> errorData,
    StackTrace? stackTrace,
  }) async {
    final relativeTime = relativeElapsedMilliseconds(
      DateTime.now().millisecondsSinceEpoch,
    );

    final logEvent = BlocErrorLogEntry(
      blocEventType: BlocEventType.error,
      resource: resource,
      timestamp: relativeTime,
      errorData: errorData,
      stackTrace: stackTrace,
    );

    await dataSource.log(logEvent);
  }

  /// Logs a close event.
  Future<void> logBlocClose({
    required String resource,
    StackTrace? stackTrace,
  }) async {
    final relativeTime = relativeElapsedMilliseconds(
      DateTime.now().millisecondsSinceEpoch,
    );

    final logEvent = BlocCloseLogEntry(
      blocEventType: BlocEventType.close,
      resource: resource,
      timestamp: relativeTime,
      stackTrace: stackTrace,
    );

    await dataSource.log(logEvent);
  }
}
