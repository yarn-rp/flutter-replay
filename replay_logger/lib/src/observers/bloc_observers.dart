import 'package:bloc/bloc.dart';
import 'package:replay_logger/replay_logger.dart';

class ReplayBlocObserver extends BlocObserver {
  ReplayBlocObserver({
    required this.replayLogger,
  });

  final ReplayLogger replayLogger;

  String _getResourceName(BlocBase<dynamic> bloc) {
    return bloc.runtimeType.toString();
  }

  @override
  void onCreate(BlocBase<dynamic> bloc) {
    super.onCreate(bloc);
    replayLogger.logBlocCreation(
      resource: _getResourceName(bloc),
      stackTrace: StackTrace.current,
    );
  }

  @override
  void onEvent(Bloc<dynamic, dynamic> bloc, Object? event) {
    super.onEvent(bloc, event);
    replayLogger.logBlocEvent(
      resource: _getResourceName(bloc),
      eventData: {'event': event.toString()},
      stackTrace: StackTrace.current,
    );
  }

  @override
  void onChange(BlocBase<dynamic> bloc, Change<dynamic> change) {
    super.onChange(bloc, change);
    replayLogger.logBlocStateChange(
      resource: _getResourceName(bloc),
      currentStateData: {'currentState': change.currentState.toString()},
      nextStateData: {'nextState': change.nextState.toString()},
      stackTrace: StackTrace.current,
    );
  }

  @override
  void onTransition(
    Bloc<dynamic, dynamic> bloc,
    Transition<dynamic, dynamic> transition,
  ) {
    super.onTransition(bloc, transition);
    replayLogger.logBlocStateTransition(
      resource: _getResourceName(bloc),
      currentStateData: {'currentState': transition.currentState.toString()},
      eventData: {'event': transition.event.toString()},
      nextStateData: {'nextState': transition.nextState.toString()},
      stackTrace: StackTrace.current,
    );
  }

  @override
  void onError(BlocBase<dynamic> bloc, Object error, StackTrace stackTrace) {
    super.onError(bloc, error, stackTrace);
    replayLogger.logBlocError(
      resource: _getResourceName(bloc),
      errorData: {'error': error.toString()},
      stackTrace: stackTrace,
    );
  }

  @override
  void onClose(BlocBase<dynamic> bloc) {
    super.onClose(bloc);
    replayLogger.logBlocClose(
      resource: _getResourceName(bloc),
      stackTrace: StackTrace.current,
    );
  }
}
