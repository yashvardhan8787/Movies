import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:movies/components/movie_cast.dart';
import 'package:movies/components/movie_section.dart';
import 'package:movies/view_model/download_video_view_model.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import '../view_model/trailer_view_model.dart';

class WatchtrailerPageView extends StatelessWidget {
  final dynamic movieData;
  const WatchtrailerPageView({super.key, required this.movieData});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => TrailerViewModel()..fetchTrailer(movieData.id.toString(), context),
      child: Scaffold(
        appBar: AppBar(
          title: Text(movieData.title),
        ),
        body: SingleChildScrollView(
          child: Consumer<TrailerViewModel>(
            builder: (context, trailerViewModel, child) {
              if (trailerViewModel.isLoading) {
                return const Center(child: CircularProgressIndicator());
              }

              if (trailerViewModel.errorMessage != null) {
                return Center(child: Text(trailerViewModel.errorMessage!));
              }

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (trailerViewModel.controller != null)
                    YoutubePlayer(controller: trailerViewModel.controller!),
                  Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: Text(
                      movieData.title,
                      style: const TextStyle(
                        fontWeight: FontWeight.w800,
                        fontSize: 30,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Text(
                      "Overview: " + movieData.overview,
                      style: const TextStyle(fontWeight: FontWeight.w800),
                    ),
                  ),
                  Consumer<Downloadvideoveiwmodel>(
                    builder: (BuildContext context, Downloadvideoveiwmodel value, Widget? child) {
                      return InkWell(
                        onTap: () {
                          if (value.status == 'Download') {
                            value.downloadVideo(trailerViewModel.videoUrl , context);
                          }
                        },
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width * 1.0 ,
                          child: Center(
                            child: Container(
                              width: MediaQuery.of(context).size.width * 0.95,
                              height: 50,
                              decoration: BoxDecoration(
                                color: Colors.green,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Center(
                                child: Text(
                                  value.status,
                                  style: const TextStyle(
                                      fontSize: 16, fontWeight: FontWeight.w800),
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                  MovieCast(movieData: movieData),
                  MovieSection(
                    sectionName: "Similar Movies",
                    sectionEndpoint:
                    "https://api.themoviedb.org/3/movie/${movieData.id}/similar",
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
