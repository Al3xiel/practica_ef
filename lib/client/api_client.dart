import 'package:http/http.dart' as http;

class ApiClient{
  static const String _baseUrl = 'https://dev.formandocodigo.com/';

  static Future<http.Response> get(String endpoint) async {
    final uri = Uri.parse(_baseUrl + endpoint);
    final headers = {
      'Content-Type': 'application/json',
    };
    return await http.get(uri, headers: headers);
  }
}

