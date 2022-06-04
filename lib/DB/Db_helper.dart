import 'package:sqflite/sqflite.dart';
import '../Class/task.dart';

class DBHelper{
  static Database? _db;
  static final int _version = 1;
  static final String _tableName = "taskmanager";
  static Future<void> initDb() async {
    if(_db != null){
      return;
  }
    try{
      String _path = await getDatabasesPath() + 'taskmanager.db';
      _db = await openDatabase(
      _path,
      version: _version,
      onCreate: (db,version){
        print("create db");
        return db.execute(
          "CREATE TABLE $_tableName("
            "id INTEGER PRIMARY KEY AUTOINCREMENT,"
            "title STRING,"
            "note TEXT,"
            "date STRING,"
            "startTime STRING,"
            "endTime STRING,"
            "color STRING,"
            "remind INTEGER,"
            "repeat STRING,"
            "isCompleted INTEGER)",
        );
      }
    );
  }
    catch(e){
      print(e);
    }
  }
  static Future<int> insert(Task? task) async{
    print("insert function named");
    return await _db?.insert(_tableName, task!.toJson())??1;
  }
  static Future<List<Map<String,dynamic>>> query() async{
    print("Query called");
    return await _db!.query(_tableName);
  }

}