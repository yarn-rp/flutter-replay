import 'package:bloc/bloc.dart';
import 'package:replay_logger/replay_logger.dart';

class CounterCubit extends Cubit<int> {
  CounterCubit() : super(0);

  void increment() => emit(state + 1);
  void decrement() => emit(state - 1);
}

class CubitStatesLogger extends BlocObserver {
  CubitStatesLogger({
    required this.replayLogger,
  });

  final ReplayLogger replayLogger;

  void logMessage(String message) {
    replayLogger.logMessage(
      {'message': message},
      StackTrace.current,
    );
  }

  @override
  void onCreate(BlocBase bloc) {
    super.onCreate(bloc);
    logMessage('onCreate -- ${bloc.runtimeType}');
  }

  @override
  void onChange(BlocBase bloc, Change change) {
    super.onChange(bloc, change);
    logMessage('onChange -- ${bloc.runtimeType}, $change');
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    logMessage('onError -- ${bloc.runtimeType}, $error');
    super.onError(bloc, error, stackTrace);
  }

  @override
  void onClose(BlocBase bloc) {
    super.onClose(bloc);
    logMessage('onClose -- ${bloc.runtimeType}');
  }
}
