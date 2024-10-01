import 'package:demo_app/providers/filter_provider.dart';
import 'package:demo_app/widgets/clear_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ChipListFilter extends ConsumerWidget {
  const ChipListFilter({super.key, required this.states});

  final List<String> states;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final filter = ref.watch(filterProvider);
    final filterNotifier = ref.read(filterProvider.notifier);

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        ClearButton(onPressed: filterNotifier.clearAllFilters),
        Expanded(
          child: SizedBox(
            height: 45,
            child: ListView.builder(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemCount: states.length,
              itemBuilder: (_, index) {
                final isSelected =
                    filter.selectedStates.contains(states[index]);
                return Container(
                  margin: const EdgeInsets.symmetric(horizontal: 3),
                  child: FilterChip(
                    labelPadding: const EdgeInsets.symmetric(
                      horizontal: 6,
                      vertical: 3,
                    ),
                    padding: EdgeInsets.zero,
                    label: Text(states[index]),
                    selected: isSelected,
                    onSelected: (_) {
                      FocusScope.of(context).unfocus();
                      filterNotifier.toggleStateSelection(states[index]);
                    },
                  ),
                );
              },
            ),
          ),
        ),
        const SizedBox(width: 6)
      ],
    );
  }
}
