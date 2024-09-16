import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import '../model/searchResultModel.dart';
 // Import your model

class SearchApi {
  Future<SearchResultModel?> getSearchApi(String query) async {
    final apiKey = dotenv.env['TMDB_API_KEY'];
    final url = Uri.parse(
        'https://api.themoviedb.org/3/search/movie?api_key=$apiKey&query=$query&language=en-US&page=1&include_adult=false');

    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      // Convert JSON response to SearchResultModel
      return SearchResultModel.fromJson(data);
    } else {
      print('Failed to fetch movies');
      return null;
    }
  }
}
