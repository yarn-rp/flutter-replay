import 'package:devtools_extensions/devtools_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_replay/bloc/logs_bloc_bloc.dart';
import 'package:replay_logger_dev_ext/replay_logger_dev_ext.dart';

void main() {
  runApp(const FlutterReplayDevtoolsExtensionApp());
}

class FlutterReplayDevtoolsExtensionApp extends StatelessWidget {
  const FlutterReplayDevtoolsExtensionApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LogsBloc(
        replayLoggerClient: ReplayLoggerClient.instance,
      ),
      child: const DevToolsExtension(
        child: BlocLogsPage(), // Build your extension here
      ),
    );
  }
}

class BlocLogsPage extends StatefulWidget {
  const BlocLogsPage({
    super.key,
  });

  @override
  State<BlocLogsPage> createState() => _BlocLogsPageState();
}

class _BlocLogsPageState extends State<BlocLogsPage> {
  @override
  Widget build(BuildContext context) {
    final hasLogs = context.select(
      (LogsBloc bloc) => bloc.state.logs.isNotEmpty,
    );

    print('hasLogs: $hasLogs');

    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter Replay'),
      ),
      body: BlocLogsSuccess(),
    );
  }
}

class BlocLogsSuccess extends StatelessWidget {
  const BlocLogsSuccess({super.key});

  @override
  Widget build(BuildContext context) {
    // Create a navigation rail with the log resources and the respective log entries

    final resources = context.select(
      (LogsBloc bloc) => bloc.state.logs.keys.toList(),
    );
    final selectedResource = context.select(
      (LogsBloc bloc) => bloc.state.selectedResource,
    );
    return Row(
      children: [
        SizedBox(
          width: 200,
          height: double.infinity,
          child: ListView.builder(
            itemCount: resources.length,
            itemBuilder: (context, index) {
              final resource = resources[index];

              return ListTile(
                title: Text(resource),
                onTap: () {
                  context
                      .read<LogsBloc>()
                      .add(LogResourceSelected(resource: resource));
                },
                selected: resource == selectedResource,
              );
            },
          ),
        ),
        const VerticalDivider(),
        Expanded(
          child: selectedResource != null
              ? SelectedResourceLogs(
                  selectedResource: selectedResource,
                )
              : const Center(
                  child: Text('Select a resource to view logs'),
                ),
        ),
      ],
    );
  }
}

class SelectedResourceLogs extends StatelessWidget {
  const SelectedResourceLogs({super.key, required this.selectedResource});

  final String selectedResource;

  @override
  Widget build(BuildContext context) {
    final logs = context.select(
      (LogsBloc bloc) => bloc.state.logs,
    );

    final logEntries = logs[selectedResource] ?? [];

    return ListView.builder(
      itemCount: logEntries.length,
      itemBuilder: (context, index) {
        final logEntry = logEntries[index];

        return ListTile(
          title: Text(logEntry.message.toString()),
          subtitle: Text('At ${logEntry.eventTime}'),
        );
      },
    );
  }
}
