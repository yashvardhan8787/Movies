import 'package:flutter/material.dart';
import 'package:movies/services/fetch_movie_trailer_videos.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../components/toast_message.dart';

class TrailerViewModel with ChangeNotifier {
  YoutubePlayerController? _controller;
  bool _isLoading = true;
  String? _errorMessage;
  String _videoUrl = '';

  YoutubePlayerController? get controller => _controller;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  String get videoUrl => _videoUrl;

  Future<void> fetchTrailer(String id , context) async {
    final FetchMovieTrailerVideos trailerVideos = FetchMovieTrailerVideos();
    try {
      final videos = await trailerVideos.fetchVideosApi(id);

      if (videos != null && videos.results!.isNotEmpty) {
        final videoKey = videos.results![0].key;
        _videoUrl = 'https://www.youtube.com/watch?v=$videoKey';

        if (videoKey != null && videoKey.isNotEmpty) {
          final videoId = YoutubePlayer.convertUrlToId(
              'https://www.youtube.com/watch?v=$videoKey');

          if (videoId != null) {
            _controller = YoutubePlayerController(
              initialVideoId: videoId,
              flags: const YoutubePlayerFlags(autoPlay: false),
            );
          } else {
            ToastMessage.flushBarMessage("Unable to retrieve video ID.", context);
          }
        } else {
          ToastMessage.flushBarMessage("No video key found.", context);
        }
      } else {
        ToastMessage.flushBarMessage("No videos found.", context);
      }
    } catch (error) {
      ToastMessage.flushBarMessage( "Failed to load trailer: $error", context);
    }

    _isLoading = false;
    notifyListeners();
  }
}
