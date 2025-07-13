import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

part 'database.g.dart';

class Books extends Table{
  IntColumn get id => integer().autoIncrement()();
  TextColumn get title => text().nullable()();
  TextColumn get author => text().nullable()();
  TextColumn get content => text().nullable()();
  TextColumn get url => text().nullable()();
  TextColumn get urlToImage => text().nullable()();
  TextColumn get publishedAt => text().nullable()();
}

LazyDatabase openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'dbBooks.sqlite'));
    return NativeDatabase(file);
  });
}

@DriftDatabase(tables: [Books])
class AppDatabase extends _$AppDatabase {
  AppDatabase(NativeDatabase nativeDatabase) : super(openConnection());

  @override
  int get schemaVersion => 1;


  Future<int> insertBook(BooksCompanion bookCompanion) async {
    // Check if the book already exists
    final existingBooks = await (select(books)
      ..where((tbl) => tbl.title.equals(bookCompanion.title.value)))
        .get();
    if (existingBooks.isNotEmpty) {
      // If the book already exists, return the existing book's ID
      return -1;
    }
    return await into(books).insert(bookCompanion);
  }

  Future<List<Book>> getAllBooks() async {
    return await select(books).get();
  }

  Future deleteBook(int id) async {
    return await (delete(books)..where((tbl) => tbl.id.equals(id))).go();
  }
}