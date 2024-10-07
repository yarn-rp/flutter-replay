import 'package:devtools_extensions/devtools_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_replay/blocs/view/blocs_page.dart';

void main() {
  runApp(const FlutterReplayDevtoolsExtensionApp());
}

class FlutterReplayDevtoolsExtensionApp extends StatelessWidget {
  const FlutterReplayDevtoolsExtensionApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const DevToolsExtension(
      child: BlocsPage(),
    );
  }
}
