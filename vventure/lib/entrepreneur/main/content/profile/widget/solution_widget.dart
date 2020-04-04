import 'package:flutter/material.dart';
import 'package:vventure/entrepreneur/main/content/profile/controller/communication.dart';

class SolutionWidget extends StatefulWidget {
  final String solution;
  final String id;
  final String token;
  final String type;
  final Function rebuild;
  SolutionWidget(
      {Key key,
      @required this.solution,
      @required this.id,
      @required this.token,
      @required this.type,
      @required this.rebuild})
      : super(key: key);
  @override
  _SolutionWidgetState createState() => _SolutionWidgetState();
}

class _SolutionWidgetState extends State<SolutionWidget> {
  Color myColor = Color.fromRGBO(132, 94, 194, 1);
  TextEditingController solution = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
      child: GestureDetector(
        onLongPress: () {
          solution.text = widget.solution;
          updateDialog(context);
        },
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                "Así es como estás resolviendo el problema",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              Text(
                this.widget.solution,
                style: TextStyle(fontSize: 24),
                textAlign: TextAlign.center,
              )
            ],
          ),
        ),
      ),
    );
  }

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
                        "Editar Solución",
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
                        "Solución",
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
                        controller: solution,
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
                          updateSolution(this.widget.id, this.widget.token,
                              this.widget.type, solution.text);
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

  void updateSolution(String id, String token, String type, String solution) {
    var future = Communication.updateSolution(id, token, type, solution);
    future.then((val) {});
  }
}
