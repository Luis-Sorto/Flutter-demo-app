import 'package:demo_app/providers/repository_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:demo_app/models/person.dart';

final peopleProvider = FutureProvider<List<Person>>((ref) async {
  final repository = ref.watch(personRepositoryProvider);
  return repository.getPeople();
});
