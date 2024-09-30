import 'package:demo_app/providers/filter_provider.dart';
import 'package:demo_app/providers/person_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:demo_app/models/person.dart';

final filteredPeopleProvider = Provider<List<Person>>((ref) {
  final peopleAsync = ref.watch(peopleProvider);
  final filter = ref.watch(filterProvider);

  return peopleAsync.when(
    data: (people) {
      return people.where((person) {
        final matchesSearch = person.name
            ?.toLowerCase()
            .contains(filter.searchText.toLowerCase());
        final matchesState = filter.selectedStates.isEmpty ||
            filter.selectedStates.contains(person.state);

        if (matchesSearch == null) return false;
        return matchesSearch && matchesState;
      }).toList();
    },
    loading: () => [],
    error: (_, __) => [],
  );
});
