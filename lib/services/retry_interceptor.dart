import 'dart:math';

import 'package:dio/dio.dart';
import 'package:dio_smart_retry/dio_smart_retry.dart';

class RetryUtil {
  /// Basic interceptor that will retry the request in case
  /// the default status codes are return
  /// https://pub.dev/packages/dio_smart_retry#default-retryable-status-codes-list
  static RetryInterceptor retryInterceptor({
    required Dio dio,
    int retries = 3,
    int baseDelay = 150,
    int maxJitter = 300,
    void Function(String message)? logPrint,
  }) {
    final retryDelays = <Duration>[];

    for (var retryNumber = 1; retryNumber <= retries; retryNumber++) {
      retryDelays.add(
        Duration(
          milliseconds: (baseDelay * pow(2, retryNumber - 1) +
                  Random().nextInt(maxJitter))
              .toInt(),
        ),
      );
    }
    return RetryInterceptor(
      dio: dio,
      retries: retries,
      retryDelays: retryDelays,
      logPrint: logPrint,
    );
  }
}
