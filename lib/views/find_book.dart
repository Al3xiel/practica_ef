import 'package:flutter/material.dart';

class FindBook extends StatefulWidget {
  const FindBook({super.key});

  @override
  State<FindBook> createState() => _FindBookState();
}

class _FindBookState extends State<FindBook> {
  final TextEditingController _searchController = TextEditingController();
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
              )
            ],
          ),
        )
    );
  }
}
