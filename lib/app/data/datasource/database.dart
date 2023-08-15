import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import 'Location.dart';

class LocationDatabase {

  LocationDatabase._init();
  static LocationDatabase instance = LocationDatabase._init();

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initBD("location.db");
    return _database!;
  }

  Future<Database> _initBD(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);
    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    const idType = "INTEGER PRIMARY KEY AUTOINCREMENT";
    const stringType = "Text not null";
    const double = "REAL not null";

    await db.execute('''
    CREATE TABLE $tableLocations(
      ${LocationField.id} $idType,
      ${LocationField.title} $stringType,
      ${LocationField.descripcion} $stringType,
      ${LocationField.lng} $double,
      ${LocationField.lat} $double,
      ${LocationField.pathImage} $stringType
    )
''');
  }

  Future<Locations> create(Locations location) async {
    final db = await _initBD("location.db");
    final id = await db.insert(tableLocations, location.toJson());
    return location.copy(id: id);
  }

  Future<List<Locations>> readAll() async {
    final db = await _initBD("location.db");
    final result = await db.rawQuery("SELECT * FROM $tableLocations");
    List<Locations> data = []; // Inicializa una lista vacía para almacenar los resultados
    data = result.map((json) {
      return Locations.fromJson(json);
    }).toList();
    return data;
  }
}
