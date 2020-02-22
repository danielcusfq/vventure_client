import 'package:flutter/material.dart';
import 'package:snaplist/snaplist.dart';
import 'package:vventure/entrepreneur/main/common_models/work_image.dart';
import 'package:vventure/entrepreneur/main/content/profile/controller/communication.dart';

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

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(top: 30),
          child: Text(
            "My Work Images",
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
        ),
        FlatButton(
          onPressed: () {
            //dialog(context);
          },
          child: Column(
            children: <Widget>[
              Icon(
                Icons.add_circle_outline,
                color: myColor,
                size: 50.0,
              ),
              Text(
                "Add",
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
                          "Delete Image",
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
                            "Are You Sure You Want To Delete This Image?",
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
                              "Delete",
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
                              "Cancel",
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

  void deleteImage(String id, String token, String type, String idImage) {
    var future = Communication.deleteImage(id, token, type, idImage);
    future.then((val) {});
  }
}
