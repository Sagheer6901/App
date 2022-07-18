import 'dart:async';

import 'package:flutter/material.dart';
import 'package:untitled/models/get_blogs.dart';
import 'package:untitled/screens/ProfilePopMenuScreens/BlogScreen/blog_detailed.dart';
import 'package:video_player/video_player.dart';

// void main() => runApp(VideoPlayerApp());

class VideoPlayerApp extends StatelessWidget {
  late final Blogs? item;
  VideoPlayerApp(this.item,{Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'GeeksForGeeks',
      home: VideoPlayerScreen(item),
    );
  }
}

class VideoPlayerScreen extends StatefulWidget {
  late final Blogs? item;

  VideoPlayerScreen(this.item,{Key? key}) : super(key: key);

  @override
  _VideoPlayerScreenState createState() => _VideoPlayerScreenState();
}

class _VideoPlayerScreenState extends State<VideoPlayerScreen> {
  late VideoPlayerController _controller;
  late Future<void> _initializeVideoPlayerFuture;

  @override
  void initState() {
    _controller = VideoPlayerController.network(
      'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4',
    );
    _initializeVideoPlayerFuture = _controller.initialize();

    _controller.setLooping(true);

    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('GeeksForGeeks'),
        backgroundColor: Colors.green,
      ),
      body: WillPopScope(
        onWillPop: () {
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => BlogDetailedScreen(
                item: widget.item,
              )),
                  (route) => false);
          return Future.value(false);
        },
        child: FutureBuilder(
          future: _initializeVideoPlayerFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return AspectRatio(
                aspectRatio: _controller.value.aspectRatio,
                child: VideoPlayer(_controller),
              );
            } else {
              return Center(child: CircularProgressIndicator());
            }
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            // pause
            if (_controller.value.isPlaying) {
              _controller.pause();
            } else {
              // play
              _controller.play();
            }
          });
        },
        // icon
        child: Icon(
          _controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
        ),
      ),
    );
  }
}
