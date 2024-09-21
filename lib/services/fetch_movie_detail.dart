import "dart:convert";
import "package:flutter_dotenv/flutter_dotenv.dart";
import "package:http/http.dart" as http;

import "../model/MovieDetailModel.dart";

class FetchMovieDetail {
  Future<MovieDetailModel?> getMovieDetailApi(String endpoint) async {
    final apiKey = dotenv.env['TMDB_API_KEY'];

    // Construct the full URL with API key and other query parameters
    final url = Uri.parse('$endpoint?api_key=$apiKey&language=en-US');

    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      // Convert JSON response to MovieDetailModel
      return MovieDetailModel.fromJson(data);
    } else {
      print('Failed to fetch movie details. Status Code: ${response.statusCode}');
      return null;
    }
  }
}
