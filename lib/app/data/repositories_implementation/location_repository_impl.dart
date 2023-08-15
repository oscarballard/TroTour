// import 'package:path/path.dart';
// import 'package:sqflite/sqflite.dart';

// import '../../domain/models/location.dart';
// import '../../domain/repositories/Location_repository.dart';

// class LocationRepositoryImpl implements LocationRepository {
//   static const _databaseName = 'locationDB';
//   static const _tableName = 'location';
//   static const _databaseVersion = 1;
//   static const _columnId = 'id';
//   static const _columnTitle = 'title';
//   static const _columnLat = 'lat';
//   static const _columnLng = 'lng';
//   static const _columnDescription = 'description';
//   static const _columnImg = 'img';
//   static const _columnDate = 'date';
//   static Database? _database;

//   Future<Database> get database async {
//     _database ??= await _initDatabase();
//     return _database!;
//   }

//   @override
//   Future<List<Map<String, Object?>>> allLocation() async {
//     final db = await database;
//     return db.query(_tableName);
//   }

//   @override
//   Future<void> deleteTodo(int id) {
//     // TODO: implement deleteTodo
//     throw UnimplementedError();
//   }

//   @override
//   Future< insertTodo(final Location todo) async {
//     final db = await database;
//     late final Location todoEntity;
//     await db.transaction((txn) async {
//       final id = await txn.insert(
//         _tableName,
//         todo,
//         conflictAlgorithm: ConflictAlgorithm.replace,
//       );
//       final results = await txn.query(_tableName, where: '$_columnId = ?', whereArgs: [id]);
//       todoEntity = results.first;
//     });
//     return todoEntity;
//   }

//   @override
//   Future<void> updateTodo(Location todoEntity) {
//     // TODO: implement updateTodo
//     throw UnimplementedError();
//   }

//     Future<Database> _initDatabase() async {
//     return openDatabase(
//       join(await getDatabasesPath(), _databaseName),
//       onCreate: (db, _) {
//         db.execute('''
//           CREATE TABLE $_tableName(
//             $_columnId INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
//             $_columnTitle TEXT NOT NULL,
//             $_columnDescription TEXT,
//             $_columnLat TEXT,
//             $_columnLng TEXT,
//             $_columnImg TEXT,
//             $_columnDate TEXT NOT NULL
//           )
//         ''');
//       },
//       version: _databaseVersion,
//     );
//   }
// }