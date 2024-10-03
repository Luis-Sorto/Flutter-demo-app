import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:demo_app/providers/connectivity_provider.dart';
import 'package:demo_app/providers/repository_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:demo_app/models/person.dart';

final peopleProvider = FutureProvider<List<Person>>((ref) async {
  final connectivity = ref.watch(connectivityResultProvider).value;
  if (connectivity?.contains(ConnectivityResult.none) ?? false) {
    throw Exception('No internet connection');
  }
  final repository = ref.watch(personRepositoryProvider);
  final peopleAsync = await repository.getPeople();

  return peopleAsync;
});

final storedPeopleProvider =
    Provider((ref) => ref.watch(peopleProvider).value ?? []);
