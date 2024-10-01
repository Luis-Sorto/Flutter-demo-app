import 'package:demo_app/providers/ui_state_provider.dart';
import 'package:demo_app/widgets/chip_list_filter.dart';
import 'package:demo_app/widgets/dropdown_filter.dart';
import 'package:demo_app/widgets/filter_type_toggle.dart';
import 'package:demo_app/widgets/search_input.dart';
import 'package:flutter/material.dart';
import 'package:demo_app/providers/filter_provider.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class StateFilter extends ConsumerWidget {
  final List<String> states;

  const StateFilter({super.key, required this.states});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final filterNotifier = ref.read(filterProvider.notifier);
    final filterType = ref.watch(selectedOptionProvider);

    final showDropdown = filterType == FilterType.dropdown;

    if (states.isEmpty) {
      return const Center(
        child: Padding(
          padding: EdgeInsets.all(6),
          child: CircularProgressIndicator(),
        ),
      );
    } else {
      return Padding(
        padding: const EdgeInsets.all(3),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: SearchInput(
                    placeholder: 'Search by name',
                    onChanged: filterNotifier.setSearchText,
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const FilterTypeToggle(),
                showDropdown
                    ? Expanded(
                        child: DropdownMenuFilter(states: states),
                      )
                    : Expanded(
                        child: ChipListFilter(states: states),
                      ),
              ],
            ),
          ],
        ),
      );
    }
  }
}

enum FilterType { chips, dropdown }
