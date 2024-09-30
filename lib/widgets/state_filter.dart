import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:demo_app/providers/filter_provider.dart';

class StateFilter extends ConsumerWidget {
  final List<String> states;

  const StateFilter({super.key, required this.states});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final filter = ref.watch(filterProvider);
    final filterNotifier = ref.read(filterProvider.notifier);

    return states.isEmpty
        ? const Center(
            child: Padding(
              padding: EdgeInsets.all(6),
              child: CircularProgressIndicator(),
            ),
          )
        : Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(6),
                      child: TextField(
                        decoration: const InputDecoration(
                          labelText: 'Search by name',
                          prefixIcon: Icon(Icons.search),
                          border: OutlineInputBorder(),
                        ),
                        style: const TextStyle(fontSize: 16, height: 0.8),
                        onChanged: (value) {
                          filterNotifier.setSearchText(value);
                        },
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 10),
                    child: IconButton(
                      icon: const Icon(
                        Icons.delete,
                        color: Colors.grey,
                      ),
                      onPressed: filterNotifier.clearAllFilters,
                    ),
                  )
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: SizedBox(
                      height: 50,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: states.length,
                        itemBuilder: (_, index) {
                          final isSelected =
                              filter.selectedStates.contains(states[index]);
                          return Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 4),
                            child: FilterChip(
                              label: Text(states[index]),
                              selected: isSelected,
                              onSelected: (_) {
                                filterNotifier
                                    .toggleStateSelection(states[index]);
                              },
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ],
          );
  }
}
