import 'package:demo_app/models/person.dart';
import 'package:demo_app/services/app_api.dart';
import 'package:dio/dio.dart';

class PersonRepository {
  final AppApi appApi;

  PersonRepository({required this.appApi});

  /// Handles the data retrival
  Future<List<Person>> getPeople() async {
    try {
      final response = await appApi.fetchPeople();

      List<Person> people =
          response.map((json) => Person.fromJson(json)).toList();

      return people;
    } on DioException catch (e) {
      throw Exception('Failed to fetch people: $e');
    } catch (e) {
      throw Exception('Unexpected error: $e');
    }
  }
}
