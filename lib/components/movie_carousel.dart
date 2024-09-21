import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:movies/res/aap_Urls.dart';
import 'package:shimmer/shimmer.dart';
import '../model/fetch_movies_model.dart';
import '../services/fetch_movies.dart';
import "package:flutter/material.dart";
import 'movie_carousel_item.dart';

class MovieCarousel extends StatefulWidget {
  const MovieCarousel({super.key});

  @override
  State<MovieCarousel> createState() => _MovieCarouselState();
}

class _MovieCarouselState extends State<MovieCarousel> {

  late Future<FetchMoviesModel?> moviesData;

  @override
  void initState() {
    super.initState();
    FetchMovies fetchMovies = FetchMovies();
    // Fetch movies from January 2023
    moviesData = fetchMovies.fetchMoviesApi("2023-01-01", "2023-01-31",AppUrls.movieList);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<FetchMoviesModel?>(
        future: moviesData,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Shimmer.fromColors(
                baseColor: Colors.grey[300]!,
                highlightColor: Colors.white70,
            child: Container(
              height: 400,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                )
            ),);
          } else if (snapshot.hasError) {
            return Shimmer.fromColors(
              baseColor: Colors.grey[300]!,
              highlightColor: Colors.white70,
              child: Container(
                  height: 400,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  )
                  ,child: const Text("Something Went Wrong!"),
              ),);
          } else if (!snapshot.hasData || snapshot.data == null || snapshot.data!.results!.isEmpty) {
            return   SizedBox(
              width:MediaQuery.of(context).size.width * 1,
              child: Center(
                child: Container(
                  height: 400,
                  width:MediaQuery.of(context).size.width * 0.96,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(10),
                  )
                  ,child: const Center(child: Text("No movies to display",style: TextStyle(color: Colors.black),)),
                ),
              ),
            );
          } else {
            // Data fetched successfully, display the carousel
            return SizedBox(
              height: MediaQuery.of(context).size.height * 0.5,
              child: CarouselSlider.builder(
                itemCount: snapshot.data!.results!.length,
                itemBuilder: (context, index, realIndex) {
                  final movie = snapshot.data!.results![index];
                  return MovieCarouselItem(movie: movie);
                },
                options: CarouselOptions(
                  height: MediaQuery.of(context).size.height * 0.5,
                  enlargeCenterPage: true,
                  autoPlay: true,
                  autoPlayInterval: const Duration(seconds: 3),
                  viewportFraction: 0.8,
                  aspectRatio: 5/4,
                  initialPage: 0,
                ),
              ),
            );
          }
        },
      ),
    );
  }
}
