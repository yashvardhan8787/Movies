import 'package:flutter/material.dart';
import 'package:movies/components/toast_message.dart';
import 'package:movies/model/searchResultModel.dart';
import '../services/search_api.dart';

class SearchViewModel extends ChangeNotifier {
  final SearchApi searchApi = SearchApi();
  List<searchResults> _movies = []; // Use List<Results> to match your model
  bool _isLoading = false;

  List<searchResults> get movies => _movies; // Return List<Results> instead of dynamic
  bool get isLoading => _isLoading;

  void searchMovies(String query , context) async {
    if (query.isEmpty) {
      _movies = [];
      notifyListeners();
      return;
    }

    _isLoading = true;
    notifyListeners();

    try {
      SearchResultModel? result = await searchApi.getSearchApi(query);
      if (result != null && result.results != null) {
        _movies = result.results!; // Assign the list of Results
      } else {
        _movies = [];
      }
    } catch (error) {
      _movies = [];
      ToastMessage.flushBarMessage(error.toString(), context);
    }

    _isLoading = false;
    notifyListeners();
  }
}
