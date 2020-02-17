import 'package:flutter/material.dart';

class StageWidget extends StatefulWidget {
  final stage;
  StageWidget({Key key, @required this.stage}) : super(key: key);
  @override
  _StageWidgetState createState() => _StageWidgetState();
}

class _StageWidgetState extends State<StageWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 20),
      child: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            "Project Stage",
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
          Text(
            this.widget.stage,
            style: TextStyle(fontSize: 22),
          ),
        ],
      )),
    );
  }
}
