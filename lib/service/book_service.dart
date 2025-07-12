import 'package:http/http.dart' as http;
import 'dart:convert';

import '../beans/json_book.dart';
import '../client/api_client.dart';

class BookService {
  Future<List<JsonBook>> getBooks() async {
    final response = await ApiClient.get('articles.php?description=all');
    if (response.statusCode == 200) {
      final List<dynamic> jsonList = json.decode(response.body);
      return jsonList.map((json) => JsonBook.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load books');
    }
  }
}