import 'package:flutter/material.dart';
import 'package:vventure/investor/main/content/inspection/controller/communication.dart';

class InspectionFeedbackWidget extends StatefulWidget {
  final String id;
  final String token;
  final String entrepreneur;
  final String inspection;
  final Function navigation;
  InspectionFeedbackWidget(
      {Key key,
      @required this.id,
      @required this.token,
      @required this.entrepreneur,
      @required this.inspection,
      @required this.navigation})
      : super(key: key);

  @override
  _InspectionFeedbackWidgetState createState() =>
      _InspectionFeedbackWidgetState();
}

class _InspectionFeedbackWidgetState extends State<InspectionFeedbackWidget> {
  Color myColor = Color.fromRGBO(132, 94, 194, 1);
  Color secondary = Color.fromRGBO(255, 150, 113, 1);
  TextEditingController description = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Expanded(
            child: RaisedButton(
              onPressed: () {
                delete(context);
              },
              child: Text(
                'Negar Retroalimentación',
                style: TextStyle(fontSize: 22),
              ),
              color: secondary,
              textColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: new BorderRadius.circular(25.0),
              ),
              padding: EdgeInsets.all(16),
            ),
          ),
          SizedBox(
            width: 10,
          ),
          Expanded(
            child: RaisedButton(
              onPressed: () {
                feedback(context);
              },
              child: Text(
                'Dar Retroalimentación',
                style: TextStyle(fontSize: 22),
              ),
              color: secondary,
              textColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: new BorderRadius.circular(25.0),
              ),
              padding: EdgeInsets.all(16),
            ),
          )
        ],
      ),
    );
  }

  void feedback(context) {
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
                        "Dar Retroalimentación",
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
                        "Retroalimentación",
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
                          giveFeedback(widget.inspection, widget.entrepreneur,
                              widget.id, widget.token, description.text);
                          Navigator.of(context, rootNavigator: true)
                              .pop('dialog');
                          widget.navigation();
                        },
                        child: Text(
                          "Dar",
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

  void delete(context) {
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
                          "Negar Retroalimentación",
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
                            "¿Estás Seguro de que Deseas Negar la Retroalimentación?",
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
                              deny(widget.inspection, widget.entrepreneur,
                                      widget.id, widget.token)
                                  .then((val) {
                                Navigator.of(context, rootNavigator: true)
                                    .pop('dialog');
                                widget.navigation();
                              });
                            },
                            child: Text(
                              "Negar",
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

  Future<String> deny(
      String inspection, String entrepreneur, String id, String token) async {
    var future =
        await Communication.denyInspection(inspection, entrepreneur, id, token);
    return future;
  }

  Future<String> giveFeedback(String inspection, String entrepreneur, String id,
      String token, String description) async {
    var future = await Communication.giveFeedback(
        inspection, entrepreneur, id, token, description);
    return future;
  }
}
