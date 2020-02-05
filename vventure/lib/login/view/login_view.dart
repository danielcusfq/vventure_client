import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vventure/investor/home/view/home_view.dart';
import 'package:vventure/entrepreneur/home/view/home_view.dart';

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
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            stops: [0.1, 0.7, 0.9, 0.98],
            colors: [
              Color.fromRGBO(132, 94, 194, 1),
              Color.fromRGBO(166, 94, 187, 1),
              Color.fromRGBO(181, 94, 184, 1),
              Color.fromRGBO(214, 93, 177, 1),
            ],
          ),
        ),
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
                      cursorColor: Colors.black,
                      style: TextStyle(color: Colors.black, fontSize: 20),
                      keyboardType: TextInputType.emailAddress,
                      decoration: new InputDecoration(
                        labelText: 'Email',
                        labelStyle:
                            new TextStyle(color: Colors.black, fontSize: 20),
                        focusedBorder: UnderlineInputBorder(
                            borderSide: new BorderSide(color: Colors.black)),
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    width: MediaQuery.of(context).size.width,
                    child: TextField(
                      controller: passwordController,
                      cursorColor: Colors.black,
                      style: TextStyle(color: Colors.black, fontSize: 20),
                      keyboardType: TextInputType.visiblePassword,
                      decoration: new InputDecoration(
                        labelText: 'Password',
                        labelStyle:
                            new TextStyle(color: Colors.black, fontSize: 20),
                        focusedBorder: UnderlineInputBorder(
                            borderSide: new BorderSide(color: Colors.black)),
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
                        "Submit",
                        style: TextStyle(fontSize: 20),
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

            sharedPreferences.setString("token", jasonData['token'].toString());
            sharedPreferences.setString("type", jasonData['type'].toString());
            sharedPreferences.setString(
                "activation", jasonData['activation'].toString());

            if (jasonData['type'].toString() == "1") {
              Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(
                      builder: (BuildContext context) =>
                          EntrepreneurHomeView()),
                  (Route<dynamic> route) => false);
            } else if (jasonData['type'].toString() == "2") {
              Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(
                      builder: (BuildContext context) => InvestorHomeView()),
                  (Route<dynamic> route) => false);
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
