import 'package:flutter_test/flutter_test.dart';
import 'package:very_good_counter/app/app.dart';
import 'package:very_good_counter/counter/counter.dart';

void main() {
  group('App', () {
    testWidgets('renders CounterPage', (tester) async {
      await tester.pumpWidget(const App());
      expect(find.byType(CounterPage), findsOneWidget);
    });
  });
}
