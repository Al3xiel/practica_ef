import 'package:drift/native.dart';
import 'package:flutter/material.dart';

import '../database/database.dart';

class FavoriteBook extends StatefulWidget {
  const FavoriteBook({super.key});

  @override
  State<FavoriteBook> createState() => _FavoriteBookState();
}

class _FavoriteBookState extends State<FavoriteBook> {
  final database = AppDatabase(NativeDatabase.memory());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Favorite Book", style: TextStyle(color: Colors.white)),
          backgroundColor: Colors.blue,
          iconTheme: IconThemeData(color: Colors.white),
        ),
        body:
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              Center(
                child: Text("Favorite Books",
                    style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue
                    )
                ),
              ),
              FutureBuilder(
                  future: database.getAllBooks(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return Center(child: Text('Error: ${snapshot.error}'));
                    } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                      return Center(child: Text('No favorite books found.'));
                    } else {
                      List<Book> books = snapshot.data!;
                      return Expanded(
                        child: _buildBookCards(books),
                      );
                    }
                  }),
            ],
          ),
        )
    );
  }

  Widget _buildBookCards(List<Book> books) {
    return ListView.builder(
      itemCount: books.length,
      itemBuilder: (context, index) {
        final book = books[index];
        return Card(
            color: Colors.blue,
            margin: EdgeInsets.only(bottom: 16),
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
                        database.deleteBook(book.id).then((_) {
                          final snackBar = SnackBar(
                            content: Text("Libro eliminado de favoritos"),
                            backgroundColor: Colors.red,
                          );
                          ScaffoldMessenger.of(context).hideCurrentSnackBar();
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                          setState(() {
                            // El FutureBuilder se reconstruirá y actualizará la lista automáticamente
                          });
                        });
                      },
                      child:
                      Text("Eliminar de favoritos", style: TextStyle(color: Colors.red))
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
