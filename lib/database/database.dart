import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

part 'database.g.dart';

class Books extends Table{
  IntColumn get id => integer().autoIncrement()();
  TextColumn get title => text().withLength(min: 1, max: 100)();
  TextColumn get author => text().withLength(min: 1, max: 100)();
  TextColumn get description => text().nullable()();
  BoolColumn get isFavorite => boolean().withDefault(Constant(false))();
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
    return await into(books).insert(bookCompanion);
  }

  Future<List<Book>> getAllBooks() async {
    return await select(books).get();
  }

  Future deleteBook(int id) async {
    return await (delete(books)..where((tbl) => tbl.id.equals(id))).go();
  }
}