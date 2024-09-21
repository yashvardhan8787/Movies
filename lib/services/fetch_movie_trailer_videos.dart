import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import '../model/trailerVideosModels.dart';

class FetchMovieTrailerVideos {
  final String? apiKey = dotenv.env['TMDB_API_KEY'];

  Future<TrailerVideosModels?> fetchVideosApi(String id) async {
    final url = Uri.parse('https://api.themoviedb.org/3/movie/$id/videos?api_key=$apiKey');
    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        // Parse the JSON response
        final responseJson = TrailerVideosModels.fromJson(json.decode(response.body));
        return responseJson;
      } else {
        // Handle other status codes or error scenarios
        print('Failed to load trailer videos, status code: ${response.statusCode}');
        return null;
      }
    } catch (error) {
      // Handle any errors in the try block
      print('Error in FetchMovieTrailerVideos: $error');
      return null;
    }
  }
}
