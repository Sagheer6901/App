import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:untitled/functions/app_config.dart';
import 'package:untitled/models/get_blogs.dart';
import 'package:untitled/screens/ProfilePopMenuScreens/BlogScreen/flick_player.dart';
import 'package:untitled/screens/ProfilePopMenuScreens/BlogScreen/video_player.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:video_player/video_player.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';

class BlogDetailedCard extends StatefulWidget {
  final Blogs? item;
  final Future<List<Blogs>>? products;
  BlogDetailedCard({Key? key, this.products, this.item}) : super(key: key);

  @override
  State<BlogDetailedCard> createState() => _BlogDetailedCardState();
}

class _BlogDetailedCardState extends State<BlogDetailedCard> {
  final DateFormat? formatter = DateFormat('yyyy-MM-dd');

  late AppConfig _appConfig;
  // late VideoPlayerController _controller;
  // late Future<void> _initializeVideoPlayerFuture;
  //
  // @override
  // void initState() {
  //   _controller = Youtube
  //   _initializeVideoPlayerFuture = _controller.initialize();
  //
  //   _controller.setLooping(true);
  //
  //   super.initState();
  // }
  //
  // @override
  // void dispose() {
  //   _controller.dispose();
  //
  //   super.dispose();
  // }
  late YoutubePlayerController _controller;
  /// If videoId is passed as url then no conversion is done.
  static String? convertUrlToId(String url, {bool trimWhitespaces = true}) {
    if (!url.contains("http") && (url.length == 11)) return url;
    if (trimWhitespaces) url = url.trim();

    for (var exp in [
      RegExp(
          r"^https:\/\/(?:www\.|m\.)?youtube\.com\/watch\?v=([_\-a-zA-Z0-9]{11}).*$"),
      RegExp(
          r"^https:\/\/(?:www\.|m\.)?youtube(?:-nocookie)?\.com\/embed\/([_\-a-zA-Z0-9]{11}).*$"),
      RegExp(r"^https:\/\/youtu\.be\/([_\-a-zA-Z0-9]{11}).*$")
    ]) {
      Match? match = exp.firstMatch(url);
      if (match != null && match.groupCount >= 1) return match.group(1);
    }

    return null;
  }
  @override
  void initState() {
    super.initState();
    var id =convertUrlToId("${widget.item!.yt}");
    _controller = YoutubePlayerController(
      initialVideoId: '$id',
      params:  YoutubePlayerParams(
        playlist: [
          '$id',
        ],
        startAt: const Duration(minutes: 1, seconds: 36),
        showControls: true,
        showFullscreenButton: true,
        desktopMode: false,
        privacyEnhanced: true,
        useHybridComposition: true,
      ),
    );
    _controller.onEnterFullscreen = () {
      SystemChrome.setPreferredOrientations([
        DeviceOrientation.landscapeLeft,
        DeviceOrientation.landscapeRight,
      ]);
      log('Entered Fullscreen');
    };
    _controller.onExitFullscreen = () {
      log('Exited Fullscreen');
    };
  }
  @override
  void dispose() {
    _controller.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const player = YoutubePlayerIFrame();

    _appConfig = AppConfig(context);

    final String formatted = formatter!.format(widget.item!.date!);
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: Column(
        children: [
          Container(
              alignment: Alignment.topLeft,
              child: Text(
                "${widget.item!.title}",
                style: TextStyle(
                    fontWeight: FontWeight.bold, fontSize: AppConfig.f1,fontFamily: AppConfig.fontFamilyRegular),textScaleFactor: 1,
              )),
          Divider(
            height: 30,
            thickness: 1,
          ),
          SizedBox(
            height: _appConfig.rH(1),
          ),

          Stack(
            children: [
              Container(
                height: _appConfig.rH(25),
                  decoration: BoxDecoration(
                    // color: AppConfig.primaryColor,
                    borderRadius: const BorderRadius.all(Radius.circular(30)),
                  ),
                  child: ClipRRect(
                    borderRadius: const BorderRadius.all(
                      Radius.circular(20),
                    ),
                    child: YoutubePlayerControllerProvider(
                      // Passing controller to widgets below.
                      controller: _controller,
                      child: Scaffold(
                        body: LayoutBuilder(
                          builder: (context, constraints) {
                            if (kIsWeb && constraints.maxWidth > 800) {

                              return Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Expanded(child: player),
                                  // const SizedBox(
                                  //   width: 500,
                                  //   child: SingleChildScrollView(
                                  //     child: Controls(),
                                  //   ),
                                  // ),
                                ],
                              );
                            }
                            return ListView(
                              children: [
                                Stack(
                                  children: [
                                    Container(
                                        height: _appConfig.rH(25),
                                        child: player),
                                    Positioned.fill(
                                      child: YoutubeValueBuilder(
                                        controller: _controller,
                                        builder: (context, value) {
                                          return AnimatedCrossFade(
                                            firstChild: const SizedBox.shrink(),
                                            secondChild: Material(
                                              child: DecoratedBox(
                                                decoration: BoxDecoration(
                                                  image: DecorationImage(
                                                    image: NetworkImage(
                                                      YoutubePlayerController.getThumbnail(
                                                        videoId:
                                                        _controller.params.playlist.first,
                                                        quality: ThumbnailQuality.medium,
                                                      ),
                                                    ),
                                                    fit: BoxFit.fitWidth,
                                                  ),
                                                ),
                                                child: const Center(
                                                  child: CircularProgressIndicator(),
                                                ),
                                              ),
                                            ),
                                            crossFadeState: value.isReady
                                                ? CrossFadeState.showFirst
                                                : CrossFadeState.showSecond,
                                            duration: const Duration(milliseconds: 300),
                                          );
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                                // const Controls(),
                              ],
                            );
                          },
                        ),
                      ),
                    ),
                    // child: FutureBuilder(
                    //   future: _initializeVideoPlayerFuture,
                    //   builder: (context, snapshot) {
                    //     if (snapshot.connectionState == ConnectionState.done) {
                    //       return AspectRatio(
                    //         aspectRatio: _controller.value.aspectRatio,
                    //         child: VideoPlayer(_controller),
                    //       );
                    //     } else {
                    //       return Center(child: CircularProgressIndicator());
                    //     }
                    //   },
                    // ),
                  )),
              // Positioned(
              //   left: 5,
              //   bottom: 0,
              //   child: FloatingActionButton(
              //     backgroundColor: Colors.transparent,
              //     hoverColor: Colors.transparent,
              //     onPressed: () {
              //       setState(() {
              //         // pause
              //         if (_controller.value.isPlaying) {
              //           _controller.pause();
              //         } else {
              //           // play
              //           _controller.play();
              //         }
              //       });
              //     },
              //     // icon
              //     child: Icon(
              //       _controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
              //     ),
              //   ),
              // ),
            ],
          ),
          //  IconButton(
          //   icon: Icon(
          //     Icons.video_collection,
          //     color: Colors.red,
          //     size: 40,
          //   ),
          //   onPressed: () {
          //     Navigator.of(context).pushReplacement(
          //       MaterialPageRoute(
          //           builder: (context) => YoutubeAppDemo()),
          //     );
          //     // _launchUrl();
          //   },
          // ),
          SizedBox(
            height: _appConfig.rH(2),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(
                    Icons.supervised_user_circle,
                    size: 20,
                    color: AppConfig.textColor,
                  ),
                  Text(
                    "by author",
                    style: TextStyle(color: AppConfig.textColor,fontFamily: AppConfig.fontFamilyRegular),textScaleFactor: 1,
                  ),
                  Text(
                    "Traboon",
                    style: TextStyle(color: AppConfig.carColor,fontFamily: AppConfig.fontFamilyMedium),textScaleFactor: 1,
                  ),
                ],
              ),
              Text("$formatted",style: TextStyle(fontFamily: AppConfig.fontFamilyRegular),textScaleFactor: 1,)
            ],
          ),
          Divider(
            height: 20,
            thickness: 1,
          ),
          Align(alignment:Alignment.topLeft,child: Container(child: Text("${widget.item!.description}",style: TextStyle(fontFamily: AppConfig.fontFamilyRegular),textScaleFactor: 1,))),
          SizedBox(
            height: _appConfig.rH(2),
          ),
          // Container(
          //   height: 300,
          //   child: VideoPlayerScreen(),
          // )
        ],
      ),
    );
  }
}
