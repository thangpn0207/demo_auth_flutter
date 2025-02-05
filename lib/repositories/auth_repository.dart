import 'package:dio/dio.dart';

class AuthRepository {
  final _dio = Dio(BaseOptions(
    baseUrl: 'http://192.168.50.139:8080/api',
    contentType: 'application/json',
  ));

  Future<String> login(String email, String password) async {
    try {
      final response = await _dio.post('/auth/login', data: {
        'email': email,
        'password': password,
      });
      return response.data['token'];
    } catch (e) {
      throw _handleError(e);
    }
  }

  Future<String> signUp(String email, String password, String name) async {
    try {
      final response = await _dio.post('/auth/register', data: {
        'email': email,
        'password': password,
        'name': name,
      });
      return response.data['token'];
    } catch (e) {
      throw _handleError(e);
    }
  }

  String _handleError(dynamic error) {
    if (error is DioException) {
      if (error.response?.data?['message'] != null) {
        return error.response?.data['message'];
      }
      return 'Network error occurred';
    }
    return 'An unexpected error occurred';
  }
}
