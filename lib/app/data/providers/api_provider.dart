import 'package:dio/dio.dart';

class ApiProvider {
  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: 'https://auth-service-c5w5.onrender.com',
      connectTimeout: Duration(seconds: 10),
      receiveTimeout: Duration(seconds: 10),
      headers: {'Content-Type': 'application/json'},
    ),
  );

  Dio get dio => _dio;
}
