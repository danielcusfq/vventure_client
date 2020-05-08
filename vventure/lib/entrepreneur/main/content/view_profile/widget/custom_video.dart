import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:flutter/services.dart';
import 'package:chewie/chewie.dart';

//this class displays user video

class CustomVideo extends StatefulWidget {
  final String video;
  CustomVideo({
    Key key,
    @required this.video,
  }) : super(key: key);

  @override
  _CustomVideoState createState() => _CustomVideoState();
}

class _CustomVideoState extends State<CustomVideo> {
  VideoPlayerController _videoPlayerController;
  ChewieController _chewieMainController;
  double _aspectRatio = 16 / 10;
  Color myColor = Color.fromRGBO(132, 94, 194, 1);

  @override
  initState() {
    super.initState();
    _videoPlayerController = VideoPlayerController.network(widget.video);
    _chewieMainController = ChewieController(
      allowedScreenSleep: false,
      allowFullScreen: true,
      deviceOrientationsAfterFullScreen: [
        DeviceOrientation.landscapeRight,
        DeviceOrientation.landscapeLeft,
        DeviceOrientation.portraitUp,
      ],
      videoPlayerController: _videoPlayerController,
      aspectRatio: _aspectRatio,
      autoInitialize: true,
      autoPlay: true,
      looping: true,
      showControls: true,
    );

    _chewieMainController.addListener(() {
      if (_chewieMainController.isFullScreen) {
        SystemChrome.setPreferredOrientations([
          DeviceOrientation.landscapeRight,
          DeviceOrientation.landscapeLeft,
        ]);
      }
    });

    setState(() {
      _aspectRatio = _videoPlayerController.value.aspectRatio;
    });
  }

  @override
  void dispose() {
    _videoPlayerController.dispose();
    _chewieMainController.dispose();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.portraitUp
    ]);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              child: GestureDetector(
                onDoubleTap: () {
                  if (!_chewieMainController.isFullScreen) {
                    _chewieMainController.enterFullScreen();
                  }
                },
                child: Chewie(
                  controller: _chewieMainController,
                ),
              ),
            )
          ],
        ),
      ],
    );
  }
}
