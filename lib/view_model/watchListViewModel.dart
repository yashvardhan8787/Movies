import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:movies/model/searchResultModel.dart'; // renamed class as SearchResults
import 'package:movies/model/fetchMoviesModel.dart'; // uses class Results

class WatchlistViewModel extends ChangeNotifier {
  List<dynamic> _watchlist = []; // dynamic to handle both Results and SearchResults types

  List<dynamic> get watchlist => _watchlist;

  WatchlistViewModel() {
    loadWatchlist();
  }

  // Load watchlist from SharedPreferences
  Future<void> loadWatchlist() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? watchlistString = prefs.getString('watchlist');
    if (watchlistString != null) {
      List<dynamic> decodedList = json.decode(watchlistString);
      _watchlist = decodedList.map((item) {
        // Determine whether the item is Results or SearchResults
        if (item['someKeyThatDifferentiates']) {
          // assuming there's a unique key in SearchResults
          return searchResults.fromJson(item);
        } else {
          return Results.fromJson(item);
        }
      }).toList();
      notifyListeners();
    }
  }

  // Add a movie to the watchlist
  Future<void> addMovieToWatchlist(dynamic movie) async {
    _watchlist.add(movie);
    await _saveWatchlist();
    notifyListeners();
  }

  // Remove a movie from the watchlist
  Future<void> removeMovieFromWatchlist(dynamic movie) async {
    _watchlist.removeWhere((item) => item.id == movie.id);
    await _saveWatchlist();
    notifyListeners();
  }

  // Save the updated watchlist to SharedPreferences
  Future<void> _saveWatchlist() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String watchlistString = json.encode(
      _watchlist.map((item) => item.toJson()).toList(),
    );
    await prefs.setString('watchlist', watchlistString);
  }

  // Check if a movie is in the watchlist
  bool isMovieInWatchlist(int movieId) {
    return _watchlist.any((movie) => movie.id == movieId);
  }
}
