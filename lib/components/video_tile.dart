import 'package:flutter/material.dart';
import 'package:movies/components/video_player.dart';
import 'dart:io';
import 'package:video_player/video_player.dart';

// Custom tile to show video thumbnail
class VideoTile extends StatefulWidget {
  final String videoPath;

  VideoTile({required this.videoPath});

  @override
  _VideoTileState createState() => _VideoTileState();
}

class _VideoTileState extends State<VideoTile> {
  late VideoPlayerController _controller;
  bool _isInitialized = false;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.file(File(widget.videoPath))
      ..initialize().then((_) {
        setState(() {
          _isInitialized = true; // Set initialized to true once video is ready
        });
      });
  }

  @override
  void dispose() {
    _controller.dispose(); // Dispose of the controller when not needed
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: _isInitialized
          ? AspectRatio(
        aspectRatio: _controller.value.aspectRatio,
        child: VideoPlayer(_controller), // Show video thumbnail
      )
          : Container(
        width: 100,
        height: 100,
        color: Colors.grey, // Placeholder while loading
        child: Icon(Icons.videocam, color: Colors.white),
      ),
      title: Text(' ${widget.videoPath.split('/').last}',maxLines: 2,
        overflow: TextOverflow.ellipsis,
        textAlign: TextAlign.start
        ,style: TextStyle(fontSize:15,),),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => VideoPlayerPage(videoPath: widget.videoPath),
          ),
        );
      },
    );
  }
}