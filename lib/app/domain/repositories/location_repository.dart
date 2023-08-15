import '../../data/datasource/Location.dart';

abstract class LocationRepository {
  Future<List<Map<String, Object?>>> allLocation();
  Future<Locations> insertTodo(final Locations todoEntity);
  Future<void> updateTodo(final Locations todoEntity);
  Future<void> deleteTodo(final int id);
}