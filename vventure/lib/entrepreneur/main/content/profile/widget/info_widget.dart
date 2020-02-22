import 'package:flutter/material.dart';
import 'package:vventure/entrepreneur/main/common_models/info.dart';
import 'package:vventure/entrepreneur/main/content/profile/controller/communication.dart';

class InfoWidget extends StatefulWidget {
  final List<Info> info;
  final String id;
  final String token;
  final String type;
  final Function rebuild;
  final Function removeItem;

  InfoWidget(
      {Key key,
      @required this.info,
      @required this.id,
      @required this.type,
      @required this.token,
      @required this.rebuild,
      @required this.removeItem})
      : super(key: key);

  @override
  _InfoWidgetState createState() => _InfoWidgetState();
}

class _InfoWidgetState extends State<InfoWidget> {
  Color myColor = Color.fromRGBO(132, 94, 194, 1);
  TextEditingController title = new TextEditingController();
  TextEditingController description = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(top: 40),
          child: Text(
            "Information",
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
        ),
        FlatButton(
          onPressed: () {
            title.text = "";
            description.text = "";
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
        this.widget.info == null
            ? Text("")
            : Container(
                child: ListView.builder(
                  primary: false,
                  itemCount: this.widget.info.length,
                  shrinkWrap: true,
                  itemBuilder: (BuildContext context, int index) {
                    return Dismissible(
                      onDismissed: (DismissDirection direction) {
                        setState(() {
                          deleteInfo(this.widget.id, this.widget.token,
                              this.widget.type, this.widget.info[index].idInfo);
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
                              title.text = this.widget.info[index].title;
                              description.text =
                                  this.widget.info[index].content;
                            });
                            updateDialog(
                                context,
                                this.widget.id,
                                this.widget.token,
                                this.widget.info[index].idInfo);
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
                                    Column(
                                      mainAxisSize: MainAxisSize.min,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: <Widget>[
                                        Flexible(
                                          child: Text(
                                            this.widget.info[index].title,
                                            style: TextStyle(
                                                fontSize: 22,
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                        Flexible(
                                          child: Text(
                                            this.widget.info[index].content,
                                            style: TextStyle(
                                                fontSize: 24,
                                                color: Colors.black),
                                          ),
                                        )
                                      ],
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
                        "Add New Info",
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
                    padding: EdgeInsets.only(top: 20.0),
                    child: Center(
                      child: Text(
                        "Title",
                        style: TextStyle(fontSize: 24),
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    width: MediaQuery.of(context).size.width,
                    child: TextField(
                      controller: title,
                      cursorColor: Color.fromRGBO(132, 94, 194, 1),
                      style: TextStyle(
                          color: Color.fromRGBO(132, 94, 194, 1), fontSize: 20),
                      keyboardType: TextInputType.text,
                      decoration: new InputDecoration(
                        labelStyle: new TextStyle(
                            color: Color.fromRGBO(132, 94, 194, 1),
                            fontSize: 20),
                        focusedBorder: UnderlineInputBorder(
                            borderSide: new BorderSide(
                                color: Color.fromRGBO(132, 94, 194, 1))),
                      ),
                    ),
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
                        decoration: new InputDecoration(
                          labelStyle: new TextStyle(
                              color: Color.fromRGBO(132, 94, 194, 1),
                              fontSize: 20),
                          focusedBorder: UnderlineInputBorder(
                              borderSide: new BorderSide(
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
                          insertInfo(this.widget.id, this.widget.token,
                              title.text, description.text, this.widget.type);
                          Navigator.of(context, rootNavigator: true)
                              .pop('dialog');
                          setState(() {
                            widget.rebuild();
                          });
                        },
                        child: Text(
                          "Add Info",
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

  void updateDialog(context, String id, String token, String idInfo) {
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
                        "Add New Info",
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
                    padding: EdgeInsets.only(top: 20.0),
                    child: Center(
                      child: Text(
                        "Title",
                        style: TextStyle(fontSize: 24),
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    width: MediaQuery.of(context).size.width,
                    child: TextField(
                      controller: title,
                      cursorColor: Color.fromRGBO(132, 94, 194, 1),
                      style: TextStyle(
                          color: Color.fromRGBO(132, 94, 194, 1), fontSize: 20),
                      keyboardType: TextInputType.text,
                      decoration: new InputDecoration(
                        labelStyle: new TextStyle(
                            color: Color.fromRGBO(132, 94, 194, 1),
                            fontSize: 20),
                        focusedBorder: UnderlineInputBorder(
                            borderSide: new BorderSide(
                                color: Color.fromRGBO(132, 94, 194, 1))),
                      ),
                    ),
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
                        decoration: new InputDecoration(
                          labelStyle: new TextStyle(
                              color: Color.fromRGBO(132, 94, 194, 1),
                              fontSize: 20),
                          focusedBorder: UnderlineInputBorder(
                              borderSide: new BorderSide(
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
                          updateInfo(
                              this.widget.id,
                              this.widget.token,
                              this.widget.type,
                              title.text,
                              description.text,
                              idInfo);
                          Navigator.of(context, rootNavigator: true)
                              .pop('dialog');
                          setState(() {
                            widget.rebuild();
                          });
                        },
                        child: Text(
                          "Add Info",
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

  void insertInfo(
      String id, String token, String title, String detail, String type) {
    var future = Communication.insertInfo(id, token, title, detail, type);
    future.then((val) {});
  }

  void updateInfo(String id, String token, String type, String title,
      String detail, String idInfo) {
    var future =
        Communication.updateInfo(id, token, title, detail, type, idInfo);
    future.then((val) {});
  }

  void deleteInfo(String id, String token, String type, String idInfo) {
    var future = Communication.deleteInfo(id, token, type, idInfo);
    future.then((val) {});
  }
}
