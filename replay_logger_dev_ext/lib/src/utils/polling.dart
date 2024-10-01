import 'dart:async';

/// An API request that returns a value of type [T].
typedef ApiRequest<T> = Future<T> Function();

/// Polls an API request every [every] duration.
Stream<T> poll<T>({
  required Duration every,
  required ApiRequest<T> request,
}) {
  final controller = StreamController<T>();
  request().then(controller.add).catchError(controller.addError);
  final periodic = Stream<void>.periodic(every).listen((event) {
    request().then(controller.add).catchError(controller.addError);
  });

  controller.onCancel = periodic.cancel;

  return controller.stream;
}

/// Polls until a condition is met.
///
/// This should be used when you want to poll an API endpoint until a certain
/// condition is met. For example, you might want to poll for a created entity
/// until it is available.
Future<T> pollUntil<T>({
  required Duration every,
  required ApiRequest<T> request,
  required Future<bool> Function(Future<T>) until,
}) async {
  Future<T> poll() async {
    final future = request();
    final stop = await until(future);
    if (stop) {
      return future;
    } else {
      return Future<T>.delayed(every, poll);
    }
  }

  return poll();
}

/// A predicate that completes to `true` if the given future completes with a
/// value and `false` otherwise.
Future<bool> untilSuccessful(Future<dynamic> future) =>
    future.then((_) => true).catchError((_) => false);
