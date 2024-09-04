import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class FlutterSecure {
  static late FlutterSecureStorage secureStorage;

  static Future<void> init() async {
    secureStorage = FlutterSecureStorage();
  }

  static Future<void> putData({
    required String key,
    required bool value,
  }) async {
    await secureStorage.write(key: key, value: value.toString());
  }

  static Future<String?> getData({
    required String key,
  }) async {
    return await secureStorage.read(key: key);
  }

  static Future<void> saveData({
    required String key,
    required dynamic value,
  }) async {
    if (value is String || value is int || value is bool || value is double) {
      await secureStorage.write(key: key, value: value.toString());
    }
  }

  static Future<void> removeData({
    required String key,
  }) async {
    await secureStorage.delete(key: key);
  }
}