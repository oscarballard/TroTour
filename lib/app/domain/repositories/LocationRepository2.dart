// // import 'package:clean_architecture_todo_app/domain/model/todo.dart';
// // import 'package:clean_architecture_todo_app/domain/model/todo_id.dart';
// // import 'package:clean_architecture_todo_app/domain/model/todo_list.dart';

// import '../models/location.dart';

// abstract class LocationsRepository {
//   Future<List<Location>> getLocationList();
//   Future<Location> createLocation(
//     final String title,
//     final String description,
//     final bool isCompleted,
//     final DateTime dueDate,
//   );
//   Future<void> updateLocation(
//     final int id,
//     final String title,
//     final String description,
//     final bool isCompleted,
//     final DateTime dueDate,
//   );
//   Future<void> deleteLocation(final int id);
// }