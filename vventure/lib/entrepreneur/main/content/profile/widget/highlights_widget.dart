import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:vventure/entrepreneur/main/common_models/highlight.dart';
import 'package:vventure/entrepreneur/main/content/profile/controller/communication.dart';

class HighlightsWidget extends StatefulWidget {
  final List<Highlight> highlights;
  final String id;
  final String token;
  final String type;
  final Function rebuild;
  final Function removeItem;

  HighlightsWidget(
      {Key key,
      @required this.highlights,
      @required this.id,
      @required this.token,
      @required this.type,
      @required this.rebuild,
      @required this.removeItem})
      : super(key: key);
  @override
  _HighlightsWidgetState createState() => _HighlightsWidgetState();
}

class _HighlightsWidgetState extends State<HighlightsWidget> {
  Color myColor = Color.fromRGBO(132, 94, 194, 1);
  TextEditingController description = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Text(
          "Highlights",
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        FlatButton(
          onPressed: () {
            setState(() {
              description.text = "";
            });
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
                "Add",
                style: TextStyle(fontSize: 22),
              ),
            ],
          ),
        ),
        this.widget.highlights == null
            ? Text("")
            : Container(
                child: ListView.builder(
                  primary: false,
                  itemCount: this.widget.highlights.length,
                  shrinkWrap: true,
                  itemBuilder: (BuildContext context, int index) {
                    return Dismissible(
                      onDismissed: (DismissDirection direction) {
                        setState(() {
                          deleteHighlight(
                              this.widget.id,
                              this.widget.token,
                              this.widget.type,
                              this.widget.highlights[index].idHighlight);
                          this.widget.removeItem(index);
                        });
                      },
                      secondaryBackground: Container(
                        decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius:
                                BorderRadius.all(Radius.circular(25))),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              'Delete',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 22),
                            ),
                            Icon(
                              Icons.delete,
                              color: Colors.white,
                            )
                          ],
                        ),
                      ),
                      background: Container(),
                      child: Container(
                        child: GestureDetector(
                          onLongPress: () {
                            setState(() {
                              description.text =
                                  this.widget.highlights[index].detail;
                            });
                            updateDialog(
                                context,
                                this.widget.id,
                                this.widget.token,
                                this.widget.highlights[index].idHighlight,
                                this.widget.highlights[index].detail);
                          },
                          child: Card(
                              elevation: 1,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30.0),
                              ),
                              child: Container(
                                width: MediaQuery.of(context).size.width,
                                padding: EdgeInsets.all(16.0),
                                constraints: BoxConstraints(maxHeight: 250),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  mainAxisSize: MainAxisSize.min,
                                  children: <Widget>[
                                    Flexible(
                                      child: Text(
                                        this.widget.highlights[index].detail,
                                        style: TextStyle(
                                            fontSize: 24, color: Colors.black),
                                      ),
                                    )
                                  ],
                                ),
                              )),
                        ),
                      ),
                      key: UniqueKey(),
                      direction: DismissDirection.endToStart,
                    );
                  },
                ),
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
                        "Add New Highlight",
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
                      child: Text(
                        "Description",
                        style: TextStyle(fontSize: 24),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(bottom: 20),
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      width: MediaQuery.of(context).size.width,
                      child: TextField(
                        controller: description,
                        cursorColor: Color.fromRGBO(132, 94, 194, 1),
                        style: TextStyle(
                            color: Color.fromRGBO(132, 94, 194, 1),
                            fontSize: 20),
                        keyboardType: TextInputType.text,
                        minLines: 3,
                        maxLines: 3,
                        decoration: InputDecoration(
                          labelStyle: TextStyle(
                              color: Color.fromRGBO(132, 94, 194, 1),
                              fontSize: 20),
                          focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                  color: Color.fromRGBO(132, 94, 194, 1))),
                        ),
                      ),
                    ),
                  ),
                  InkWell(
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
                          insertHighlight(this.widget.id, this.widget.token,
                              description.text, this.widget.type);
                          Navigator.of(context, rootNavigator: true)
                              .pop('dialog');
                          setState(() {
                            widget.rebuild();
                          });
                        },
                        child: Text(
                          "Add Highlight",
                          style: TextStyle(fontSize: 24, color: Colors.white),
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

  void updateDialog(
      context, String id, String token, String idHighlight, String detail) {
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
                        "Update Highlight",
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
                      child: Text(
                        "Description",
                        style: TextStyle(fontSize: 24),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(bottom: 20),
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      width: MediaQuery.of(context).size.width,
                      child: TextField(
                        controller: description,
                        cursorColor: Color.fromRGBO(132, 94, 194, 1),
                        style: TextStyle(
                            color: Color.fromRGBO(132, 94, 194, 1),
                            fontSize: 20),
                        keyboardType: TextInputType.text,
                        minLines: 3,
                        maxLines: 3,
                        decoration: InputDecoration(
                          labelStyle: TextStyle(
                              color: Color.fromRGBO(132, 94, 194, 1),
                              fontSize: 20),
                          focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                  color: Color.fromRGBO(132, 94, 194, 1))),
                        ),
                      ),
                    ),
                  ),
                  InkWell(
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
                          updateHighlight(this.widget.id, this.widget.token,
                              this.widget.type, description.text, idHighlight);
                          Navigator.of(context, rootNavigator: true)
                              .pop('dialog');
                          setState(() {
                            widget.rebuild();
                          });
                        },
                        child: Text(
                          "Update Highlight",
                          style: TextStyle(fontSize: 24, color: Colors.white),
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

  void insertHighlight(String id, String token, String detail, String type) {
    var future = Communication.insertHighlight(id, token, detail, type);
    future.then((val) {});
  }

  void updateHighlight(
      String id, String token, String type, String detail, String idHighlight) {
    var future =
        Communication.updateHighlight(id, token, detail, type, idHighlight);
    future.then((val) {});
  }

  void deleteHighlight(
      String id, String token, String type, String idHighlight) {
    var future = Communication.deleteHighlight(id, token, type, idHighlight);
    future.then((val) {});
  }
}
