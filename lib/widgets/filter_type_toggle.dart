import 'package:demo_app/providers/ui_state_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FilterTypeToggle extends ConsumerWidget {
  const FilterTypeToggle({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final filterOptions = ref.read(filterOptionsProvider);
    final filterSelection = ref.watch(filterSelectionProvider);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 6),
      child: ToggleButtons(
        direction: Axis.horizontal,
        onPressed: (int index) {
          FocusScope.of(context).unfocus();
          ref
              .read(filterSelectionProvider.notifier)
              .update((state) => state.map((selection) => !selection).toList());
        },
        isSelected: filterSelection,
        children: filterOptions,
      ),
    );
  }
}
