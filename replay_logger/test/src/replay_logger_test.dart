// ignore_for_file: prefer_const_constructors
import 'package:replay_logger/replay_logger.dart';
import 'package:replay_logger/src/data_sources/in_memory_data_source.dart';
import 'package:test/test.dart';

void main() {
  group('ReplayLogger', () {
    test('can be instantiated', () {
      expect(
        ReplayLogger(
          initialElapsedMilliseconds: 0,
          dataSource: InMemoryLogDataSource(),
        ),
        isNotNull,
      );
    });
  });
}
