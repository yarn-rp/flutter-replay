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
  factory ReplayLogger({
    required LogDataSource dataSource,
    required int initialElapsedMilliseconds,
  }) {
    _instance._initialize(dataSource, initialElapsedMilliseconds);
    return _instance;
  }
  ReplayLogger._internal();

  /// The singleton instance of [ReplayLogger].
  static final ReplayLogger _instance = ReplayLogger._internal();

  bool _isInitialized = false;

  /// The initial elapsed milliseconds since epoch.
  late int initialElapsedMilliseconds;

  /// A data source containing the logs.
  late LogDataSource dataSource;

  void _initialize(LogDataSource dataSource, int initialElapsedMilliseconds) {
    if (_isInitialized) return;

    this.dataSource = dataSource;
    this.initialElapsedMilliseconds = initialElapsedMilliseconds;

    // This extension registers a method that can get a value from the state of
    // the app.
    registerExtension(_extensionName, (method, parameters) async {
      // Respond with a JSON message, indicating the value.
      return ServiceExtensionResponse.result(
        jsonEncode({'messages': jsonEncode(dataSource.getLogs())}),
      );
    });

    dataSource.getLogsStream().listen(
          (event) => logMessage(
            event.message,
            event.stackTrace,
          ),
        );

    _isInitialized = true;
  }

  /// Utility method to get the relative elapsed milliseconds.
  int relativeElapsedMilliseconds(int eventTime) =>
      eventTime - initialElapsedMilliseconds;

  /// Logs a message with the given [message] and [stackTrace].
  Future<void> logMessage(
    Map<String, dynamic> message,
    StackTrace stackTrace,
  ) async {
    final relativeTime = relativeElapsedMilliseconds(
      DateTime.now().millisecondsSinceEpoch,
    );

    final logEvent = LogEntry(
      message: message,
      eventTime: relativeTime,
      stackTrace: stackTrace,
    );

    await dataSource.log(logEvent);
  }
}
