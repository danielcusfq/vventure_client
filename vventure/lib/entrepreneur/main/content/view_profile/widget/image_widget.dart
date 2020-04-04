import 'dart:io';
import 'package:flutter/material.dart';
import 'package:snaplist/snaplist.dart';
import 'package:vventure/entrepreneur/main/common_models/work_image.dart';

class ImageWidget extends StatefulWidget {
  final List<WorkImage> images;

  ImageWidget({
    Key key,
    @required this.images,
  }) : super(key: key);

  @override
  _ImageWidgetState createState() => _ImageWidgetState();
}

class _ImageWidgetState extends State<ImageWidget> {
  Color myColor = Color.fromRGBO(132, 94, 194, 1);
  File imageFile;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(top: 60),
          child: Text(
            "Imágenes de trabajo",
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
        ),
        this.widget.images == null || this.widget.images.isEmpty == true
            ? Container(
                child: Center(
                  child: Text("No hay Imágenes por el Momento"),
                ),
              )
            : Container(
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
                      builder: (context, index, data) => ClipRRect(
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
                      count: this.widget.images.length),
                  key: UniqueKey(),
                ),
              )
      ],
    );
  }
}
