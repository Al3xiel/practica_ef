import 'package:prac_ef/beans/json_book.dart';

abstract class BookState {}

class BookInitial extends BookState {}

class BookLoading extends BookState {}

class BookLoaded extends BookState {
  final List<JsonBook> books;

  BookLoaded(this.books);
}

class BookError extends BookState {
  final String message;
  BookError(this.message);
}