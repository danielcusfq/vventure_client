import 'package:flutter/material.dart';

class InspectionDetailWidget extends StatefulWidget {
  final String detail;
  InspectionDetailWidget({Key key, @required this.detail}) : super(key: key);
  @override
  _InspectionDetailWidgetState createState() => _InspectionDetailWidgetState();
}

class _InspectionDetailWidgetState extends State<InspectionDetailWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Center(
            child: Container(
              child: Text(
                "Retroalimentación del Inversionista",
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          Center(
            child: Container(
              child: widget.detail == null || widget.detail.isEmpty == true
                  ? Text("El Inversor no Proporcionó Retroalimentación")
                  : Text(
                      widget.detail,
                      style: TextStyle(fontSize: 24),
                      textAlign: TextAlign.center,
                    ),
            ),
          ),
        ],
      ),
    );
  }
}
