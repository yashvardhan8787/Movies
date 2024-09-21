import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:movies/components/toast_message.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart';

class Downloadvideoveiwmodel extends ChangeNotifier {
  String _statusMessage = "Download";
  List<String> downloadedVideos = [];

  String get status => _statusMessage;
  List<String> get videoPaths => downloadedVideos;

  Downloadvideoveiwmodel() {
    _loadDownloadedVideos();  // Load saved videos from shared_preferences when the app starts
  }

  void _checkPermissions() async {
    if (await Permission.storage.request().isGranted) {
      print('Storage permission granted');
    } else {
      print('Storage permission denied');
    }
  }

  void downloadVideo(String url , context) async {
    _checkPermissions();
    _statusMessage = "Downloading...";
    notifyListeners();

    var ytExplode = YoutubeExplode();

    try {
      var video = await ytExplode.videos.get(url);
      var manifest = await ytExplode.videos.streamsClient.getManifest(video.id);

      var videoStreamInfo = manifest.video.first;  // Choose the first video stream

      // Get streams
      var videoStream = ytExplode.videos.streamsClient.get(videoStreamInfo);

      // Save the streams to file
      await _saveStreamToFile(videoStream, video.title + '_video',context);

      ytExplode.close();
      _statusMessage = "Download";
      notifyListeners();
    } catch (e) {
      _statusMessage = "Download";
      notifyListeners();
      ToastMessage.flushBarMessage(e.toString(), context);
    }
  }

  Future<void> _saveStreamToFile(Stream<List<int>> stream, String fileName, context) async {
    final appDocDir = await getApplicationDocumentsDirectory();
    final savePath = '${appDocDir.path}/$fileName.mp4';

    final file = File(savePath);
    final sink = file.openWrite();

    await for (var data in stream) {
      sink.add(data);
    }

    await sink.flush();
    await sink.close();

    downloadedVideos.add(savePath);  // Store the file path of the saved video
    await _saveDownloadedVideos();
    ToastMessage.flushBarMessage("video downloaded successfully", context);
    // Save the updated list of video paths to shared_preferences
    notifyListeners();


  }

  // Save the list of downloaded videos to shared_preferences
  Future<void> _saveDownloadedVideos() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setStringList('downloadedVideos', downloadedVideos);
  }

  // Load the list of downloaded videos from shared_preferences
  Future<void> _loadDownloadedVideos() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    downloadedVideos = prefs.getStringList('downloadedVideos') ?? [];
    notifyListeners();
  }
}
