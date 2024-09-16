import 'dart:async';
import 'package:flutter/material.dart';
import 'package:movies/model/searchResultModel.dart';
import 'package:movies/view_model/searchViewModel.dart';
import 'package:movies/view_model/watchListViewModel.dart';
import 'package:provider/provider.dart';

import 'detail_page_view.dart';

class SearchPageView extends StatefulWidget {
  const SearchPageView({super.key});

  @override
  State<SearchPageView> createState() => _SearchPageViewState();
}

class _SearchPageViewState extends State<SearchPageView> {
  TextEditingController searchController = TextEditingController();
  Timer? _debounce;

  void _onSearchChanged(String query, SearchViewModel viewModel) {
    if (_debounce?.isActive ?? false) _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () {
      viewModel.searchMovies(query);
    });
  }

  @override
  void dispose() {
    _debounce?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer2<SearchViewModel, WatchlistViewModel>(
        builder: (context, searchViewModel, watchlistViewModel, child) {
          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: searchController,
                  onChanged: (value) {
                    _onSearchChanged(value, searchViewModel);
                  },
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.symmetric(horizontal: 20),
                    hintText: 'Search here',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(50.0),
                    ),
                  ),
                ),
              ),
              if (searchViewModel.isLoading)
                const Center(child: CircularProgressIndicator()),
              if (!searchViewModel.isLoading &&
                  searchViewModel.movies.isEmpty)
                const Center(child: Text('No results found')),
              if (searchViewModel.movies.isNotEmpty)
                Expanded(
                  child: ListView.builder(
                    itemCount: searchViewModel.movies.length,
                    itemBuilder: (context, index) {
                      final searchResults movie = searchViewModel.movies[index];
                      final isInWatchlist = watchlistViewModel.isMovieInWatchlist(movie.id?.toInt() ?? 0); // Use movie.id directly
                      return InkWell(
                        onTap: () {
                          final movieData = movie;
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => DetailPageView(movieData: movieData),
                            ),
                          );
                        },
                        child: ListTile(
                          leading: movie.posterPath != null
                              ? Image.network(
                              'https://image.tmdb.org/t/p/w500${movie.posterPath}')
                              : const Icon(Icons.image_not_supported),
                          title: Text(movie.title ?? 'No title'),
                          subtitle: Text(movie.releaseDate ?? 'No release date'),
                          trailing: IconButton(
                            icon: Icon(
                              isInWatchlist
                                  ? Icons.check_circle
                                  : Icons.add_circle_outline,
                            ),
                            onPressed: () {
                              if (isInWatchlist) {
                                watchlistViewModel.removeMovieFromWatchlist(movie);
                              } else {
                                watchlistViewModel.addMovieToWatchlist(movie);
                              }
                            },
                          ),
                        ),
                      );
                    },
                  ),
                ),
            ],
          );
        },
      ),
    );
  }
}
