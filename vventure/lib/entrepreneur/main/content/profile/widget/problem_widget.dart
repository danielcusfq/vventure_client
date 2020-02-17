import 'package:flutter/material.dart';

class ProblemWidget extends StatefulWidget {
  final String problem;
  ProblemWidget({Key key, @required this.problem}) : super(key: key);
  @override
  _ProblemWidgetState createState() => _ProblemWidgetState();
}

class _ProblemWidgetState extends State<ProblemWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
      child: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "You are Solving the Next Problem",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            Text(
              this.widget.problem,
              style: TextStyle(fontSize: 24),
            )
          ],
        ),
      ),
    );
  }
}
