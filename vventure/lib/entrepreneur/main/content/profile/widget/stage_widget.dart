import 'package:flutter/material.dart';
import 'package:vventure/entrepreneur/main/content/profile/controller/communication.dart';

class StageWidget extends StatefulWidget {
  final stage;
  final String id;
  final String token;
  final String type;
  final Function rebuild;

  StageWidget(
      {Key key,
      @required this.stage,
      @required this.id,
      @required this.token,
      @required this.type,
      @required this.rebuild})
      : super(key: key);
  @override
  _StageWidgetState createState() => _StageWidgetState();
}

class _StageWidgetState extends State<StageWidget> {
  Color myColor = Color.fromRGBO(132, 94, 194, 1);
  List<String> _dropItems = ["Concepto", "Prototipo", "Producción", "Escalar"];
  String stage = "";

  @override
  void initState() {
    super.initState();
    setState(() {
      stage = widget.stage.toString();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 20),
      child: GestureDetector(
        onLongPress: () {
          updateDialog(context);
        },
        child: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "Etapa del Proyecto",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            Text(
              this.widget.stage,
              style: TextStyle(fontSize: 22),
            ),
          ],
        )),
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
                        "¿Cuál es la Etapa de tu Proyecto?",
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
                    padding: EdgeInsets.only(top: 20, bottom: 20),
                    child: Center(
                      child: DropdownButton<String>(
                          items: _dropItems.map((String val) {
                            return DropdownMenuItem<String>(
                              value: val,
                              child: Center(
                                  child: Text(
                                val,
                                style: TextStyle(fontSize: 24),
                              )),
                            );
                          }).toList(),
                          hint: stage.isNotEmpty
                              ? Text(
                                  stage,
                                  style: TextStyle(fontSize: 24),
                                )
                              : Text("Selecciona la Etapa de tu Proyecto"),
                          onChanged: (val) {
                            stage = val;
                            setState(() {
                              stage = val;
                            });
                            Navigator.of(context, rootNavigator: true)
                                .pop('dialog');
                            updateDialog(context);
                          }),
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
                          updateStage(this.widget.id, this.widget.token,
                              this.widget.type, stage);
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

  void updateStage(String id, String token, String type, String stage) {
    var future = Communication.updateStage(id, token, type, stage);
    future.then((val) {});
  }
}
