import 'package:demo_app/providers/filter_provider.dart';
import 'package:demo_app/theme/app_theme.dart';
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
    final selectedStates = ref.watch(filterProvider).selectedStates;

    states.sort((a, b) {
      bool isASelected = selectedStates.contains(a);
      bool isBSelected = selectedStates.contains(b);

      if (isASelected && !isBSelected) return -1;
      if (!isASelected && isBSelected) return 1;
      return a.compareTo(b);
    });

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
                    avatar: isSelected
                        ? const Icon(
                            Icons.check,
                            color: Colors.white,
                            size: 20,
                          )
                        : null,
                    label: Text(states[index]),
                    labelStyle: TextStyle(
                      color: isSelected ? null : AppTheme.secondaryColor,
                    ),
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
