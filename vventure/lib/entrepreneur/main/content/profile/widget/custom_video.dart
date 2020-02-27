import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:video_player/video_player.dart';
import 'package:flutter/services.dart';
import 'package:chewie/chewie.dart';
import 'package:vventure/entrepreneur/main/content/profile/controller/communication.dart';
import 'package:vventure/entrepreneur/main/content/profile/widget/loading_widget.dart';

class CustomVideo extends StatefulWidget {
  final String id;
  final String token;
  final String type;
  final String video;
  final Function rebuild;

  CustomVideo(
      {Key key,
      @required this.video,
      @required this.rebuild,
      @required this.id,
      @required this.token,
      @required this.type})
      : super(key: key);

  @override
  _CustomVideoState createState() => _CustomVideoState();
}

class _CustomVideoState extends State<CustomVideo> {
  VideoPlayerController _videoPlayerController;
  ChewieController _chewieMainController;
  double _aspectRatio = 16 / 10;
  File _newVideo;
  bool _videoLoading = false;
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
                onLongPress: () {
                  dialog(context);
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

  void dialog(context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(32.0))),
            contentPadding: EdgeInsets.only(top: 10.0),
            content: Container(
              width: MediaQuery.of(context).size.width - 50,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Text(
                        "Update Video",
                        style: TextStyle(fontSize: 24.0),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 5.0,
                  ),
                  Divider(
                    color: Colors.grey,
                    height: 4.0,
                  ),
                  _videoLoading == true
                      ? Center(
                          child: Container(
                              width: MediaQuery.of(context).size.width - 100,
                              height: MediaQuery.of(context).size.width - 100,
                              child: LoadingWidget()))
                      : Container(
                          height: MediaQuery.of(context).size.height / 4,
                          child: _newVideo == null
                              ? Padding(
                                  padding: const EdgeInsets.all(40.0),
                                  child: Image.asset(
                                    'assets/images/add_video.png',
                                    width: 150,
                                    height: 150,
                                  ),
                                )
                              : Container(
                                  child: Center(
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      mainAxisSize: MainAxisSize.min,
                                      children: <Widget>[
                                        Flexible(
                                          child: Text(
                                            _newVideo.path.split("/").last,
                                            style: TextStyle(fontSize: 24),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                )),
                  _videoLoading == true
                      ? Container()
                      : FlatButton(
                          onPressed: () {
                            getVideo();
                          },
                          child: Text(
                            "Select Video",
                            style: TextStyle(
                                fontSize: 20,
                                color: Color.fromRGBO(132, 94, 194, 1)),
                          ),
                        ),
                  _videoLoading == true
                      ? Container()
                      : InkWell(
                          child: Container(
                            padding: EdgeInsets.only(top: 20.0, bottom: 20.0),
                            decoration: BoxDecoration(
                              color: myColor,
                              borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(32.0),
                                  bottomRight: Radius.circular(32.0)),
                            ),
                            child: FlatButton(
                              onPressed: () {
                                if (_newVideo != null) {
                                  setState(() {
                                    _videoLoading = true;
                                  });
                                  Navigator.of(context, rootNavigator: true)
                                      .pop('dialog');
                                  dialog(context);
                                  insertVideo(this.widget.id, this.widget.token,
                                          _newVideo, this.widget.type)
                                      .then((val) {
                                    setState(() {
                                      this.widget.rebuild();
                                    });
                                  });
                                }
                              },
                              child: Text(
                                "Upload Video",
                                style: TextStyle(
                                    fontSize: 24, color: Colors.white),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                        ),
                ],
              ),
            ),
          );
        });
  }

  Future getVideo() async {
    var selectedVideo =
        await ImagePicker.pickVideo(source: ImageSource.gallery);
    setState(() {
      _newVideo = selectedVideo;
    });
    Navigator.of(context, rootNavigator: true).pop('dialog');
    dialog(context);
  }

  Future<bool> insertVideo(String id, String token, File video, String type) {
    var future = Communication.insertVideo(id, token, video, type);
    future.then((val) {
      Navigator.of(context, rootNavigator: true).pop('dialog');
    });
    return future;
  }
}
