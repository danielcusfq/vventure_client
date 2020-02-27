import 'package:flutter/material.dart';
import 'package:vventure/entrepreneur/main/content/profile/controller/communication.dart';

class StakeWidget extends StatefulWidget {
  final String stake;
  final String exchange;
  final String id;
  final String token;
  final String type;
  final Function rebuild;

  StakeWidget(
      {Key key,
      @required this.stake,
      @required this.exchange,
      @required this.id,
      @required this.token,
      @required this.type,
      @required this.rebuild})
      : super(key: key);
  @override
  _StakeWidgetState createState() => _StakeWidgetState();
}

class _StakeWidgetState extends State<StakeWidget> {
  Color myColor = Color.fromRGBO(132, 94, 194, 1);
  TextEditingController stake = new TextEditingController();
  TextEditingController exchange = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 20),
      child: GestureDetector(
        onLongPress: () {
          stake.text = widget.stake;
          exchange.text = widget.exchange;
          updateDialog(context);
        },
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
                        "Update Stakes",
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
                    padding: EdgeInsets.only(top: 20),
                    child: Center(
                      child: Text(
                        "Percentage to Give Up",
                        style: TextStyle(fontSize: 24),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(bottom: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 20),
                          width: MediaQuery.of(context).size.width - 150,
                          child: TextField(
                            controller: stake,
                            cursorColor: Color.fromRGBO(132, 94, 194, 1),
                            style: TextStyle(
                                color: Color.fromRGBO(132, 94, 194, 1),
                                fontSize: 20),
                            keyboardType: TextInputType.number,
                            minLines: 1,
                            maxLines: 1,
                            decoration: InputDecoration(
                              labelStyle: TextStyle(
                                  color: Color.fromRGBO(132, 94, 194, 1),
                                  fontSize: 20),
                              focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Color.fromRGBO(132, 94, 194, 1))),
                            ),
                          ),
                        ),
                        Text(
                          "%",
                          style: TextStyle(fontSize: 24),
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 20),
                    child: Center(
                      child: Text(
                        "In Exchange of",
                        style: TextStyle(fontSize: 24),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(bottom: 20),
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      width: MediaQuery.of(context).size.width,
                      child: TextField(
                        controller: exchange,
                        cursorColor: Color.fromRGBO(132, 94, 194, 1),
                        style: TextStyle(
                            color: Color.fromRGBO(132, 94, 194, 1),
                            fontSize: 20),
                        keyboardType: TextInputType.text,
                        minLines: 3,
                        maxLines: 3,
                        decoration: InputDecoration(
                          labelStyle: TextStyle(
                              color: Color.fromRGBO(132, 94, 194, 1),
                              fontSize: 20),
                          focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                  color: Color.fromRGBO(132, 94, 194, 1))),
                        ),
                      ),
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
                          updateStake(this.widget.id, this.widget.token,
                              this.widget.type, stake.text, exchange.text);
                          Navigator.of(context, rootNavigator: true)
                              .pop('dialog');
                          setState(() {
                            widget.rebuild();
                          });
                        },
                        child: Text(
                          "Update Stakes",
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

  void updateStake(
      String id, String token, String type, String stake, String exchange) {
    var future = Communication.updateStake(id, token, type, stake, exchange);
    future.then((val) {});
  }
}
