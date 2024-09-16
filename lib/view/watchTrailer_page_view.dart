import 'package:flutter/material.dart';
import 'package:movies/services/fecth_movie_trailer_videos.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class WatchtrailerPageView extends StatefulWidget {
  final dynamic movieData;
  const WatchtrailerPageView({super.key, required this.movieData});

  @override
  State<WatchtrailerPageView> createState() => _WatchtrailerPageViewState();
}

class _WatchtrailerPageViewState extends State<WatchtrailerPageView> {
  YoutubePlayerController? _controller;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    getVideoUrl(widget.movieData.id.toString());
  }

  Future<void> getVideoUrl(String id) async {
    final FetchMovieTrailerVideos trailerVideos = FetchMovieTrailerVideos();
    try {
      final dynamic videos = await trailerVideos.fetchVideosApi(id);
      print('print for debug');
      print(videos);
      final videoKey = videos.results.isNotEmpty ? videos.results[0].key : null;
      if (videoKey != null) {
        final videoId = YoutubePlayer.convertUrlToId('https://www.youtube.com/watch?v=$videoKey');
        setState(() {
          _controller = YoutubePlayerController(
            initialVideoId: videoId!,
            flags: const YoutubePlayerFlags(autoPlay: false),
          );
          isLoading = false;
        });
      }
    } catch (error) {
      print(error);
      setState(() {
        isLoading = false; // Ensure loading is updated even if an error occurs
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Watch Trailer"),
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : _controller != null
          ? YoutubePlayer(controller: _controller!)
          : const Center(child: Text("No trailer available")),
    );
  }
}
