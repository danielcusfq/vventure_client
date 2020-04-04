import 'package:flutter/material.dart';

class NameWidget extends StatefulWidget {
  final String name;
  final String last;

  NameWidget({
    Key key,
    @required this.name,
    @required this.last,
  }) : super(key: key);

  @override
  _NameWidgetState createState() => _NameWidgetState();
}

class _NameWidgetState extends State<NameWidget> {
  String fullName;

  @override
  void initState() {
    super.initState();
    setState(() {
      fullName = this.widget.name + " " + this.widget.last;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 20),
      child: Center(
          child: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text("Representado Por",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            Text(
              fullName,
              style: TextStyle(fontSize: 26),
            )
          ],
        ),
      )),
    );
  }
}
