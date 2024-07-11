import 'package:dio/dio.dart';

class ApiServices {
  final Dio dio;
  final String baseUrl = 'https://www.googleapis.com/books/v1/';

  ApiServices(this.dio);

  Future<Map<String, dynamic>> get({required endpoint}) async {
    var response = await dio.get('$baseUrl$endpoint');

    return response.data;
  }
}
