import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:movies/model/fetchMoviesModel.dart';

class FetchMovies {
  Future<FetchMoviesModel?> fetchMoviesApi(String minDate, String maxDate) async {
    final String apiUrl = 'https://api.themoviedb.org/3/discover/movie';

    // Query parameters
    Map<String, String> queryParams = {
      'include_adult': 'false',
      'include_video': 'false',
      'language': 'en-US',
      'page': '1',
      'sort_by': 'popularity.desc',
      'with_release_type': '2|3',
      'release_date.gte': minDate,
      'release_date.lte': maxDate,
    };

    // Bearer token for authorization
    final String token =
        'eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI3ODAwZDlmNGJmYjNiODY3YjUxNmQwMTVmY2RhNTUyOCIsIm5iZiI6MTcyNTc5NDE1NS45MDE1NDMsInN1YiI6IjY2ZGM1ZTBhM2M1NThiNWU2YWVlMjgxZSIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.IHyrU7bIbKhX8OMW6PQ6HHnHVS9bbOGAzj4ldciz00s';

    // Build the complete URL with query parameters
    Uri uri = Uri.parse(apiUrl).replace(queryParameters: queryParams);

    try {
      // Make the GET request with headers
      final response = await http.get(
        uri,
        headers: {
          'Authorization': 'Bearer $token',
          'accept': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        // Parse the JSON response
        final jsonData = FetchMoviesModel.fromJson(json.decode(response.body));
        return jsonData;
      } else {
        print('Failed to load movies. Status Code: ${response.statusCode}');
        return null;
      }
    } catch (error) {
      print('Error occurred: $error');
      return null;
    }
  }
}
