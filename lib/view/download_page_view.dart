import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:movies/view_model/download_video_view_model.dart'; // Assuming this path is correct
import '../components/video_tile.dart'; // Assuming you have a custom VideoTile widget

class DownloadPageView extends StatefulWidget {
  const DownloadPageView({super.key});

  @override
  State<DownloadPageView> createState() => _DownloadPageViewState();
}

class _DownloadPageViewState extends State<DownloadPageView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<Downloadvideoveiwmodel>(
        builder: (context, downloadViewModel, child) {
          if (downloadViewModel.downloadedVideos.isEmpty) {
            return Center(
              child: Text("No Downloaded Videos to Display"),
            );
          } else {
            return Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "Downloaded Videos",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold ,color: Colors.blue),
                  ),
                ),
                Expanded( // Wrap the ListView.builder with Expanded
                  child: ListView.builder(
                    itemCount: downloadViewModel.downloadedVideos.length,
                    itemBuilder: (context, index) {
                      String videoPath = downloadViewModel.downloadedVideos[index];
                      return VideoTile(videoPath: videoPath); // Assuming you have a VideoTile widget
                    },
                  ),
                ),
              ],
            );
          }
        },
      ),
    );
  }
}
