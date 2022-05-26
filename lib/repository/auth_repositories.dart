import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:fluttter_authentication/constants/api_contants.dart';

class AuthRepositories {
  final FlutterSecureStorage storage = const FlutterSecureStorage();
  final Dio _dio = Dio();

  Future<bool> hasToken() async {
    var value = await storage.read(key: 'access_token');
    if (value != null) {
      return true;
    } else {
      return false;
    }
  }

  Future<String?> getStorageValue(String key) async {
    var value = await storage.read(key: key);
    return value;
  }

  Future<void> setStorageValue(String key, dynamic value) async {
    await storage.write(key: key, value: value);
  }

  Future<void> persistToken(String token) async {
    await storage.write(key: 'access_token', value: token);
  }

  Future<void> deleteToken() async {
    await storage.delete(key: 'access_token');
    await storage.deleteAll();
  }

  Future<String?> getToken() async {
    return await storage.read(key: 'access_token');
  }

  Future<String> login(String email, String password) async {
    try {
      Response response = await _dio.post('$baseURL/customer/login', data: {
        'email': email,
        'password': password,
      });
      if (response.statusCode == 200) {
        return response.data['data']['access_token'];
      } else {
        throw Exception('Failed to login');
      }
    } on DioError catch (e) {
      var error = e.response!.data['errors'];
      if (error['password'] != null) {
        throw error['password'];
      } else {
        throw error['email'];
      }
    } catch (exception) {
      rethrow;
    }
  }
}
