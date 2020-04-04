import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vventure/auth/info.dart';
import 'package:vventure/investor/main/view/home_view.dart';
import 'package:vventure/entrepreneur/main/view/home_view.dart';
import 'package:vventure/basic_profile/entrepreneur/view/home_view.dart';
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
            // main column for view
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
                      "Inicia sesión como",
                      style: TextStyle(fontSize: 24),
                    ),
                  ),
                  new ToggleButtons(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Text(
                          "Emprendedor",
                          style: TextStyle(fontSize: 20),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Text(
                          "Inversor",
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
                    selectedColor: Color.fromRGBO(255, 150, 113, 1),
                    fillColor: Colors.transparent,
                    borderRadius: BorderRadius.circular(25),
                    splashColor: Color.fromRGBO(255, 150, 113, 0.2),
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
                        labelText: 'Contraseña',
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
                        "Ingresar",
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
                        "Regístrate",
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                  ),
                ],
              ),
      ),
    );
  }

  // authenticate user with server and redirects authenticated user
  signIn(String email, String password, String type) async {
    Map data = {
      'auth':
          '607be6747e2a18f043221b6528785169e4a391fa17c12b45dc44289387bd9cbb',
      'type': type,
      'email': email,
      'password': password
    };

    if (type != null && password.isNotEmpty && email.isNotEmpty) {
      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      var response = await http.post("https://vventure.tk/login/", body: data);
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

            // verifies which type of account the user is
            // 1 -> entrepreneur, 2 -> investor
            if (jasonData['type'].toString() == "1") {
              // verifies if account is activated/registration finished
              // 1 -> activated, 0 -> not activated
              if (jasonData['activation'].toString() == "1") {
                sharedPreferences.setString("id", jasonData['id'].toString());
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
                Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(
                        builder: (BuildContext context) => BasicProfileEntView(
                              userInfo: userInfo,
                            )),
                    (Route<dynamic> route) => false);
              }
            } else if (jasonData['type'].toString() == "2") {
              // verifies if account is activated/registration finished
              // 1 -> activated, 0 -> not activated3
              if (jasonData['activation'].toString() == "1") {
                sharedPreferences.setString("id", jasonData['id'].toString());
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
                            BasicProfileInvestorView(
                              userInfo: userInfo,
                            )),
                    (Route<dynamic> route) => false);
              }
            }
          });
        } else {
          setState(() {
            _isLoading = false;
          });

          clearInput();

          final snackBar =
              SnackBar(content: Text('Información de usuario incorrecta'));
          _scaffoldKey.currentState.showSnackBar(snackBar);
        }
      } else {
        setState(() {
          _isLoading = false;
        });

        clearInput();
        final snackBar = SnackBar(content: Text('Error del Servidor'));
        _scaffoldKey.currentState.showSnackBar(snackBar);
      }
    } else {
      setState(() {
        _isLoading = false;
      });

      clearInput();
      final snackBar = SnackBar(content: Text('Información Incompleta'));
      _scaffoldKey.currentState.showSnackBar(snackBar);
    }
  }

  // get index of true value from toggle button
  getIndexSelections() {
    if (_selections[0] == true) {
      return "1";
    } else if (_selections[1] == true) {
      return "2";
    } else {
      return null;
    }
  }

  // clears input of text fields
  clearInput() {
    emailController.clear();
    passwordController.clear();
  }
}
