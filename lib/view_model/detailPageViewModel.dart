import 'package:flutter/material.dart';
import 'package:movies/services/Fetch_movie_detail.dart';
import '../model/MovieDetailModel.dart';
import '../res/aap_Urls.dart';

class DetailPageViewModel extends ChangeNotifier {
  MovieDetailModel? details;
  bool isLoading = true;

  // Method to fetch movie details
  Future<void> getMovieDetails(String movieId) async {
    FetchMovieDetail detailApi = FetchMovieDetail();
    try {
      final movieDetails = await detailApi.getMovieDetailApi(
        AppUrls.movieDetailUrl + movieId,
      );
      details = movieDetails;
      isLoading = false;
      notifyListeners();
    } catch (error) {
      print(error);
      isLoading = false;
      notifyListeners();
    }
  }
}
