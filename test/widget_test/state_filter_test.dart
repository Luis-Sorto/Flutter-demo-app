import 'package:demo_app/providers/ui_state_provider.dart';
import 'package:demo_app/widgets/chip_list_filter.dart';
import 'package:demo_app/widgets/dropdown_filter.dart';
import 'package:demo_app/widgets/filter_type_toggle.dart';
import 'package:demo_app/widgets/search_input.dart';
import 'package:demo_app/widgets/state_filter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('StateFilter shows ProgressIndicator', (tester) async {
    await tester.pumpWidget(
      const ProviderScope(
        child: MaterialApp(
          home: StateFilter(states: []),
        ),
      ),
    );

    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });

  testWidgets('StateFilter shows SearchInput and Toggle', (tester) async {
    final states = ['California', 'Texas', 'New York'];

    await tester.pumpWidget(
      ProviderScope(
        child: MaterialApp(
          home: Scaffold(
            body: StateFilter(states: states),
          ),
        ),
      ),
    );

    expect(find.byType(SearchInput), findsOneWidget);
    expect(find.byType(FilterTypeToggle), findsOneWidget);
  });

  testWidgets('StateFilter shows dropdown', (WidgetTester tester) async {
    final states = ['California', 'Texas', 'New York'];

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          selectedOptionProvider.overrideWithValue(FilterType.dropdown),
        ],
        child: MaterialApp(
          home: Scaffold(
            body: StateFilter(states: states),
          ),
        ),
      ),
    );

    expect(find.byType(DropdownMenuFilter), findsOneWidget);
    expect(find.byType(ChipListFilter), findsNothing);
  });

  testWidgets('StateFilter shows chips', (tester) async {
    final states = ['California', 'Texas', 'New York'];

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          selectedOptionProvider.overrideWithValue(FilterType.chips),
        ],
        child: MaterialApp(
          home: Scaffold(
            body: StateFilter(states: states),
          ),
        ),
      ),
    );

    expect(find.byType(ChipListFilter), findsOneWidget);
    expect(find.byType(DropdownMenuFilter), findsNothing);
  });
}
