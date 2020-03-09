import 'package:flutter/material.dart';

class StakeWidget extends StatefulWidget {
  final String stake;
  final String exchange;
  StakeWidget({Key key, @required this.stake, @required this.exchange})
      : super(key: key);

  @override
  _StakeWidgetState createState() => _StakeWidgetState();
}

class _StakeWidgetState extends State<StakeWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 20),
      child: Center(
          child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            "You Are Giving ",
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
          Text(
            this.widget.stake + "%",
            style: TextStyle(fontSize: 24),
          ),
          Text(
            "Of Your Company in Exchange of",
            style: TextStyle(fontSize: 22),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Text(
              this.widget.exchange,
              style: TextStyle(fontSize: 24),
              textAlign: TextAlign.center,
            ),
          )
        ],
      )),
    );
  }
}
