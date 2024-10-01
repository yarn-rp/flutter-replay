# Flutter Replay

A Flutter project that helps you with debugging sessions by recording all app events and allowing you to replay those in the future and experience the events in the same way that were recorded.

## Main features
- Create an easy to use api to log messages.
<!-- - Visualize those events in a nice descriptive way that can help developers understand, not only as a logs but as a "stream" events. Main idea is to bring a player that can help dev's understand not only current state but how we got there. Also this has to be stackTrace focused. Associate events with the same stackTrace so we can see traces as a whole instead of separate logs per layer. -->
- Easy to integrate with 3rd party options like Sentry and others.
- Import/Export sessions so we can import sessions from 3rd party to the tool and explore more in depth what happened.

## Future cool features
- Screen recording in sync with those sessions so we can explore both video and logs at the same time.


## Structure
These are the packages that are required for this to work:
- ReplayLogger: a package that will provide an easy to use api to log messages and will provide another class to listen to those messages. 
- FlutterReplayApp: the DevTool app that is going to read the messages from the Logger and display those messages



## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.
