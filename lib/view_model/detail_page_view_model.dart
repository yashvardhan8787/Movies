import 'package:flutter/material.dart';
import 'package:movies/components/toast_message.dart';
import 'package:movies/services/fetch_movie_detail.dart';
import '../model/MovieDetailModel.dart';
import '../res/aap_Urls.dart';

class DetailPageViewModel extends ChangeNotifier {
  MovieDetailModel? details;
  bool isLoading = true;

  // Method to fetch movie details
  Future<void> getMovieDetails(String movieId ,BuildContext context) async {
    FetchMovieDetail detailApi = FetchMovieDetail();
    try {
      final movieDetails = await detailApi.getMovieDetailApi(
        AppUrls.movieDetailUrl + movieId,
      );
      details = movieDetails;
      isLoading = false;
      notifyListeners();
    } catch (error) {
      ToastMessage.flushBarMessage(error.toString(), context);
      isLoading = false;
      notifyListeners();
    }
  }
}
