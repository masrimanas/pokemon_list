extension StreamListExtension<T, K> on Stream<List<T>> {
  // ignore: avoid_shadowing_type_parameters
  Stream<List<K>> mapList<K>(K Function(T) mapper) {
    return map((list) => list.map(mapper).toList());
  }
}
