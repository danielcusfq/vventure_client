import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:path_provider/path_provider.dart';

class DownloadProfileWidget extends StatefulWidget {
  final String id;
  final String token;
  final TargetPlatform platform;
  DownloadProfileWidget(
      {Key key,
      @required this.id,
      @required this.token,
      @required this.platform})
      : super(key: key);
  @override
  _DownloadProfileWidgetState createState() => _DownloadProfileWidgetState();
}

class _DownloadProfileWidgetState extends State<DownloadProfileWidget> {
  Directory _downloadsDirectory;
  Color secondary = Color.fromRGBO(255, 150, 113, 1);
  bool _permissionReady;

  @override
  void initState() {
    super.initState();
    WidgetsFlutterBinding.ensureInitialized();
    FlutterDownloader.initialize();
    initDownloadsDirectoryState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          RaisedButton(
            onPressed: () {
              _checkPermission().then((hasGranted) {
                setState(() {
                  _permissionReady = hasGranted;
                });
                if (_permissionReady == true) {
                  download(widget.id, widget.token);
                } else {
                  print("grant Permision first");
                }
              });
            },
            child: Text(
              'Descargar Perfil',
              style: TextStyle(fontSize: 22),
            ),
            color: secondary,
            textColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: new BorderRadius.circular(25.0),
            ),
            padding: EdgeInsets.all(16),
          )
        ],
      ),
    );
  }

  Future<Null> download(String id, String token) async {
    String path = _downloadsDirectory.path;

    id = "&id=" + id;
    token = "&token=" + token;

    String url =
        "https://vventure.tk/investor/profile/download/profile/?auth=b4168ab5b11fdb0808e51ce69279566e56a63800a8430aa4555177a17fc8178b" +
            id +
            token;

    await FlutterDownloader.enqueue(
      url: url,
      savedDir: path,
      fileName: "profile.pdf",
      showNotification: true,
      openFileFromNotification: true,
    );
  }

  Future<bool> _checkPermission() async {
    if (widget.platform == TargetPlatform.android) {
      PermissionStatus permission = await PermissionHandler()
          .checkPermissionStatus(PermissionGroup.storage);
      if (permission != PermissionStatus.granted) {
        Map<PermissionGroup, PermissionStatus> permissions =
            await PermissionHandler()
                .requestPermissions([PermissionGroup.storage]);
        if (permissions[PermissionGroup.storage] == PermissionStatus.granted) {
          return true;
        }
      } else {
        return true;
      }
    } else {
      return true;
    }
    return false;
  }

  Future<void> initDownloadsDirectoryState() async {
    Directory downloadsDirectory;
    downloadsDirectory = widget.platform == TargetPlatform.android
        ? await getExternalStorageDirectory()
        : await getApplicationDocumentsDirectory();

    setState(() {
      _downloadsDirectory = downloadsDirectory;
    });
  }
}
