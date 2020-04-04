import 'package:flutter/material.dart';
import 'package:vventure/entrepreneur/main/content/view_profile/controller/comunication.dart';

class InspectionWidget extends StatefulWidget {
  final String investor;
  final String id;
  final String token;
  InspectionWidget(
      {Key key,
      @required this.investor,
      @required this.id,
      @required this.token})
      : super(key: key);
  @override
  _InspectionWidgetState createState() => _InspectionWidgetState();
}

class _InspectionWidgetState extends State<InspectionWidget> {
  Color secondary = Color.fromRGBO(255, 150, 113, 1);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          RaisedButton(
            onPressed: () {
              requestInspection(widget.investor, widget.id, widget.token)
                  .then((value) {
                if (value == "success") {
                  dialog(context, true);
                } else {
                  dialog(context, false);
                }
              });
            },
            child: Text(
              'Solicitar Inspección',
              style: TextStyle(fontSize: 22),
            ),
            color: secondary,
            textColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: new BorderRadius.circular(25.0),
            ),
            padding: EdgeInsets.all(16),
          )
        ],
      ),
    );
  }

  Future<String> requestInspection(
      String investor, String id, String token) async {
    var future = await Communication.requestInspection(investor, id, token);
    return future;
  }

  void dialog(context, bool state) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          Future.delayed(Duration(seconds: 3), () {
            Navigator.of(context).pop(true);
          });
          return AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(32.0))),
            contentPadding: EdgeInsets.only(top: 10.0),
            content: Container(
              width: MediaQuery.of(context).size.width - 50,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: state == false
                        ? Text("Error en la Solicitud")
                        : Text("Solicitud Pedida"),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: state == false
                        ? Icon(
                            Icons.error_outline,
                            color: Colors.red,
                            size: 40,
                          )
                        : Icon(
                            Icons.check_circle_outline,
                            color: Colors.green,
                            size: 40,
                          ),
                  )
                ],
              ),
            ),
          );
        });
  }
}
