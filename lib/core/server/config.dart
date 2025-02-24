import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:retry/retry.dart';

class ConfigApi {
  final Dio _dio;
  final r = const RetryOptions(maxAttempts: 8);
  final baseUrl = "https://www.googleapis.com/books/v1/";

  ConfigApi(this._dio);

  Future<Map<String, dynamic>> get({required String completeUrl}) async {
    var response = await r.retry(
        () => _dio
            .get('$baseUrl$completeUrl')
            .timeout(const Duration(seconds: 20)),
        retryIf: (e) => e is SocketException || e is TimeoutException);
    return response.data;
  }
}
