abstract class GameStorage {
  Future<void> save(String key, dynamic value);
  Future<T?> load<T>(String key);
  Future<void> update(String key, dynamic value);
  Future<void> delete(String key);
}
