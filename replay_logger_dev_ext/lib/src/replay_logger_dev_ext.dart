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

  bool get isConnectedToApp {
    return serviceManager.connectedApp != null;
  }

  /// Get the logs from the [ReplayLogger].
  Future<List<LogEntry>?> getLogs() async {
    if (!isConnectedToApp) {
      return null;
    }
    final response =
        await serviceManager.callServiceExtensionOnMainIsolate(_extensionName);

    final responseMessages =
        jsonDecode(response.json?['messages'] as String) ?? <String>[];

    final responseDecoded = (responseMessages as List<dynamic>)
        .map((e) => jsonDecode(e as String) as Map<String, dynamic>)
        .toList();

    final logsList = responseDecoded.map(LogEntry.fromJson).toList();

    return logsList;
  }

  Stream<List<LogEntry>?> pollLogs([
    Duration every = const Duration(seconds: 1),
  ]) async* {
    final pollStream = poll<List<LogEntry>?>(
      every: every,
      request: getLogs,
    );

    await for (final logs in pollStream) {
      yield logs;
    }
  }

  Stream<List<BlocLogEntry>?> pollBlocLogs([
    Duration every = const Duration(seconds: 1),
  ]) {
    return pollLogs(every).map((logs) {
      if (logs == null) {
        return null;
      }

      return logs.whereType<BlocLogEntry>().toList();
    });
  }
}
