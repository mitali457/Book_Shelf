import 'package:bookshelf/domain/entities/books.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static Future<Database> _openDb() async {
    final databasePath = await getDatabasesPath();
    final path = join(databasePath, 'bookshelf.db');

    return openDatabase(
      path,
      onCreate: (db, version) {
        db.execute(
          'CREATE TABLE books(id INTEGER PRIMARY KEY AUTOINCREMENT, title TEXT, publisher TEXT, handle TEXT, year INTEGER, isbn TEXT, pages INTEGER, notes TEXT, createdAt TEXT)',
        );

        db.execute(
          'CREATE TABLE villains(id INTEGER PRIMARY KEY AUTOINCREMENT, bookId INTEGER, name TEXT, url TEXT, FOREIGN KEY(bookId) REFERENCES books(id) ON DELETE CASCADE)',
        );
      },
      version: 1,
    );
  }

  static Future<void> insertBook(Book book) async {
    final db = await _openDb();
    await db.insert('books', book.toMap(), conflictAlgorithm: ConflictAlgorithm.replace);

    if (book.villains != null) {
      for (var villain in book.villains!) {
        await db.insert('villains', {
          'bookId': book.id,
          'name': villain.name,
          'url': villain.url,
        });
      }
    }
  }

  static Future<List<Book>> getBooks() async {
    final db = await _openDb();
    final List<Map<String, dynamic>> booksData = await db.query('books');

    final books = List.generate(booksData.length, (i) {
      return Book.fromMap(booksData[i]);
    });

    return books;
  }

  static Future<void> updateBook(Book book) async {
    final db = await _openDb();
    await db.update(
      'books',
      book.toMap(),
      where: "id = ?",
      whereArgs: [book.id],
    );

    await db.delete('villains', where: 'bookId = ?', whereArgs: [book.id]);
    if (book.villains != null) {
      for (var villain in book.villains!) {
        await db.insert('villains', {
          'bookId': book.id,
          'name': villain.name,
          'url': villain.url,
        });
      }
    }
  }

  static Future<void> deleteBook(int id) async {
    final db = await _openDb();
    await db.delete('books', where: 'id = ?', whereArgs: [id]);
    await db.delete('villains', where: 'bookId = ?', whereArgs: [id]);
  }
}
