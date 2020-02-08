import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:vventure/basic_profile/entrepreneur/model/basic_profile.dart';
import 'package:vventure/entrepreneur/home/view/home_view.dart';
import 'package:vventure/login/view/login_view.dart';

class BasicProfileLastEnt extends StatefulWidget {
  final BasicProfileEntrepreneur basicProfileEntrepreneur;
  BasicProfileLastEnt({Key key, @required this.basicProfileEntrepreneur})
      : super(key: key);

  @override
  _BasicProfileLastEntState createState() => _BasicProfileLastEntState();
}

class _BasicProfileLastEntState extends State<BasicProfileLastEnt> {
  TextEditingController problem = new TextEditingController();
  TextEditingController solution = new TextEditingController();
  bool _isLoading = false;

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
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(
                  valueColor: new AlwaysStoppedAnimation<Color>(
                      Color.fromRGBO(255, 150, 113, 1))))
          : Container(
              color: Colors.white,
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: SingleChildScrollView(
                  child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(top: 15.0),
                    child: Text(
                      "What Problem Are You Solving",
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
                    width: MediaQuery.of(context).size.width,
                    child: TextField(
                      controller: problem,
                      cursorColor: Color.fromRGBO(132, 94, 194, 1),
                      style: TextStyle(
                          color: Color.fromRGBO(132, 94, 194, 1), fontSize: 20),
                      keyboardType: TextInputType.text,
                      minLines: 3,
                      maxLines: 3,
                      decoration: new InputDecoration(
                        labelStyle: new TextStyle(
                            color: Color.fromRGBO(132, 94, 194, 1),
                            fontSize: 20),
                        focusedBorder: UnderlineInputBorder(
                            borderSide: new BorderSide(
                                color: Color.fromRGBO(132, 94, 194, 1))),
                      ),
                    ),
                  ),
                  Container(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 15.0),
                    child: Text(
                      "How Are You Solving This Problem",
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
                    width: MediaQuery.of(context).size.width,
                    child: TextField(
                      controller: solution,
                      cursorColor: Color.fromRGBO(132, 94, 194, 1),
                      style: TextStyle(
                          color: Color.fromRGBO(132, 94, 194, 1), fontSize: 20),
                      keyboardType: TextInputType.text,
                      minLines: 3,
                      maxLines: 3,
                      decoration: new InputDecoration(
                        labelStyle: new TextStyle(
                            color: Color.fromRGBO(132, 94, 194, 1),
                            fontSize: 20),
                        focusedBorder: UnderlineInputBorder(
                            borderSide: new BorderSide(
                                color: Color.fromRGBO(132, 94, 194, 1))),
                      ),
                    ),
                  ),
                  FlatButton(
                    onPressed: () {
                      this.widget.basicProfileEntrepreneur.problem =
                          problem.text;
                      this.widget.basicProfileEntrepreneur.solution =
                          solution.text;

                      completeRegister(this.widget.basicProfileEntrepreneur);
                    },
                    child: Text(
                      "Finish",
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                ],
              )),
            ),
    );
  }

  completeRegister(BasicProfileEntrepreneur basicProfileEntrepreneur) async {
    String base64image;
    String stage;
    String percentage;
    String exchange;
    String problem;
    String solution;
    Map data;

    if (basicProfileEntrepreneur.userInfo.activation == "1") {
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(
              builder: (BuildContext context) => EntrepreneurHomeView()),
          (Route<dynamic> route) => false);
    }

    if (basicProfileEntrepreneur.profilePicture != null) {
      base64image = base64Encode(
          basicProfileEntrepreneur.profilePicture.readAsBytesSync());
    } else {
      base64image = "";
    }

    if (basicProfileEntrepreneur.stage.isNotEmpty) {
      stage = basicProfileEntrepreneur.stage;
    } else {
      stage = "";
    }

    if (basicProfileEntrepreneur.percentage.isNotEmpty) {
      percentage = basicProfileEntrepreneur.percentage;
    } else {
      percentage = "";
    }

    if (basicProfileEntrepreneur.exchange.isNotEmpty) {
      exchange = basicProfileEntrepreneur.exchange;
    } else {
      exchange = "";
    }

    if (basicProfileEntrepreneur.problem.isNotEmpty) {
      problem = basicProfileEntrepreneur.problem;
    } else {
      problem = "";
    }

    if (basicProfileEntrepreneur.solution.isNotEmpty) {
      solution = basicProfileEntrepreneur.solution;
    } else {
      solution = "";
    }

    data = {
      "token": basicProfileEntrepreneur.userInfo.token,
      "type": basicProfileEntrepreneur.userInfo.type,
      "image": base64image,
      "stage": stage,
      "percentage": percentage,
      "exchange": exchange,
      "problem": problem,
      "solution": solution
    };

    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var response = await http
        .post("http://vventure.tk/complete_register/entrepreneur/", body: data);
    Map<String, dynamic> jasonData;

    if (response.statusCode == 200) {
      jasonData = json.decode(response.body);

      if (jasonData['res'].toString() == "success" &&
          jasonData['type'].toString() == "1") {
        setState(() {
          _isLoading = true;

          sharedPreferences.setString("token", jasonData['token'].toString());
          sharedPreferences.setString("type", jasonData['type'].toString());
          sharedPreferences.setString(
              "activation", jasonData['activation'].toString());

          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(
                  builder: (BuildContext context) => EntrepreneurHomeView()),
              (Route<dynamic> route) => false);
        });
      }
    }

    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (BuildContext context) => LoginView()),
        (Route<dynamic> route) => false);
  }
}
