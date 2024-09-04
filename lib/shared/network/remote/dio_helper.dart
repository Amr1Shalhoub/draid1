// ignore_for_file: avoid_print

import 'package:dio/dio.dart';

class DioHelper {
  static Dio dio = Dio();

  static init() {
    dio = Dio(
      BaseOptions(
         // baseUrl: 'http://localhost:3000/',
          baseUrl: 'http://91.108.113.143:3000/',


          receiveDataWhenStatusError: true,
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
          }),
    );
  }

  static Future<Response> getData({
    required String url,
    Map<String, dynamic>? query,
    String lang = 'en',
    String? token,
  }) async {
    dio.options.headers = {
      'lang': lang,
      'Authorization': 'Bearer $token',
    };
    try {
      final response = await dio.get(
        url,
        queryParameters: query,
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }

  static Future<Response> postData({
    required String url,
    required dynamic data,
    String lang = 'ar',
    String? token,
  }) async {
    dio.options.headers = {
      'lang': lang,
      'Authorization': 'Bearer $token',
    };
    return dio.post(
      url,
      data: data,
    );
  }

  static Future<Response> postFormData({
    required String url,
    required FormData formData,
    String lang = 'ar',
    String? token,
  }) async {
    dio.options.headers = {
      'lang': lang,
      'Authorization': 'Bearer $token',
    };
    return dio.post(
      url,
      data: formData,
    );
  }

  static Future<Response> signUpandLoginPostData({
    required String url,
    required Map<String, dynamic> data,
    String lang = 'en',
    String? token,
  }) async {
    dio.options.headers = {
      'Content-Type': 'application/json',
      'lang': lang,
      'Accept-Encoding': 'gzip, deflate, br',
      'Connection': 'keep-alive',
      'Authorization': 'Bearer $token',
    };

    return await dio.post(url, data: data);
  }

  static Future<Response> putData({
    required String url,
    required Map<String, dynamic> data,
    String lang = 'en',
    String? token,
  }) async {
    dio.options.headers = {
      'lang': lang,
      'Authorization': 'Bearer $token',
    };
    return dio.put(
      url,
      //queryParameters: query,
      data: data,
    );
  }

  static Future<Response> deleteData({
    required String url,
    dynamic data,
    String lang = 'ar',
    String? token,
  }) async {
    dio.options.headers = {
      'lang': lang,
      'Authorization': 'Bearer $token',
    };
    return dio.delete(
      url,
      data: data,
    );
  }
}
