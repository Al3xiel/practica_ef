import 'package:drift/drift.dart' as dr;
import 'package:drift/native.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:prac_ef/beans/json_book.dart';

import '../bloc/book_bloc.dart';
import '../bloc/book_event.dart';
import '../bloc/book_state.dart';
import '../database/database.dart';

class FindBook extends StatefulWidget {
  const FindBook({super.key});

  @override
  State<FindBook> createState() => _FindBookState();
}

class _FindBookState extends State<FindBook> {
  final TextEditingController _searchController = TextEditingController();
  final database = AppDatabase(NativeDatabase.memory());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
        AppBar(
          title: Text("Find Book", style: TextStyle(color: Colors.white)),
          backgroundColor: Colors.blue,
          iconTheme: IconThemeData(color: Colors.white),
        ),
      body:
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              Center(
                child: Text("Find Book",
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue
                  )
                ),
              ),
              SizedBox(height: 20),
              Center(
                child: Text("Search for your favorite books here!",
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.black54
                  )
                ),
              ),
              SizedBox(height: 20),
              TextFormField(
                controller: _searchController,
                decoration: InputDecoration(
                  labelText: "Search",
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.search, color: Colors.blue)
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  BlocProvider.of<BookBloc>(context).add(
                    FetchBooksEvent(_searchController.text)
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                ),
                child: Text("Search", style: TextStyle(color: Colors.white)),
              ),
              SizedBox(height: 20),
              Expanded(
                child: BlocBuilder<BookBloc, BookState>(
                  builder: (context, state) {
                    if (state is BookLoading) {
                      return Center(child: CircularProgressIndicator());
                    } else if (state is BookError) {
                      return Center(child: Text('Error: \\${state.message}'));
                    } else if (state is BookLoaded) {
                      final books = state.books;
                      if (books.isEmpty) {
                        return Center(child: Text('No books found.'));
                      }
                      return _buildBookCards(books);
                    }
                    return Center(child: Text('No books found.'));
                  },
                ),
              ),
            ],
          ),
        )
    );
  }

  Widget _buildBookCards(List<JsonBook> books) {
    return ListView.builder(
      itemCount: books.length,
      itemBuilder: (context, index) {
        final book = books[index];
        return Card(
          color: Colors.blue,
          margin: EdgeInsets.only(bottom: 10),
          elevation: 5,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ListTile(
                title: Text(
                  book.title ?? 'No Title',
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
                subtitle: Text(
                  book.author ?? 'No Author',
                  style: TextStyle(color: Colors.white70),
                ),
              ),
              ClipRect(
                child: AspectRatio(
                  aspectRatio: 16 / 9,
                  child: book.urlToImage == null
                    ? Icon(Icons.add_a_photo_outlined, size: 80, color: Colors.white)
                    : Image.network(book.urlToImage!, fit: BoxFit.cover),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  book.content ?? 'No Content',
                  style: TextStyle(color: Colors.white70),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  (book.publishedAt != null && book.publishedAt!.length >= 10)
                    ? "Publicado en: ${book.publishedAt!.substring(0, 10)}"
                    : 'No Published Date',
                  style: TextStyle(color: Colors.white70),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  book.url != null && book.url!.isNotEmpty
                    ? "Enlace a la noticia: ${book.url}"
                    : 'No URL',
                  style: TextStyle(color: Colors.white70),
                ),
              ),
              Center(
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    ),
                    onPressed: () {
                      database.insertBook(
                        BooksCompanion(
                          title: dr.Value(book.title ?? 'No Title'),
                          author: dr.Value(book.author ?? 'No Author'),
                          content: dr.Value(book.content ?? 'No Content'),
                          urlToImage: dr.Value(book.urlToImage ?? 'No Image'),
                          url: dr.Value(book.url ?? 'No URL'),
                          publishedAt: dr.Value(book.publishedAt ?? 'No Date'),
                        )
                      ).then((resultId) {
                        if (resultId <= 0) {
                          // Si el libro ya existía, insertBook retorna el id existente (positivo), si no, retorna el nuevo id (positivo)
                          ScaffoldMessenger.of(context).hideCurrentSnackBar();
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('El libro ya está en favoritos'),
                              backgroundColor: Colors.amber,
                            )
                          );
                        } else {
                          // Si es un nuevo libro insertado
                          ScaffoldMessenger.of(context).hideCurrentSnackBar();
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Book added to favorites!'),
                              backgroundColor: Colors.green,
                            )
                          );
                        }
                      }).catchError((error) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Error adding book: $error'))
                        );
                      });
                    },
                    child:
                    Text("Agregar a favoritos", style: TextStyle(color: Colors.blue))
                ),
              ),
              SizedBox(height: 8),
            ],
          )
        );
      },
    );
  }
}