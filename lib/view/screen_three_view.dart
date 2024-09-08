import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:movies/model/fetchMoviesModel.dart';
import '../components/movie_carousel_item.dart';
import '../services/fetch_movies.dart';

class ScreenThreeView extends StatefulWidget {
  const ScreenThreeView({super.key});

  @override
  State<ScreenThreeView> createState() => _ScreenThreeViewState();
}

class _ScreenThreeViewState extends State<ScreenThreeView> {
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
        title: const Text("Movies Carousel"),
      ),
      body: FutureBuilder<FetchMoviesModel?>(
        future: moviesData,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return const Center(child: Text('Error fetching movies'));
          } else if (!snapshot.hasData || snapshot.data == null || snapshot.data!.results!.isEmpty) {
            return const Center(child: Text('No movies available'));
          } else {
            // Data fetched successfully, display the carousel
            return CarouselSlider.builder(
              itemCount: snapshot.data!.results!.length,
              itemBuilder: (context, index, realIndex) {
                final movie = snapshot.data!.results![index];
                return MovieCarouselItem(movie: movie);
              },
              options: CarouselOptions(
                height: 400,
                enlargeCenterPage: true,
                autoPlay: true,
                autoPlayInterval: const Duration(seconds: 3),
                viewportFraction: 0.8,
                aspectRatio: 16/9,
                initialPage: 0,
              ),
            );
          }
        },
      ),
    );
  }
}
