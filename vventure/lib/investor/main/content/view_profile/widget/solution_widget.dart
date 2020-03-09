import 'package:flutter/material.dart';

class SolutionWidget extends StatefulWidget {
  final String solution;
  SolutionWidget({Key key, @required this.solution}) : super(key: key);
  @override
  _SolutionWidgetState createState() => _SolutionWidgetState();
}

class _SolutionWidgetState extends State<SolutionWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
      child: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "This is How We Are Solving the Problem",
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
    );
  }
}
