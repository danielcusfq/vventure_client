import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:vventure/entrepreneur/main/content/profile/controller/communication.dart';
import 'package:vventure/entrepreneur/main/content/profile/widget/loading_widget.dart';

//widget that displays and updates profile image

class ProfileImageWidget extends StatefulWidget {
  final String image;
  final String id;
  final String token;
  final String type;
  final Function rebuild;
  ProfileImageWidget(
      {Key key,
      @required this.image,
      @required this.id,
      @required this.token,
      @required this.type,
      @required this.rebuild})
      : super(key: key);

  @override
  _ProfileImageWidgetState createState() => _ProfileImageWidgetState();
}

class _ProfileImageWidgetState extends State<ProfileImageWidget> {
  Color myColor = Color.fromRGBO(132, 94, 194, 1);
  File profileImageFile;
  bool _profileImageLoading = false;

  //main view for the widget
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Container(
            child: GestureDetector(
              onLongPress: () {
                dialog(context);
              },
              child: CircleAvatar(
                radius: MediaQuery.of(context).size.height / 7,
                backgroundImage: NetworkImage(widget.image),
                backgroundColor: Colors.transparent,
              ),
            ),
          )
        ],
      ),
    );
  }

  //dialog to update image
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
                        "Cambiar Imagen de Perfil",
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
                  _profileImageLoading == true
                      ? Center(
                          child: Container(
                              width: MediaQuery.of(context).size.width - 100,
                              height: MediaQuery.of(context).size.width - 100,
                              child: LoadingWidget()))
                      : Container(
                          height: MediaQuery.of(context).size.height / 3,
                          child: profileImageFile == null
                              ? Padding(
                                  padding: const EdgeInsets.all(40.0),
                                  child: Image.asset(
                                    'assets/images/add_profile_image.png',
                                    width: 150,
                                    height: 150,
                                  ),
                                )
                              : Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  mainAxisSize: MainAxisSize.min,
                                  children: <Widget>[
                                    CircleAvatar(
                                      radius:
                                          MediaQuery.of(context).size.height /
                                              7,
                                      backgroundImage:
                                          FileImage(profileImageFile),
                                      backgroundColor: Colors.transparent,
                                    )
                                  ],
                                ),
                        ),
                  _profileImageLoading == true
                      ? Container()
                      : FlatButton(
                          onPressed: () {
                            getImage();
                          },
                          child: Text(
                            "Seleccionar Imagen",
                            style: TextStyle(
                                fontSize: 20,
                                color: Color.fromRGBO(132, 94, 194, 1)),
                          ),
                        ),
                  _profileImageLoading == true
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
                                if (profileImageFile != null) {
                                  setState(() {
                                    _profileImageLoading = true;
                                  });
                                  Navigator.of(context, rootNavigator: true)
                                      .pop('dialog');
                                  dialog(context);
                                  insertProfileImage(
                                          this.widget.id,
                                          this.widget.token,
                                          profileImageFile,
                                          this.widget.type)
                                      .then((val) {
                                    setState(() {
                                      this.widget.rebuild();
                                    });
                                  });
                                }
                              },
                              child: Text(
                                "Cambiar",
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

  //functions that calls controller
  Future<bool> insertProfileImage(
      String id, String token, File image, String type) {
    var future = Communication.insertProfileImage(id, token, image, type);
    future.then((val) {
      Navigator.of(context, rootNavigator: true).pop('dialog');
    });
    return future;
  }

  Future getImage() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      profileImageFile = image;
    });
    Navigator.of(context, rootNavigator: true).pop('dialog');
    dialog(context);
  }
}
