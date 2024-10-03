import 'package:demo_app/providers/filter_provider.dart';
import 'package:demo_app/providers/person_repository_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:demo_app/models/person.dart';

final filteredPeopleProvider = Provider<List<Person>>((ref) {
  final people = ref.watch(storedPeopleProvider);
  final filter = ref.watch(filterProvider);

  return people.where((person) {
    final matchesSearch =
        person.name?.toLowerCase().contains(filter.searchText.toLowerCase());
    final matchesState = filter.selectedStates.isEmpty ||
        filter.selectedStates.contains(person.state);

    if (matchesSearch == null) return false;
    return matchesSearch && matchesState;
  }).toList();
});

final uniqueStatesProvider = StateProvider<List<String>>((ref) {
  final people = ref.watch(storedPeopleProvider);

  return people.map((p) => p.state).whereType<String>().toSet().toList()
    ..sort();
});
