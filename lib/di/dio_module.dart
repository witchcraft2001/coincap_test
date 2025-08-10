import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

@module
abstract class RegisterModule {
  static const _apiKey = String.fromEnvironment('COINCAP_API_KEY');

  @lazySingleton
  Dio dio() => Dio(BaseOptions(
    baseUrl: 'https://rest.coincap.io',
    headers: {
      'Authorization': 'Bearer $_apiKey',
      'accept': 'application/json',
    },
    connectTimeout: const Duration(seconds: 10),
    receiveTimeout: const Duration(seconds: 20),
    responseType: ResponseType.json,
  ))
    ..interceptors.add(LogInterceptor(
      requestBody: false,
      responseBody: false,
      requestHeader: false,
      responseHeader: false,
    ));
}