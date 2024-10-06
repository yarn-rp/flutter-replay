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
      final logsJson = logs.map((log) => jsonEncode(log.toJson())).toList();

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
  int relativeElapsedMilliseconds(int eventTime) =>
      eventTime - initialElapsedMilliseconds;

  /// Logs a message with the given [message] and [stackTrace].
  Future<void> logMessage(
    String resource,
    Map<String, dynamic> message,
    StackTrace stackTrace,
  ) async {
    final relativeTime = relativeElapsedMilliseconds(
      DateTime.now().millisecondsSinceEpoch,
    );

    final logEvent = LogEntry(
      resource: resource,
      message: message,
      eventTime: relativeTime,
      // stackTrace: stackTrace,
    );

    await dataSource.log(logEvent);
  }
}
