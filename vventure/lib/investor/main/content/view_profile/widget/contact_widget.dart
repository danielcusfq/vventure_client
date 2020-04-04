import 'package:flutter/material.dart';
import 'package:vventure/entrepreneur/main/content/profile/widget/loading_widget.dart';
import 'package:vventure/investor/main/content/view_profile/controller/comunication.dart';

class ContactEntrepreneurWidget extends StatefulWidget {
  final String id;
  final String token;
  final String entrepreneur;
  ContactEntrepreneurWidget(
      {Key key,
      @required this.id,
      @required this.token,
      @required this.entrepreneur})
      : super(key: key);
  @override
  _ContactEntrepreneurWidgetState createState() =>
      _ContactEntrepreneurWidgetState();
}

class _ContactEntrepreneurWidgetState extends State<ContactEntrepreneurWidget> {
  Color secondary = Color.fromRGBO(255, 150, 113, 1);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Expanded(
            child: RaisedButton(
              onPressed: () {
                loading(context);
                var future = Communication.requestContactInformation(
                    widget.id, widget.token, widget.entrepreneur);
                future.then((val) {
                  Navigator.of(context).pop(true);
                  if (val == "succes") {
                    dialog(context, true);
                  } else {
                    dialog(context, false);
                  }
                });
              },
              child: Text(
                'Contactar Emprendedor',
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
        ],
      ),
    );
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
                        : Text(
                            "La Información de Contacto ha Sido Enviada a tu Correo Electrónico",
                            textAlign: TextAlign.center,
                          ),
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

  void loading(context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(32.0))),
            contentPadding: EdgeInsets.only(top: 10.0),
            content: Container(
              width: MediaQuery.of(context).size.width - 50,
              height: MediaQuery.of(context).size.width - 50,
              child: Center(child: LoadingWidget()),
            ),
          );
        });
  }
}
