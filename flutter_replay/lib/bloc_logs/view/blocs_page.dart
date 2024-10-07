import 'package:devtools_app_shared/ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_replay/blocs/bloc/bloc_logs_bloc.dart';
import 'package:replay_logger_dev_ext/replay_logger_dev_ext.dart';

class BlocsPage extends StatelessWidget {
  const BlocsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => BlocLogsBloc(
        replayLoggerClient: ReplayLoggerClient.instance,
      ),
      child: const BlocsView(),
    );
  }
}

class BlocsView extends StatefulWidget {
  const BlocsView({
    super.key,
  });

  @override
  State<BlocsView> createState() => _BlocLogsPageState();
}

class _BlocLogsPageState extends State<BlocsView> {
  @override
  Widget build(BuildContext context) {
    final isEmpty = context.select(
      (BlocLogsBloc bloc) => bloc.state.logs.isNotEmpty,
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter Replay'),
      ),
      body: isEmpty ? const BlocLogsSuccess() : const BlocLogsEmpty(),
    );
  }
}

class BlocLogsEmpty extends StatelessWidget {
  const BlocLogsEmpty({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('No logs available'),
    );
  }
}

class BlocLogsSuccess extends StatelessWidget {
  const BlocLogsSuccess({super.key});

  @override
  Widget build(BuildContext context) {
    final resources = context.select(
      (BlocLogsBloc bloc) => bloc.state.logs.keys.toList(),
    );
    final selectedResource = context.select(
      (BlocLogsBloc bloc) => bloc.state.selectedResource,
    );

    return SplitPane(
      axis: Axis.horizontal,
      initialFractions: const [0.2, 0.8],
      children: [
        SizedBox(
          width: 200,
          child: ListView.builder(
            itemCount: resources.length,
            itemBuilder: (context, index) {
              final resource = resources[index];

              return ListTile(
                title: Text(resource),
                onTap: () {
                  context
                      .read<BlocLogsBloc>()
                      .add(BlocResourceSelected(resource: resource));
                },
                selected: resource == selectedResource,
              );
            },
          ),
        ),
        selectedResource != null
            ? SelectedResourceLogs(
                selectedResource: selectedResource,
              )
            : const Center(
                child: Text('Select a resource to view logs'),
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
      (BlocLogsBloc bloc) => bloc.state.logs,
    );

    final logEntries = logs[selectedResource] ?? [];

    return ListView.builder(
      itemCount: logEntries.length,
      itemBuilder: (context, index) {
        final logEntry = logEntries[index];

        return ListTile(
          title: Text(logEntry.metadata.toString()),
          subtitle: Text('At ${logEntry.timestamp}'),
        );
      },
    );
  }
}
