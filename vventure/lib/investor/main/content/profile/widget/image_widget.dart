import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:snaplist/snaplist.dart';
import 'package:vventure/investor/main/common_models/work_image.dart';
import 'package:vventure/investor/main/content/profile/controller/communication.dart';
import 'package:vventure/investor/main/content/profile/widget/loading_widget.dart';

class ImageWidget extends StatefulWidget {
  final List<WorkImage> images;
  final String id;
  final String token;
  final String type;
  final Function rebuild;
  final Function removeItem;

  ImageWidget(
      {Key key,
      @required this.images,
      @required this.id,
      @required this.token,
      @required this.type,
      @required this.rebuild,
      @required this.removeItem})
      : super(key: key);

  @override
  _ImageWidgetState createState() => _ImageWidgetState();
}

class _ImageWidgetState extends State<ImageWidget> {
  Color myColor = Color.fromRGBO(132, 94, 194, 1);
  File imageFile;
  bool _imageLoading = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(top: 60),
          child: Text(
            "Mis Imágenes de trabajo",
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
        ),
        FlatButton(
          onPressed: () {
            dialog(context);
          },
          child: Column(
            children: <Widget>[
              Icon(
                Icons.add_circle_outline,
                color: myColor,
                size: 50.0,
              ),
              Text(
                "Añadir",
                style: TextStyle(fontSize: 22),
              ),
            ],
          ),
        ),
        Container(
          width: MediaQuery.of(context).size.width - 50,
          height: MediaQuery.of(context).size.width - 50,
          child: SizedBox(
            height: double.infinity,
            width: double.infinity,
            child: SnapList(
                sizeProvider: (index, data) => Size(
                    MediaQuery.of(context).size.width - 50,
                    MediaQuery.of(context).size.width - 50),
                separatorProvider: (index, data) => Size(10.0, 10.0),
                builder: (context, index, data) => GestureDetector(
                      onLongPress: () {
                        delete(
                            context, this.widget.images[index].idImage, index);
                      },
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(25.0),
                        child: Stack(
                          children: <Widget>[
                            Center(
                              child: CircularProgressIndicator(
                                valueColor: AlwaysStoppedAnimation<Color>(
                                    Color.fromRGBO(255, 150, 113, 1)),
                              ),
                            ),
                            Center(
                              child: Image.network(
                                this.widget.images[index].image,
                                fit: BoxFit.fitWidth,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                count: this.widget.images.length),
          ),
        )
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
                        "Añadir Imagen de Trabajo",
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
                  _imageLoading == true
                      ? Center(
                          child: Container(
                              width: MediaQuery.of(context).size.width - 100,
                              height: MediaQuery.of(context).size.width - 100,
                              child: LoadingWidget()))
                      : Container(
                          height: MediaQuery.of(context).size.height / 3,
                          child: imageFile == null
                              ? Padding(
                                  padding: const EdgeInsets.all(40.0),
                                  child: Image.asset(
                                    'assets/images/add_profile_image.png',
                                    width: 150,
                                    height: 150,
                                  ),
                                )
                              : Container(
                                  height: MediaQuery.of(context).size.width / 2,
                                  width: MediaQuery.of(context).size.width / 2,
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      image: DecorationImage(
                                          image: FileImage(imageFile),
                                          fit: BoxFit.fill)),
                                ),
                        ),
                  _imageLoading == true
                      ? Container()
                      : FlatButton(
                          onPressed: () {
                            getImage();
                          },
                          child: Text(
                            "Agregar Imagen de Trabajo",
                            style: TextStyle(
                                fontSize: 20,
                                color: Color.fromRGBO(132, 94, 194, 1)),
                          ),
                        ),
                  _imageLoading == true
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
                                if (imageFile != null) {
                                  setState(() {
                                    _imageLoading = true;
                                  });
                                  Navigator.of(context, rootNavigator: true)
                                      .pop('dialog');
                                  dialog(context);
                                  insertImage(this.widget.id, this.widget.token,
                                          imageFile, this.widget.type)
                                      .then((val) {
                                    setState(() {
                                      this.widget.rebuild();
                                    });
                                  });
                                }
                              },
                              child: Text(
                                "Añadir",
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

  void delete(context, String image, int index) {
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
                          "Eliminar Imagen",
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
                    Padding(
                      padding: EdgeInsets.only(top: 20),
                      child: Center(
                        child: Padding(
                          padding: EdgeInsets.all(10.0),
                          child: Text(
                            "¿Estás Seguro de que Quieres Eliminar Esta Imagen?",
                            style: TextStyle(fontSize: 24),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 50, bottom: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          FlatButton(
                            onPressed: () {
                              deleteImage(this.widget.id, this.widget.token,
                                  this.widget.type, image);
                              Navigator.of(context, rootNavigator: true)
                                  .pop('dialog');
                              setState(() {
                                widget.removeItem(index);
                              });
                            },
                            child: Text(
                              "Eliminar",
                              style: TextStyle(fontSize: 24, color: Colors.red),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          FlatButton(
                            onPressed: () {
                              Navigator.of(context, rootNavigator: true)
                                  .pop('dialog');
                            },
                            child: Text(
                              "Cancelar",
                              style:
                                  TextStyle(fontSize: 24, color: Colors.black),
                              textAlign: TextAlign.center,
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ));
        });
  }

  Future<bool> insertImage(String id, String token, File image, String type) {
    var future = Communication.insertImage(id, token, image, type);
    future.then((val) {
      Navigator.of(context, rootNavigator: true).pop('dialog');
    });
    return future;
  }

  void deleteImage(String id, String token, String type, String idImage) {
    var future = Communication.deleteImage(id, token, type, idImage);
    future.then((val) {});
  }

  Future getImage() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      imageFile = image;
    });
    Navigator.of(context, rootNavigator: true).pop('dialog');
    dialog(context);
  }
}
