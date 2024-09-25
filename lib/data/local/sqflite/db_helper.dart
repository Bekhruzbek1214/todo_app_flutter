import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:todo_app/data/model/todo_data.dart';


class MyDatabaseHelper {
  static int version = 1;
  static String dbName = 'Todo.db' ;

  Future<Database> _getDatabase() async {
    return await openDatabase(join(await getDatabasesPath(), dbName),
    version: version,
    singleInstance:  true,
    onCreate: (db, version) async => db.execute(
      'CREATE TABLE TodoData (id INTEGER NOT NULL, name TEXT NOT NULL, date TEXT NOT NULL, category TEXT NOT NULL, importance TEXT NOT NULL, set_alarm TEXT NOT NULL, color TEXT NOT NULL)'
    ));
  }

  Future<void> addTodoData(TodoData todoData) async{
      final db = await _getDatabase();
      db.insert('TodoData', todoData.toJson());
  }

  Future<TodoData?> getTodoData(int id) async {
    final db = await _getDatabase();
    final List<Map<String, dynamic>> map =
        await db.query('TodoData', where: 'id = ?', whereArgs: [id]);
    if(map.isNotEmpty){
      return TodoData.fromJson(map.first);
    }
    return null;
  }

  void updateTodoData(TodoData todoData) async {
    final db = await _getDatabase();
    db.update('TodoData', todoData.toJson(), where: 'id = ?', whereArgs: [todoData.id]);
  }

  void deleteTodoData(int id) async {
    final db = await _getDatabase();
    db.delete('TodoData', where: 'id = ?', whereArgs: [id]);
  }

  Future<List<TodoData>> getAllTodoData() async {
    final db = await _getDatabase();
    final map = await db.query('TodoData');

    return List.generate(map.length, (index) => TodoData.fromJson(map[index]));
  }


}

























