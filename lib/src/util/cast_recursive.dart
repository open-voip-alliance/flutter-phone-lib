extension CastRecursive on Map {
  Map<String, dynamic> castRecursively([List<Map>? cache]) {
    // The cache is used to keep track of references to maps that have
    // already been cast. This is to prevent stack overflows.
    cache ??= [];

    cache.add(this);

    for (final key in keys) {
      if (this[key] is Map && !cache.any((m) => identical(m, this[key]))) {
        this[key] = (this[key] as Map).castRecursively(cache);
      }
    }

    return cast<String, dynamic>();
  }
}
