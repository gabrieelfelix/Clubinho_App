class CacheClient {
  // CacheClient() : _cache = <String, Object>{};

  // Singleton instance
  static final CacheClient _instance = CacheClient._();

  CacheClient._() : _cache = <String, Object>{};

  final Map<String, Object> _cache;

  /// Writes the provide [key], [value] pair to the in-memory cache.
  static void write<T extends Object>({required String key, required T value}) {
    _instance._cache[key] = value;
  }

  /// Looks up the value for the provided [key].
  /// Defaults to `null` if no value exists for the provided key.
  static T? read<T extends Object>({required String key}) {
    final value = _instance._cache[key];
    if (value is T) return value;
    return null;
  }
}
// _cache.write(key: userCacheKey, value: user);
// _cache.read<User>(key: userCacheKey) ?? User.empty;