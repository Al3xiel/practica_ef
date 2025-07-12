import 'package:flutter/material.dart';

class FavoriteBook extends StatefulWidget {
  const FavoriteBook({super.key});

  @override
  State<FavoriteBook> createState() => _FavoriteBookState();
}

class _FavoriteBookState extends State<FavoriteBook> {
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
                child: Text("Favorite Book",
                    style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue
                    )
                ),
              ),
            ],
          ),
        )
    );
  }
}
