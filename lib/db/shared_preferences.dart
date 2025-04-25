import 'package:flappy_dash_ce/core/game_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferences extends GameStorage {
  final Future<SharedPreferencesWithCache> _prefs = SharedPreferencesWithCache.create(
    cacheOptions: const SharedPreferencesWithCacheOptions(
      allowList: <String>{'bestScore'},
    ),
  );

  @override
  Future<void> save(String key, value) async {
    final SharedPreferencesWithCache prefs = await _prefs;
    //TODO: Support for others types
    await prefs.setInt(key, value);
  }

  @override
  Future<T?> load<T>(String key) async {
    final SharedPreferencesWithCache prefs = await _prefs;
    //TODO: Support for others types
    dynamic result = prefs.getInt(key);
    return result as T?;
  }

  @override
  Future<void> update(String key, value) async {
    final SharedPreferencesWithCache prefs = await _prefs;
    //TODO: Support for others types
    await prefs.setInt(key, value);
  }

  @override
  Future<void> delete(String key) async {
    final SharedPreferencesWithCache prefs = await _prefs;
    await prefs.remove(key);
  }
}
