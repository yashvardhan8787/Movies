import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movies/components/movie_carousel.dart';
import 'package:movies/components/movie_section.dart';
import 'package:movies/res/aap_Urls.dart';
import 'package:movies/model/fetch_movies_model.dart'; // Assuming your model is here



class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});




  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late Future<FetchMoviesModel?> moviesData;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body:SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 8,),
              SizedBox(height:MediaQuery.of(context).size.height * 0.5,
                  child: MovieCarousel()),
              MovieSection(sectionName: "Coming Soon",sectionEndpoint: AppUrls.upcomingMovieUrl,),
              MovieSection(sectionName: "Playing Now",sectionEndpoint: AppUrls.now_playingMovieUrl,),
              MovieSection(sectionName: "Popular Movies",sectionEndpoint: AppUrls.popularMovieUrl,),
              MovieSection(sectionName: "Trending Movies",sectionEndpoint: AppUrls.topRatedMovieUrl,),
            ],
          ),
        ) );
  }
}




