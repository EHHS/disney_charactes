import 'dart:convert';
import 'package:http/http.dart' as http;

class CharacterRepository {
  final String baseUrl = 'https://api.disneyapi.dev/character';

  Future<Map<String, dynamic>> fetchCharacters(String query, int page, int pageSize) async {
    final url = query.isEmpty
        ? '?page=$page&pageSize=$pageSize'
        : '?name=$query&page=$page&pageSize=$pageSize';

    final response = await http.get(Uri.parse(baseUrl + url));

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load data');
    }
  }
}
