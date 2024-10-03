import 'package:demo_app/widgets/search_input.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Search Input tests', () {
    testWidgets('renders with placeholder and search icon',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SearchInput(
              onChanged: (value) {},
              placeholder: 'Search here',
            ),
          ),
        ),
      );

      expect(find.text('Search here'), findsOneWidget);
      expect(find.byIcon(Icons.search), findsOneWidget);
    });

    testWidgets('calls onChanged when typing', (WidgetTester tester) async {
      String typedValue = '';

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SearchInput(
              onChanged: (value) {
                typedValue = value;
              },
              placeholder: 'Search',
            ),
          ),
        ),
      );

      await tester.enterText(find.byType(TextField), 'Happy');
      await tester.pump();

      expect(typedValue, 'Happy');
    });

    testWidgets('clears text', (WidgetTester tester) async {
      String typedValue = 'Happy';

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SearchInput(
              onChanged: (value) {
                typedValue = value;
              },
              placeholder: 'Search',
            ),
          ),
        ),
      );

      // Enter text in the TextField
      await tester.enterText(find.byType(TextField), 'Happy');
      await tester.pumpAndSettle();

      expect(find.byIcon(Icons.close), findsOneWidget);

      await tester.tap(find.byIcon(Icons.close));

      expect(typedValue, '');
      expect(find.text('Happy'), findsNothing);
    });

    testWidgets('delete button not shown when empty',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SearchInput(
              onChanged: (value) {},
              placeholder: 'Search',
            ),
          ),
        ),
      );

      expect(find.byIcon(Icons.close), findsNothing);
    });
  });
}
