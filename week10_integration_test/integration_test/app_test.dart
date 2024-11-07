import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:week_10_testing/main.dart';


void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('end-to-end test', () {
    testWidgets('tap on the floating action button, verify name and email',
        (tester) async {
      await tester.pumpWidget(const MainApp());
      //findsNothing is a matcher that expects the item being searched for not to be present in the widget tree.
      expect(find.text('Name: John'), findsNothing); // searches the widget tree for a widget displaying the exact text "Name: John".
      expect(find.text('Email: john@nait.ca'), findsNothing);

      final fab = find.byType(FloatingActionButton);

      await tester.tap(fab);

      await tester.pumpAndSettle(); // ensure every process is finished

      expect(find.text('Name: Jane'), findsOneWidget);
      expect(find.text('Email: jane@nait.ca'), findsOneWidget);
    });
  });
}
