import 'package:flutter/cupertino.dart';
import '../services/fetch_movie_credits.dart';

class MovieCastViewModel extends ChangeNotifier {
  Map<String, dynamic>? _credits;
  bool _isLoading = false;

  // Getter to access credits
  Map<String, dynamic>? get credits => _credits;

  // Getter for loading state
  bool get isLoading => _isLoading;

  // Fetch movie credits from API
  Future<dynamic> getMovieCredits(String movieId) async {
    _isLoading = true;
    notifyListeners();  // Notify UI that loading has started
    FetchMovieCredits creditsApi = FetchMovieCredits();

    try {
      _credits = await creditsApi.fetchMovieCredits(movieId);
      _isLoading = false;
      notifyListeners();  // Notify UI that data has been fetched
      return _credits;
    } catch (error) {
      _isLoading = false;
      notifyListeners();  // Notify UI that an error occurred
      return null;
    }
  }
}
