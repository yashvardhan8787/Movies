import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

class FetchMovieCredits {
  Future<Map<String, dynamic>?> fetchMovieCredits(String movieId) async {
    final apiKey = dotenv.env['TMDB_API_KEY'];
    final url = Uri.parse('https://api.themoviedb.org/3/movie/$movieId/credits?api_key=$apiKey');

    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return data; // Returns the entire credits data, including cast and crew
    } else {
      print('Failed to fetch credits');
      print("${apiKey}   this is api key");
      return null;
    }
  }
}
