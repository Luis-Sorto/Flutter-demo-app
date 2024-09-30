import 'package:flutter_riverpod/flutter_riverpod.dart';

class FilterState {
  final String searchText;
  final Set<String> selectedStates;

  FilterState({
    this.searchText = '',
    this.selectedStates = const {},
  });

  FilterState copyWith({
    String? searchText,
    Set<String>? selectedStates,
  }) {
    return FilterState(
      searchText: searchText ?? this.searchText,
      selectedStates: selectedStates ?? this.selectedStates,
    );
  }
}

class FilterNotifier extends StateNotifier<FilterState> {
  FilterNotifier() : super(FilterState());

  void setSearchText(String text) {
    state = state.copyWith(searchText: text);
  }

  void toggleStateSelection(String stateName) {
    final newSelectedStates = Set<String>.from(state.selectedStates);
    if (newSelectedStates.contains(stateName)) {
      newSelectedStates.remove(stateName);
    } else {
      newSelectedStates.add(stateName);
    }
    state = state.copyWith(selectedStates: newSelectedStates);
  }

  void clearSelections() {
    state = state.copyWith(selectedStates: {});
  }

  void clearAllFilters() {
    state = FilterState();
  }
}

final filterProvider =
    StateNotifierProvider<FilterNotifier, FilterState>((ref) {
  return FilterNotifier();
});
