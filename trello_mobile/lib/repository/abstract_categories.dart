abstract class AbstractRepository<T> {
  Future<List<T>> get();
  Future create(T Z);
}
