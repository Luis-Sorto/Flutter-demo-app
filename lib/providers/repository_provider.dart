import 'package:demo_app/repository/person_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:demo_app/services/app_api.dart';

final appApiProvider = Provider<AppApi>((ref) {
  return AppApi();
});

final personRepositoryProvider = Provider<PersonRepository>((ref) {
  final appApi = ref.watch(appApiProvider);
  return PersonRepository(appApi: appApi);
});
