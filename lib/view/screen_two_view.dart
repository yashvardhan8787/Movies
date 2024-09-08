import 'package:flutter/material.dart';
import 'package:movies/services/fetch_movies.dart';
import 'package:movies/model/fetchMoviesModel.dart'; // Assuming your model is here

class ScreenTwoView extends StatefulWidget {
  const ScreenTwoView({super.key});

  @override
  State<ScreenTwoView> createState() => _ScreenTwoViewState();
}

class _ScreenTwoViewState extends State<ScreenTwoView> {

  late Future<FetchMoviesModel?> moviesData;

  @override
  void initState() {
    super.initState();
    FetchMovies fetchMovies = FetchMovies();
    // Fetch movies from January 2023
    moviesData = fetchMovies.fetchMoviesApi("2023-01-01", "2023-01-31");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Movies"),
      ),
      body: FutureBuilder<FetchMoviesModel?>(
        future: moviesData,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            // While the API call is in progress, show a loading spinner
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            // In case of an error, display an error message
            return Center(child: Text('Error fetching movies'));
          } else if (!snapshot.hasData || snapshot.data == null || snapshot.data!.results!.isEmpty) {
            // If there are no movies to display
            return Center(child: Text('No movies available'));
          } else {
            // Data fetched successfully, display the list
            return ListView.builder(
              itemCount: snapshot.data!.results!.length,
              itemBuilder: (context, index) {
                final movie = snapshot.data!.results![index];
                return ListTile(
                  leading: Image.network(
                    'https://image.tmdb.org/t/p/w500${movie.posterPath}',
                    width: 50,
                    height: 100,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) => Icon(Icons.error),
                  ),
                  title: Text(movie.title.toString()),
                  subtitle: Text(movie.overview.toString(), maxLines: 2, overflow: TextOverflow.ellipsis),
                );
              },
            );
          }
        },
      ),
    );
  }
}
