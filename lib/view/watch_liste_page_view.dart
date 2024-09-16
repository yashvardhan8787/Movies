import 'package:flutter/material.dart';
import 'package:movies/model/searchResultModel.dart'; // Import your Results model
import 'package:movies/view/detail_page_view.dart';
import 'package:movies/view_model/watchListViewModel.dart';
import 'package:provider/provider.dart';

class WatchlistPageView extends StatelessWidget {
  const WatchlistPageView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<WatchlistViewModel>(
        builder: (context, viewModel, child) {
          if (viewModel.watchlist.isEmpty) {
            return const Center(child: Text('No movies in watchlist'));
          }

          return ListView.builder(
            itemCount: viewModel.watchlist.length,
            itemBuilder: (context, index) {
              final dynamic movie = viewModel.watchlist[index]; // Use Results object

              return InkWell(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) =>DetailPageView(movieData: movie) ,));
                },
                child: ListTile(
                  leading: movie.posterPath != null
                      ? Image.network(
                      'https://image.tmdb.org/t/p/w500${movie.posterPath}')
                      : const Icon(Icons.image_not_supported),
                  title: Text(movie.title ?? 'Unknown title'),
                  subtitle: Text(movie.releaseDate ?? 'No release date'),
                  trailing: IconButton(
                    icon: const Icon(Icons.remove_circle_outline),
                    onPressed: () {
                      viewModel.removeMovieFromWatchlist(movie);
                    },
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
