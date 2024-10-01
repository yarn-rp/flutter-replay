import 'package:devtools_extensions/devtools_extensions.dart';
import 'package:flutter/material.dart';
import 'package:replay_logger_dev_ext/replay_logger_dev_ext.dart';

void main() {
  runApp(const FlutterReplayDevtoolsExtensionApp());
}

class FlutterReplayDevtoolsExtensionApp extends StatelessWidget {
  const FlutterReplayDevtoolsExtensionApp({super.key});

  @override
  Widget build(BuildContext context) {
    return DevToolsExtension(
      child: BlocLogsPage(
        loggerClient: ReplayLoggerClient.instance,
      ), // Build your extension here
    );
  }
}

class BlocLogsPage extends StatefulWidget {
  const BlocLogsPage({
    super.key,
    required this.loggerClient,
  });

  final ReplayLoggerClient loggerClient;

  @override
  State<BlocLogsPage> createState() => _BlocLogsPageState();
}

class _BlocLogsPageState extends State<BlocLogsPage> {
  List<LogEntry> logs = [];

  @override
  void initState() {
    super.initState();
    setupSubs();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void setupSubs() {
    widget.loggerClient.pollLogs().listen((event) {
      setState(() {
        logs = event;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter Replay'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: logs.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(
                    logs[index].message.toString(),
                  ),
                  subtitle: Text(
                    logs[index].eventTime.toString(),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
