import 'package:sqflite/sqflite.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:path/path.dart';

class DB {
  Database? db;
  Future open() async {
    sqfliteFfiInit();
    var databasePath = await databaseFactoryFfi.getDatabasesPath();
    String path = join(databasePath, 'items.dart');
    DatabaseFactory databaseFactory = databaseFactoryFfi;
    print(path);

    db = await databaseFactory.openDatabase(path,
        options: OpenDatabaseOptions(
            version: 1,
            onCreate: (Database db, int index) async {
              await db.execute('''
                  CREATE TABLE items(
                    id integer primary key autoIncrement,
                    image varchar(255) not null,
                    name varchar(255) not null,
                    price int not null,
                    count int not null
                  );
                ''');
            }));
  }
}
