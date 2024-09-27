import 'dart:developer';
import 'dart:io';

import 'package:demo_app/services/retry_interceptor.dart';
import 'package:dio/dio.dart';

class AppApi {
  final Dio _dio;
  static const baseUrl = "https://splendid-frangipane-cfd768.netlify.app";

  AppApi([
    Dio? dio,
  ]) : _dio = dio ??
            Dio(BaseOptions(
              baseUrl: baseUrl,
              connectTimeout: const Duration(seconds: 5),
              receiveTimeout: const Duration(seconds: 3),
            )) {
    _dio.interceptors.add(
      RetryUtil.retryInterceptor(dio: _dio),
    );
  }

  /// Requests people data
  Future<List<dynamic>> fetchPeople() async {
    const path = "/people_10000.json";

    final options = Options(contentType: "application/json");

    try {
      final response = await _dio.get(path, options: options);

      if (response.statusCode == 200) {
        List<dynamic> data = response.data;
        // TODO add model to parse the response

        return data;
      } else {
        throw Exception('Failed to load data: ${response.statusCode}');
      }
    } on DioException catch (e) {
      throw Exception('Dio error: $e');
    } catch (e) {
      throw Exception('Unexpected error: $e');
    }
  }

  /// Quick check that the server is up
  Future<bool> health() async {
    try {
      final response = await _dio.get('');
      return response.statusCode == HttpStatus.ok;
    } on DioException catch (e) {
      log('Dio error: $e');
      return false;
    } catch (e) {
      log('Unexpected error: $e');
      return false;
    }
  }
}
