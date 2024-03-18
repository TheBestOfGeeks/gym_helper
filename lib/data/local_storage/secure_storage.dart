import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:gym_helper/data/local_storage/local_storage_interface.dart';

class SecureStorage implements ILocalStorage {
  static AndroidOptions _getAndroidOptions() => const AndroidOptions(
        encryptedSharedPreferences: true,
      );

  final storage = FlutterSecureStorage(aOptions: _getAndroidOptions());

  @override
  Future<void> deleteAll() async {
    await storage.deleteAll();
  }

  @override
  Future<void> deleteData(String key) async {
    await storage.delete(key: key);
  }

  @override
  Future<T?> getData<T>(String key) async {
    assert(T == String,
        'T must be String, because SecureStorage supports String only');
    final value = storage.read(key: key) as Future<T?>;

    return value;
  }

  @override
  Future<void> setData<T>(String key, T value) async {
    assert(T == String,
        'T must be String, because SecureStorage supports String only');
    await storage.write(key: key, value: value as String);
  }
}
