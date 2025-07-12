import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/book_bloc.dart';
import '../service/book_service.dart';
import 'favorite_book.dart';
import 'find_book.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            SizedBox(height: 50),
            Center(
              child: Text("AppBook",
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue
                )
              ),
            ),
            SizedBox(height: 20),
            Center(child: Image.asset('images/brand-logo.png')),
            SizedBox(height: 20),
            Center(
                child:
                OutlinedButton(
                    onPressed: (){
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => BlocProvider(
                            create: (context) => BookBloc(bookService: BookService()),
                            child: FindBook(),
                          ),
                        ),
                      );
                    },
                    child:
                    Text("Find Book",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue
                      )
                    )
                ),
            ),
            SizedBox(height: 20),
            Center(
              child:
              OutlinedButton(
                  onPressed: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context) => FavoriteBook()));
                  },
                  child:
                  Text("Favorite Book",
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.blue
                      )
                  )
              ),
            ),
          ],
        ),
      )
    );
  }
}
