import 'package:demo_app/main.dart';
import 'package:demo_app/widgets/chip_list_filter.dart';
import 'package:demo_app/widgets/dropdown_filter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('Integration tests', () {
    testWidgets('App start', (tester) async {
      await tester.pumpWidget(
        const ProviderScope(
          child: MainApp(),
        ),
      );

      await Future.delayed(const Duration(seconds: 30));
    });

    testWidgets('Toggle filter', (tester) async {
      await tester.pumpWidget(
        const ProviderScope(
          child: MainApp(),
        ),
      );

      await tester.pumpAndSettle();

      expect(find.byType(DropdownMenuFilter), findsOneWidget);
      await tester.tap(find.byIcon(Icons.touch_app_rounded));

      await tester.pumpAndSettle();

      expect(find.byType(ChipListFilter), findsOneWidget);
    });

    testWidgets('Filter hides/shows on scroll', (tester) async {
      await tester.pumpWidget(
        const ProviderScope(
          child: MainApp(),
        ),
      );

      await tester.pumpAndSettle();

      expect(find.byType(DropdownMenuFilter), findsOneWidget);

      final list = find.byKey(const ValueKey('personList'));
      final scrollable = find.byWidgetPredicate((w) => w is Scrollable);
      final scrollableOfList = find.descendant(of: list, matching: scrollable);

      await tester.scrollUntilVisible(
        find.byKey(const ValueKey('personCard10')),
        100,
        scrollable: scrollableOfList,
      );

      await tester.pumpAndSettle();

      expect(find.byType(DropdownMenuFilter).hitTestable(), findsNothing);

      await tester.scrollUntilVisible(
        find.byKey(const ValueKey('personCard1')),
        -100,
        scrollable: scrollableOfList,
      );

      await tester.pumpAndSettle();

      expect(find.byType(DropdownMenuFilter).hitTestable(), findsOneWidget);
    });
  });
}
