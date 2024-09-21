import 'package:flutter/material.dart';
import 'package:movies/components/movie_section.dart';
import 'package:movies/components/round_buttons.dart';
import 'package:movies/res/aap_Urls.dart';
import 'package:movies/view/watchTrailer_page_view.dart';
import 'package:movies/view_model/detail_page_view_model.dart';
import 'package:movies/view_model/watchlist_view_model.dart';
import 'package:provider/provider.dart';

class DetailPageView extends StatelessWidget {
  final dynamic movieData;
  const DetailPageView({super.key, required this.movieData});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => DetailPageViewModel()..getMovieDetails(movieData.id.toString(),context),
      child: Scaffold(
        appBar: AppBar(
          leading: const Icon(Icons.menu, color: Colors.white),
          backgroundColor: Colors.blue,
          title: Text(
            movieData.title,
            style: TextStyle(color: Colors.white),
          ),
          actions: const [
            Icon(Icons.notifications, color: Colors.white),
            SizedBox(width: 20),
            Icon(Icons.account_circle_outlined, color: Colors.white),
            SizedBox(width: 10)
          ],
        ),
        body: Consumer<DetailPageViewModel>(
          builder: (context, detailViewModel, child) {
            if (detailViewModel.isLoading) {
              return const Center(child: CircularProgressIndicator());
            }
            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 1.0,
                    height: MediaQuery.of(context).size.height * 0.4,
                    child: Image.network(
                      AppUrls.posterPathBaseUrl + movieData.posterPath,
                      fit: BoxFit.cover,
                    ),
                  ),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(2.0),
                        child: RoundButtons(
                          color: Colors.lightBlue,
                          title: "Watch Trailer",
                          onPress: () {
                            Navigator.push(context,MaterialPageRoute(builder: (context) => WatchtrailerPageView(movieData: movieData),));
                          },
                          icon: Icons.movie,
                        ),
                      ),
                      Consumer<WatchlistViewModel>(
                          builder: (context, value, child) {
                            if (value.isMovieInWatchlist(movieData.id.toInt())) {
                              return Padding(
                                padding: const EdgeInsets.all(2.0),
                                child: RoundButtons(
                                  color: Colors.red,
                                  title: "Remove WatchList",
                                  onPress: () {
                                    value.removeMovieFromWatchlist(movieData , context);
                                  },
                                  icon: Icons.favorite_outline_outlined,
                                ),
                              );
                            }
                            return Padding(
                              padding: const EdgeInsets.all(2.0),
                              child: RoundButtons(
                                color: Colors.lightBlue,
                                title: "Add To WatchList",
                                onPress: () {
                                  value.addMovieToWatchlist(movieData , context);
                                },
                                icon: Icons.favorite,
                              ),
                            );
                          })
                    ],
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 1.0,
                    child: Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: Text(
                        movieData.title,
                        style: const TextStyle(
                          fontWeight: FontWeight.w800,
                          fontSize: 30,
                        ),
                      ),
                    ),
                  ),
                  if (detailViewModel.details != null)
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 1.0,
                      child: Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Text(
                          'Language: ${detailViewModel.details!.originalLanguage}',
                          style: const TextStyle(fontWeight: FontWeight.w800),
                        ),
                      ),
                    ),
                  if (detailViewModel.details != null)
                  Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Text(
                      "Overview: " + movieData.overview,
                      style: const TextStyle(
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 30, // Set a fixed height for the genre list
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: detailViewModel.details?.genres?.length ?? 0,
                      itemBuilder: (context, index) {
                        final genre = detailViewModel.details!.genres![index];
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Chip(
                            label: Text(
                              genre.name.toString(),
                              style: const TextStyle(
                                  fontSize: 12, color: Colors.white),
                            ),
                            backgroundColor: Colors.blue,
                          ),
                        );
                      },
                    ),
                  ),
                  MovieSection(
                      sectionName: "Similar Movies",
                      sectionEndpoint:
                      "https://api.themoviedb.org/3/movie/${movieData.id}/similar"),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
