import 'package:flutter/material.dart';

class InterestsWidget extends StatefulWidget {
  final String interest;

  InterestsWidget({
    Key key,
    @required this.interest,
  }) : super(key: key);

  @override
  _InterestsWidgetState createState() => _InterestsWidgetState();
}

class _InterestsWidgetState extends State<InterestsWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
      child: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "Estos son los Intereses del Inversor",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            Text(
              this.widget.interest,
              style: TextStyle(fontSize: 24),
              textAlign: TextAlign.center,
            )
          ],
        ),
      ),
    );
  }
}
