import 'dart:convert';

import 'package:devtools_extensions/devtools_extensions.dart';
import 'package:replay_logger/replay_logger.dart';
import 'package:replay_logger_dev_ext/src/utils/polling.dart';

const _extensionName = 'ext.flutterReplay.getMessages';

/// {@template replay_logger_dev_ext}
/// A Very Good Project created by Very Good CLI.
/// {@endtemplate}
class ReplayLoggerDevExt {
  /// {@macro replay_logger_dev_ext}
  const ReplayLoggerDevExt();
}

class ReplayLoggerClient {
  ReplayLoggerClient._();

  static ReplayLoggerClient? _instance;

  /// The singleton instance of [ReplayLoggerClient].
  static ReplayLoggerClient get instance {
    _instance ??= ReplayLoggerClient._();
    return _instance!;
  }

  /// Get the logs from the [ReplayLogger].
  Future<List<LogEntry>> getLogs() async {
    final response =
        await serviceManager.callServiceExtensionOnMainIsolate(_extensionName);

    final responseMessages =
        jsonDecode(response.json?['messages'] as String) ?? <String>[];

    final responseStrings =
        (responseMessages as List<dynamic>).map((e) => e.toString()).toList();

    return responseStrings
        .map((e) => LogEntry.fromJson(jsonDecode(e) as Map<String, dynamic>))
        .toList();
  }

  Stream<List<LogEntry>> pollLogs([
    Duration every = const Duration(milliseconds: 100),
  ]) async* {
    final pollStream = poll<List<LogEntry>>(
      every: every,
      request: getLogs,
    );

    await for (final logs in pollStream) {
      yield logs;
    }
  }
}
