import 'package:demo_app/widgets/clear_button.dart';
import 'package:demo_app/widgets/dropdown_filter.dart';
import 'package:demo_app/widgets/search_input.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

void main() {
  group('DropdownMenuFilter Widget Test', () {
    testWidgets('Displays button and opens dialog',
        (WidgetTester tester) async {
      final states = ['California', 'Texas', 'Florida', 'Illinois'];

      await tester.pumpWidget(
        ProviderScope(
          child: MaterialApp(
            home: Scaffold(
              body: DropdownMenuFilter(states: states),
            ),
          ),
        ),
      );

      expect(find.text('Select states'), findsOneWidget);
      expect(find.byIcon(Icons.arrow_drop_down), findsOneWidget);

      await tester.tap(find.byType(OutlinedButton));
      await tester.pumpAndSettle();

      expect(find.byType(SearchInput), findsOneWidget);
      expect(find.byType(ListView), findsOneWidget);
      expect(find.text('California'), findsOneWidget);
    });

    testWidgets('filters states based on search input',
        (WidgetTester tester) async {
      final states = ['California', 'Texas', 'Florida', 'Illinois'];

      await tester.pumpWidget(
        ProviderScope(
          child: MaterialApp(
            home: Scaffold(
              body: DropdownMenuFilter(states: states),
            ),
          ),
        ),
      );

      await tester.tap(find.byType(OutlinedButton));
      await tester.pumpAndSettle();

      await tester.enterText(find.byType(SearchInput), 'Tex');
      await tester.pumpAndSettle();

      expect(find.text('Texas'), findsOneWidget);
      expect(find.text('California'), findsNothing);
    });

    testWidgets('selects and updates state selection',
        (WidgetTester tester) async {
      final states = ['California'];

      await tester.pumpWidget(
        ProviderScope(
          child: MaterialApp(
            home: Scaffold(
              body: DropdownMenuFilter(states: states),
            ),
          ),
        ),
      );

      await tester.tap(find.byType(OutlinedButton));
      await tester.pumpAndSettle();

      await tester.tap(find.byType(Checkbox));
      await tester.pumpAndSettle();

      expect(
        (tester.firstWidget(find.byType(Checkbox)) as Checkbox).value,
        true,
      );
    });

    testWidgets('clear filters with clear button', (WidgetTester tester) async {
      final states = ['California'];

      await tester.pumpWidget(
        ProviderScope(
          child: MaterialApp(
            home: Scaffold(
              body: DropdownMenuFilter(states: states),
            ),
          ),
        ),
      );

      await tester.tap(find.byType(OutlinedButton));
      await tester.pumpAndSettle();

      await tester.tap(find.byType(Checkbox));
      await tester.pumpAndSettle();

      await tester.tap(find.byType(ClearButton));
      await tester.pumpAndSettle();

      expect(
        (tester.firstWidget(find.byType(Checkbox)) as Checkbox).value,
        false,
      );
    });
  });
}
