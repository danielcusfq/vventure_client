import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vventure/auth/info.dart';
import 'package:vventure/investor/home/view/home_view.dart';
import 'package:vventure/entrepreneur/home/view/home_view.dart';
import 'package:vventure/basic_profile/entrepreneur/view/home_view.dart';
import 'package:vventure/basic_profile/entrepreneur/model/basic_profile.dart';
import 'package:vventure/basic_profile/investor/view/home_view.dart';

class LoginView extends StatefulWidget {
  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  List<bool> _selections = [true, false];
  TextEditingController emailController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      resizeToAvoidBottomPadding: false,
      body: Container(
        child: _isLoading
            ? Center(
                child: CircularProgressIndicator(
                    valueColor: new AlwaysStoppedAnimation<Color>(
                        Color.fromRGBO(255, 150, 113, 1))))
            : Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(30.0),
                        child: new Image.asset(
                          'assets/images/vventure.png',
                          width: 250,
                        ),
                      )
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: new Text(
                      "LogIn as",
                      style: TextStyle(fontSize: 24),
                    ),
                  ),
                  new ToggleButtons(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Text(
                          "Entrepreneur",
                          style: TextStyle(fontSize: 20),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Text(
                          "Investor",
                          style: TextStyle(fontSize: 20),
                        ),
                      )
                    ],
                    isSelected: _selections,
                    onPressed: (int index) {
                      setState(() {
                        for (int buttonIndex = 0;
                            buttonIndex < _selections.length;
                            buttonIndex++) {
                          if (buttonIndex == index) {
                            _selections[buttonIndex] = true;
                          } else {
                            _selections[buttonIndex] = false;
                          }
                        }
                      });
                    },
                    color: Colors.black,
                    selectedColor: Color.fromRGBO(132, 94, 194, 1),
                    fillColor: Colors.transparent,
                    borderRadius: BorderRadius.circular(25),
                    splashColor: Color.fromRGBO(132, 94, 194, 0.2),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                    width: MediaQuery.of(context).size.width,
                    child: TextField(
                      controller: emailController,
                      cursorColor: Color.fromRGBO(132, 94, 194, 1),
                      style: TextStyle(
                          color: Color.fromRGBO(132, 94, 194, 1), fontSize: 20),
                      keyboardType: TextInputType.emailAddress,
                      decoration: new InputDecoration(
                        labelText: 'Email',
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
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    width: MediaQuery.of(context).size.width,
                    child: TextField(
                      controller: passwordController,
                      cursorColor: Color.fromRGBO(132, 94, 194, 1),
                      style: TextStyle(
                          color: Color.fromRGBO(132, 94, 194, 1), fontSize: 20),
                      keyboardType: TextInputType.visiblePassword,
                      decoration: new InputDecoration(
                        labelText: 'Password',
                        labelStyle: new TextStyle(
                            color: Color.fromRGBO(132, 94, 194, 1),
                            fontSize: 20),
                        focusedBorder: UnderlineInputBorder(
                            borderSide: new BorderSide(
                                color: Color.fromRGBO(132, 94, 194, 1))),
                      ),
                      obscureText: true,
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 20),
                    child: FlatButton(
                      onPressed: () {
                        setState(() {
                          _isLoading = true;
                        });
                        signIn(emailController.text, passwordController.text,
                            getIndexSelections());
                      },
                      child: Text(
                        "LogIn",
                        style: TextStyle(
                            fontSize: 20,
                            color: Color.fromRGBO(132, 94, 194, 1)),
                      ),
                    ),
                  ),
                  Spacer(),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10.0),
                    child: MaterialButton(
                      onPressed: () =>
                          {Navigator.pushNamed(context, '/register')},
                      child: Text(
                        "Register",
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                  ),
                ],
              ),
      ),
    );
  }

  signIn(String email, String password, String type) async {
    Map data = {'ok': 'ok', 'type': type, 'email': email, 'password': password};

    if (type != null && password.isNotEmpty && email.isNotEmpty) {
      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      var response = await http.post("http://vventure.tk/login/", body: data);
      Map<String, dynamic> jasonData;

      if (response.statusCode == 200) {
        jasonData = json.decode(response.body);

        if (jasonData['res'].toString() == "success" &&
            (jasonData['type'].toString() == "1" ||
                jasonData['type'].toString() == "2")) {
          setState(() {
            _isLoading = false;

            final UserInfo userInfo = new UserInfo(
                jasonData['token'].toString(),
                jasonData['type'].toString(),
                jasonData['activation'].toString());

            if (jasonData['type'].toString() == "1") {
              if (jasonData['activation'].toString() == "1") {
                sharedPreferences.setString(
                    "token", jasonData['token'].toString());
                sharedPreferences.setString(
                    "type", jasonData['type'].toString());
                sharedPreferences.setString(
                    "activation", jasonData['activation'].toString());

                Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(
                        builder: (BuildContext context) =>
                            EntrepreneurHomeView()),
                    (Route<dynamic> route) => false);
              } else if (jasonData['activation'].toString() == "0") {
                final BasicProfileEntrepreneur basicProfileEntrepreneur =
                    new BasicProfileEntrepreneur(
                        userInfo, null, null, null, null, null, null);
                Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(
                        builder: (BuildContext context) =>
                            EntrepreneurBasicProfileView(
                              basicProfileEntrepreneur:
                                  basicProfileEntrepreneur,
                            )),
                    (Route<dynamic> route) => false);
              }
            } else if (jasonData['type'].toString() == "2") {
              if (jasonData['activation'].toString() == "1") {
                sharedPreferences.setString(
                    "token", jasonData['token'].toString());
                sharedPreferences.setString(
                    "type", jasonData['type'].toString());
                sharedPreferences.setString(
                    "activation", jasonData['activation'].toString());

                Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(
                        builder: (BuildContext context) => InvestorHomeView()),
                    (Route<dynamic> route) => false);
              } else if (jasonData['activation'].toString() == "0") {
                Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(
                        builder: (BuildContext context) =>
                            InvestorBasicProfileView()),
                    (Route<dynamic> route) => false);
              }
            }
          });
        } else {
          setState(() {
            _isLoading = false;
          });

          clearInput();

          final snackBar = SnackBar(content: Text('Wrong user Information'));
          _scaffoldKey.currentState.showSnackBar(snackBar);
        }
      } else {
        setState(() {
          _isLoading = false;
        });

        clearInput();
        final snackBar = SnackBar(content: Text('Server Error'));
        _scaffoldKey.currentState.showSnackBar(snackBar);
      }
    } else {
      setState(() {
        _isLoading = false;
      });

      clearInput();
      final snackBar = SnackBar(content: Text('Empty Information'));
      _scaffoldKey.currentState.showSnackBar(snackBar);
    }
  }

  getIndexSelections() {
    if (_selections[0] == true) {
      return "1";
    } else if (_selections[1] == true) {
      return "2";
    } else {
      return null;
    }
  }

  clearInput() {
    emailController.clear();
    passwordController.clear();
  }
}
