abstract interface class ILocalStorage {
  Future<T?> getData<T>(String key);

  Future<void> setData<T>(String key, T value);

  Future<void> deleteData(String key);

  Future<void> deleteAll();
}
