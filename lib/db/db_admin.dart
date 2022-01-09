import 'dart:io';

import 'package:flutter_codigo4_sqflite_1/models/book.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DBAdmin {
  Database? _myBookDataBase;

  static final DBAdmin db = DBAdmin._();
  DBAdmin._();

  Future<Database?> getDatabase() async {
    if (_myBookDataBase != null) return _myBookDataBase;
    _myBookDataBase = await initDB();
    return _myBookDataBase;
  }

  Future<Database> initDB() async {
    Directory documentDirectory = await getApplicationDocumentsDirectory();
    final path = join(documentDirectory.path, "BookDB.db");
    return await openDatabase(
      path,
      version: 1,
      onOpen: (db) {},
      onCreate: (Database db, int version) async {
        await db.execute("CREATE TABLE BOOK("
            "id INTEGER PRIMARY KEY AUTOINCREMENT, "
            "title TEXT, "
            "author TEXT, "
            "description TEXT, "
            "image TEXT, "
            "favourite TEXT);");
      },
    );
  }

  //Listar Libros
  Future<List> getBooksRaw() async {
    final db = await getDatabase();
    List<Map<String, dynamic>> res = await db!.rawQuery("SELECT * FROM BOOK");
    print(res);
    return res;
  }

  Future<List<Book>> getBooks() async {
    final db = await getDatabase();
    List<Map<String, dynamic>> res = await db!.query("BOOK");
    List<Book> books = res.map<Book>((item) => Book.fromJson(item)).toList();
    print(books);
    return books;
  }



  Future<List<Book>> getBooksFavourites() async {
    final db = await getDatabase();
    List<Map<String, dynamic>> res = await db!.query("BOOK", where: "favourite = 'true'");
    List<Book> books = res.map<Book>((item) => Book.fromJson(item)).toList();
    print(books);
    return books;
  }

  //Insertar

  Future<int> insertBookRaw(Book book) async {
    final db = await getDatabase();
    int res =  await db!.rawInsert(
        "INSERT INTO BOOK(title, author, description, image, favourite) VALUES ('${book.title}','${book.author}', '${book.description}','${book.image}','${book.favourite}')");
    return res;
  }

  Future<int> insertBook(Book book) async {
    final db = await getDatabase();
    int res = await db!.insert(
      "BOOK",
      book.toJson(),
    );
    return res;
  }

  Future<int> updateStateBook(Book book) async {
    final db = await getDatabase();
    int updateCount = await db!.update(
        "BOOK",
        {'favourite': 'false'},
        where: 'id = ?',
        whereArgs: [book.id]);
    return updateCount;
  }

  Future<int> updateBook(Book book) async {
    final db = await getDatabase();
    int result = await db!.update(
      'BOOK',
      book.toJson(),
      where: "id = ?",
      whereArgs: [book.id],
    );
    return result;
  }

  Future<int> updateIsNotFavouriteBook(int? id) async {
    final db = await getDatabase();
    int result = await db!.update(
      'BOOK',
      {'favourite': 'false'},
      where: "id = ?",
      whereArgs: [id],
    );
    return result;
  }

  Future<int> updateIsFavouriteBook(int? id) async {
    final db = await getDatabase();
    int result = await db!.update(
      'BOOK',
      {'favourite': 'true'},
      where: "id = ?",
      whereArgs: [id],
    );
    return result;
  }

  Future<void> deleteBook(int? id) async {
    final db = await getDatabase();
    await db!.delete(
      'BOOK',
      where: "id = ?",
      whereArgs: [id],
    );
  }



 /* insertBook(Book book) async {
    final db = await getDatabase();
    int res = await db!.insert(
      "BOOK",
      book.toJson()
      /*{
        "title": book.title,
        "author": book.author,
        "description": book.description,
        "image": book.image,
        "favourite": book.favourite,
      }*/
      ,
    );
    print(res);
  }*/
}
