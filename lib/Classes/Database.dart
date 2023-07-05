import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

Future<Database> getDatabase() async {
  // Future<void> deleteDatabaseFile() async {
  //   final String path = join(await getDatabasesPath(), 'iMap_database.db');
  //   await deleteDatabase(path);
  // }

  // deleteDatabaseFile();

  return await openDatabase(
    join(await getDatabasesPath(), 'iMap_database.db'),
    onCreate: (db, version) {
      return db.execute(
        'CREATE TABLE loc(id INTEGER PRIMARY KEY, lat REAL, lng REAL)',
      );
    },
    version: 1,
  );
}
