import 'package:demo_app/providers/filter_provider.dart';
import 'package:demo_app/widgets/clear_button.dart';
import 'package:demo_app/widgets/search_input.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class DropdownMenuFilter extends HookConsumerWidget {
  const DropdownMenuFilter({super.key, required this.states});

  final List<String> states;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final layerLink = useMemoized(() => LayerLink());
    final filterNotifier = ref.read(filterProvider.notifier);

    void checkState(String value) {
      final actualIndex = states.indexOf(value);
      filterNotifier.toggleStateSelection(states[actualIndex]);
    }

    return CompositedTransformTarget(
      link: layerLink,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 6),
        height: 45,
        child: ElevatedButton(
          onPressed: () async {
            await showDialog(
              barrierDismissible: true,
              barrierColor: Colors.transparent,
              context: context,
              builder: (context) {
                return HookConsumer(builder: (context, ref, _) {
                  final updatedFilter = ref.watch(filterProvider);
                  final stateSearch = useState<List<String>>(states);

                  void onSearch(String value) {
                    stateSearch.value = states
                        .where((state) =>
                            state.toLowerCase().contains(value.toLowerCase()))
                        .toList();
                  }

                  return Stack(children: [
                    CompositedTransformFollower(
                      link: layerLink,
                      offset: const Offset(6, 50),
                      child: Material(
                        child: Container(
                          padding: const EdgeInsets.all(12),
                          width: MediaQuery.of(context).size.width / 1.5,
                          height: 400,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(6),
                            border: Border.all(color: Colors.grey),
                            color: Colors.white,
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Row(children: [
                                Expanded(
                                  child: SearchInput(
                                    onChanged: onSearch,
                                  ),
                                ),
                                ClearButton(
                                  onPressed: filterNotifier.clearSelections,
                                ),
                              ]),
                              Expanded(
                                child: ListView.builder(
                                  scrollDirection: Axis.vertical,
                                  itemCount: stateSearch.value.length,
                                  itemBuilder: (_, index) {
                                    final isSelected = updatedFilter
                                        .selectedStates
                                        .contains(stateSearch.value[index]);
                                    return Padding(
                                      padding: const EdgeInsets.only(
                                        left: 6,
                                        top: 6,
                                      ),
                                      child: Row(
                                        children: [
                                          Checkbox(
                                              value: isSelected,
                                              onChanged: (_) {
                                                FocusScope.of(context)
                                                    .unfocus();
                                                checkState(
                                                  stateSearch.value[index],
                                                );
                                              }),
                                          Text(stateSearch.value[index])
                                        ],
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ]);
                });
              },
            );
            if (context.mounted) {
              FocusScope.of(context).unfocus();
            }
          },
          child: const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Select states'),
              Icon(Icons.arrow_drop_down),
            ],
          ),
        ),
      ),
    );
  }
}
