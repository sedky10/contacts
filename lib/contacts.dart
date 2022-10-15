import 'package:contacts/details.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

final String ColumnId = 'id';
final String ColumnFirst = 'first_name';
final String ColumnLast = 'last_name';
final String ColumnNumber = 'number';
final String ColumnUrl = 'url';
final String ColumntableTodo = 'table_todo';

class Contacts {
  late Database db;
  static final Contacts instance = Contacts._internal();

  factory Contacts() {
    return instance;
  }

  Contacts._internal();

  Future open() async {
    db = await openDatabase(
      join(
        await getDatabasesPath(),
        'todo.db',
      ),
      version: 1,
      onCreate: (Database db, int version) async {
        await db.execute('''
create table $ColumntableTodo (
  $ColumnId integer primary key autoincrement,
  $ColumnFirst text not null,
  $ColumnLast text not null,
  $ColumnUrl text not null,
  $ColumnNumber integer not null)
''');
      },
    );
  }

  Future<Details> insert(Details contact) async {
    contact.id = await db.insert(ColumntableTodo, contact.tomap());
    return contact;
  }

  Future<int> delete(int id) async {
    return await db
        .delete(ColumntableTodo, where: '$ColumnId=?', whereArgs: [id]);
  }

  Future<int> update(Details todo) async {
    return await db.update(ColumntableTodo, todo.tomap(),
        where: '$ColumnId = ?', whereArgs: [todo.id]);
  }

  Future<List<Details>> getAll() async {
    List<Map<String, dynamic>> todoMaps = await db.query(ColumntableTodo);
    if (todoMaps.length == 0) {
      return [];
    } else {
      List<Details> todos = [];
      todoMaps.forEach(
        (element) {
          todos.add(Details.FromMap(element));
        },
      );
      return todos;
    }
  }

  Future close() async => db.close();
}
