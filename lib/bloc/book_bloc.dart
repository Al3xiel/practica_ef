import 'package:bloc/bloc.dart';
import 'package:prac_ef/bloc/book_event.dart';
import 'package:prac_ef/bloc/book_state.dart';

import '../beans/json_book.dart';
import '../service/book_service.dart';

class BookBloc extends Bloc<BookEvent, BookState>{
  final BookService bookService;

  BookBloc({required this.bookService}) : super(BookInitial()){
    on<FetchBooksEvent>(_onFetchBooks);
  }

  Future<void> _onFetchBooks(
      FetchBooksEvent event,
      Emitter<BookState> emit)
  async {
    emit(BookLoading());
    try {
      final books = await bookService.getBooks();
      emit(BookLoaded(books));
    } catch (e) {
      emit(BookError(e.toString()));
    }
  }
}