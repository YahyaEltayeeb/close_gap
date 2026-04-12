import 'dart:io';

import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:injectable/injectable.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../di/di.dart';
import '../services/token_interceptor.dart';
import 'network_constants.dart';

@module
abstract class ExternalModules {
  @lazySingleton
Dio provideDio(TokenInterceptor tokenInterceptor, PrettyDioLogger prettyDioLogger) {
  Dio dio = Dio();

  dio.options.baseUrl = NetworkConstants.baseUrl;
   dio.options.connectTimeout = const Duration(seconds: 30);
  dio.options.receiveTimeout = const Duration(seconds: 30);

  
  (dio.httpClientAdapter as IOHttpClientAdapter).createHttpClient = () {
    final client = HttpClient();
    client.badCertificateCallback = (cert, host, port) => true;
    return client;
  };

  dio.interceptors.add(prettyDioLogger);
  dio.interceptors.add(tokenInterceptor);

  return dio;
}

@lazySingleton
PrettyDioLogger providePrettyDioLogger() {
  return PrettyDioLogger(
    requestHeader: true,
    requestBody: true,
    responseBody: true,
    responseHeader: false,
    error: true,
    compact: true,
  );
}

  @preResolve
  Future<SharedPreferences> get provideSharedPreferences async {
    return await SharedPreferences.getInstance();
  }

  @lazySingleton
  FlutterSecureStorage flutterSecureStorage() {
    return const FlutterSecureStorage();
  }

  @lazySingleton
  InternetConnectionChecker provideInternetConnectionChecker() =>
      InternetConnectionChecker.instance;
}
