import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:movies/model/fetchMoviesModel.dart';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import '../res/aap_Urls.dart';
class FetchMovies {
  Future<FetchMoviesModel?> fetchMoviesApi(String minDate, String maxDate ,Endpoint) async {
    final String apiUrl = Endpoint;

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


    // Build the complete URL with query parameters
    Uri uri = Uri.parse(apiUrl).replace(queryParameters: queryParams);

    try {
      // Make the GET request with headers
      final response = await http.get(
        uri,
        headers: {
          'Authorization': 'Bearer ${dotenv.env['AUTH_TOKEN_TMDB']}',
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
