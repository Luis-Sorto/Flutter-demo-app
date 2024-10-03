import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:demo_app/widgets/filter_type_toggle.dart';

void main() {
  group('Filter toffle test', () {
    testWidgets('FilterTypeToggle widget works as expected',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        const ProviderScope(
          child: MaterialApp(
            home: Scaffold(
              body: FilterTypeToggle(),
            ),
          ),
        ),
      );

      expect(find.byIcon(Icons.format_list_bulleted_rounded), findsOneWidget);
      expect(find.byIcon(Icons.touch_app_rounded), findsOneWidget);
      expect(
          tester.widget<ToggleButtons>(find.byType(ToggleButtons)).isSelected,
          [true, false]);

      await tester.tap(find.byIcon(Icons.touch_app_rounded));
      await tester.pumpAndSettle();

      expect(
          tester.widget<ToggleButtons>(find.byType(ToggleButtons)).isSelected,
          [false, true]);
    });
  });
}
