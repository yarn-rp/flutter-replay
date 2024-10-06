import 'package:bloc/bloc.dart';
import 'package:replay_logger/replay_logger.dart';

class ReplayBlocObserver extends BlocObserver {
  ReplayBlocObserver({
    required this.replayLogger,
  });

  final ReplayLogger replayLogger;

  void logMessage({
    required String resource,
    required String message,
  }) {
    replayLogger.logMessage(
      resource,
      {'message': message},
      StackTrace.current,
    );
  }

  @override
  void onCreate(BlocBase<dynamic> bloc) {
    super.onCreate(bloc);
    logMessage(
      resource: bloc.runtimeType.toString(),
      message: 'onCreate -- ${bloc.runtimeType}',
    );
  }

  @override
  void onChange(BlocBase<dynamic> bloc, Change<dynamic> change) {
    super.onChange(bloc, change);

    logMessage(
      resource: bloc.runtimeType.toString(),
      message: 'onChange -- ${bloc.runtimeType}, $change',
    );
  }

  @override
  void onError(BlocBase<dynamic> bloc, Object error, StackTrace stackTrace) {
    super.onError(bloc, error, stackTrace);

    logMessage(
      resource: bloc.runtimeType.toString(),
      message: 'onError -- ${bloc.runtimeType}, $error, $stackTrace',
    );
  }

  @override
  void onClose(BlocBase<dynamic> bloc) {
    super.onClose(bloc);

    logMessage(
      resource: bloc.runtimeType.toString(),
      message: 'onClose -- ${bloc.runtimeType}',
    );
  }
}
