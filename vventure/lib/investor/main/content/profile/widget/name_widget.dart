import 'package:flutter/material.dart';
import 'package:vventure/investor/main/content/profile/controller/communication.dart';

//displays user name

class NameWidget extends StatefulWidget {
  final String name;
  final String last;
  final String id;
  final String token;
  final String type;
  final Function rebuild;

  NameWidget(
      {Key key,
      @required this.name,
      @required this.last,
      @required this.id,
      @required this.token,
      @required this.type,
      @required this.rebuild})
      : super(key: key);

  @override
  _NameWidgetState createState() => _NameWidgetState();
}

class _NameWidgetState extends State<NameWidget> {
  Color myColor = Color.fromRGBO(132, 94, 194, 1);
  String fullName;
  TextEditingController name = new TextEditingController();
  TextEditingController lastName = new TextEditingController();

  //init widget info
  @override
  void initState() {
    super.initState();
    setState(() {
      fullName = this.widget.name + " " + this.widget.last;
    });
  }

  //main view for user
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 20),
      child: GestureDetector(
        onLongPress: () {
          name.text = widget.name;
          lastName.text = widget.last;
          updateDialog(context);
        },
        child: Center(
            child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text("Representado Por",
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
              Text(
                fullName,
                style: TextStyle(fontSize: 26),
              )
            ],
          ),
        )),
      ),
    );
  }

  //popup dialog to update name
  void updateDialog(context) {
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
                        "Editar Nombre",
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
                        "Nombre",
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
                        controller: name,
                        cursorColor: Color.fromRGBO(132, 94, 194, 1),
                        style: TextStyle(
                            color: Color.fromRGBO(132, 94, 194, 1),
                            fontSize: 20),
                        keyboardType: TextInputType.text,
                        minLines: 1,
                        maxLines: 1,
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
                  Padding(
                    padding: EdgeInsets.only(top: 20),
                    child: Center(
                      child: Text(
                        "Apellido",
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
                        controller: lastName,
                        cursorColor: Color.fromRGBO(132, 94, 194, 1),
                        style: TextStyle(
                            color: Color.fromRGBO(132, 94, 194, 1),
                            fontSize: 20),
                        keyboardType: TextInputType.text,
                        minLines: 1,
                        maxLines: 1,
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
                          updateName(this.widget.id, this.widget.token,
                              this.widget.type, name.text, lastName.text);
                          Navigator.of(context, rootNavigator: true)
                              .pop('dialog');
                          setState(() {
                            widget.rebuild();
                          });
                        },
                        child: Text(
                          "Editar",
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

  //calls controller
  void updateName(
      String id, String token, String type, String name, String lastName) {
    var future = Communication.updateName(id, token, type, name, lastName);
    future.then((val) {});
  }
}
