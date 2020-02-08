import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:vventure/basic_profile/entrepreneur/model/basic_profile.dart';
import 'package:vventure/basic_profile/entrepreneur/view/basic_last.dart';

class BasicProfileSecondEnt extends StatefulWidget {
  final BasicProfileEntrepreneur basicProfileEntrepreneur;
  BasicProfileSecondEnt({Key key, @required this.basicProfileEntrepreneur})
      : super(key: key);

  @override
  _BasicProfileSecondEntState createState() => _BasicProfileSecondEntState();
}

class _BasicProfileSecondEntState extends State<BasicProfileSecondEnt> {
  TextEditingController percentage = new TextEditingController();
  TextEditingController exchange = new TextEditingController();
  List<String> _dropItems = ["Concept", "Prototipe", "Production", "Scaling"];
  String stage = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        bottomOpacity: 0,
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Color.fromRGBO(132, 94, 194, 1),
          ),
          onPressed: () => Navigator.pop(context, false),
        ),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(color: Colors.white),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: Text(
                  "What’s the Stage of Your Project?",
                  style: TextStyle(fontSize: 20),
                ),
              ),
              DropdownButton<String>(
                  items: _dropItems.map((String val) {
                    return DropdownMenuItem<String>(
                      value: val,
                      child: Center(child: Text(val)),
                    );
                  }).toList(),
                  hint: stage.isNotEmpty
                      ? Text(stage)
                      : Text("Select Project Stage"),
                  onChanged: (String val) {
                    stage = val;
                    setState(() {});
                  }),
              Padding(
                padding: const EdgeInsets.only(top: 30.0),
                child: Text(
                  "Percentage to Give Up",
                  style: TextStyle(fontSize: 20),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                    width: MediaQuery.of(context).size.width / 2,
                    child: TextField(
                      controller: percentage,
                      cursorColor: Color.fromRGBO(132, 94, 194, 1),
                      style: TextStyle(
                          color: Color.fromRGBO(132, 94, 194, 1), fontSize: 20),
                      keyboardType:
                          TextInputType.numberWithOptions(decimal: false),
                      maxLength: 2,
                      decoration: new InputDecoration(
                        labelStyle: new TextStyle(
                            color: Color.fromRGBO(132, 94, 194, 1),
                            fontSize: 20),
                        focusedBorder: UnderlineInputBorder(
                            borderSide: new BorderSide(
                                color: Color.fromRGBO(132, 94, 194, 1))),
                      ),
                      inputFormatters: <TextInputFormatter>[
                        WhitelistingTextInputFormatter.digitsOnly
                      ], // Only numbers can be entered
                    ),
                  ),
                  Text(
                    "%",
                    style: TextStyle(fontSize: 20),
                  )
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(top: 30.0),
                child: Text(
                  "In Exchange of",
                  style: TextStyle(fontSize: 20),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
                width: MediaQuery.of(context).size.width,
                child: TextField(
                  controller: exchange,
                  cursorColor: Color.fromRGBO(132, 94, 194, 1),
                  style: TextStyle(
                      color: Color.fromRGBO(132, 94, 194, 1), fontSize: 20),
                  keyboardType: TextInputType.text,
                  minLines: 3,
                  maxLines: 3,
                  decoration: new InputDecoration(
                    labelStyle: new TextStyle(
                        color: Color.fromRGBO(132, 94, 194, 1), fontSize: 20),
                    focusedBorder: UnderlineInputBorder(
                        borderSide: new BorderSide(
                            color: Color.fromRGBO(132, 94, 194, 1))),
                  ),
                ),
              ),
              Container(
                height: 5,
              ),
              Container(
                height: 5,
              ),
              FlatButton(
                onPressed: () {
                  this.widget.basicProfileEntrepreneur.stage = stage;
                  this.widget.basicProfileEntrepreneur.percentage =
                      percentage.text;
                  this.widget.basicProfileEntrepreneur.exchange = exchange.text;
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => BasicProfileLastEnt(
                                basicProfileEntrepreneur:
                                    this.widget.basicProfileEntrepreneur,
                              )));
                },
                child: Text(
                  "Next",
                  style: TextStyle(fontSize: 20),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
