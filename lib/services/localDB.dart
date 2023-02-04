import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class SqliteService {
  static Future<Database> initializeDB() async {
    String path = await getDatabasesPath();

    return openDatabase(
      join(path, 'database.db'),
      onCreate: (database, version) async {
        await database.execute(
          'CREATE TABLE routes(id INTEGER PRIMARY KEY, startLatitude TEXT, startLongitude TEXT, endLatitude TEXT, endLongitude TEXT, startLocationText TEXT, endLocationText TEXT, weight INTEGER)',
        );
      },
      version: 2,
    );
  }

  static void deleteDB() async {
    // Get a location using getDatabasesPath
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'database.db');

    await deleteDatabase(path);
  }
}
