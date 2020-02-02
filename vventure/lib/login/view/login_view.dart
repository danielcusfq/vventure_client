import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vventure/investor/home/view/home_view.dart';

class LoginView extends StatefulWidget {
  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  List<bool> _selections = [true, false];
  TextEditingController emailController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();
  bool _isLoading = false;

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            stops: [0.1, 0.6, 0.8, 0.9],
            colors: [
              Color.fromRGBO(132, 94, 194, 1),
              Color.fromRGBO(166, 94, 187, 1),
              Color.fromRGBO(181, 94, 184, 1),
              Color.fromRGBO(214, 93, 177, 1),
            ],
          ),
        ),
        child: _isLoading
            ? Center(child: CircularProgressIndicator())
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
                      style: TextStyle(fontSize: 26),
                    ),
                  ),
                  new ToggleButtons(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Text(
                          "Entrepreneur",
                          style: TextStyle(fontSize: 22),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Text(
                          "Investor",
                          style: TextStyle(fontSize: 22),
                        ),
                      )
                    ],
                    isSelected: _selections,
                    onPressed: (int index) {
                      setState(() {
                        //_selections[index] = !_selections[index];
                        for (int buttonIndex = 0;
                            buttonIndex < _selections.length;
                            buttonIndex++) {
                          if (buttonIndex == index) {
                            _selections[buttonIndex] =
                                !_selections[buttonIndex];
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Form(
                        key: _formKey,
                        child: Column(
                          children: <Widget>[
                            Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 20),
                              width: MediaQuery.of(context).size.width,
                              child: TextField(
                                controller: emailController,
                                cursorColor: Colors.black,
                                style: TextStyle(
                                    color: const Color(0xFF424242),
                                    fontSize: 24),
                                keyboardType: TextInputType.emailAddress,
                                decoration: new InputDecoration(
                                  labelText: 'Email',
                                  labelStyle: new TextStyle(
                                      color: const Color(0xFF424242),
                                      fontSize: 26),
                                  focusedBorder: UnderlineInputBorder(
                                      borderSide:
                                          new BorderSide(color: Colors.black)),
                                ),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 20),
                              width: MediaQuery.of(context).size.width,
                              child: TextField(
                                controller: passwordController,
                                cursorColor: Colors.black,
                                style: TextStyle(
                                    color: const Color(0xFF424242),
                                    fontSize: 24),
                                keyboardType: TextInputType.visiblePassword,
                                decoration: new InputDecoration(
                                  labelText: 'Password',
                                  labelStyle: new TextStyle(
                                      color: const Color(0xFF424242),
                                      fontSize: 26),
                                  focusedBorder: UnderlineInputBorder(
                                      borderSide:
                                          new BorderSide(color: Colors.black)),
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
                                  signIn(emailController.text,
                                      passwordController.text);
                                },
                                child: Text(
                                  "Submit",
                                  style: TextStyle(fontSize: 20),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      MaterialButton(
                        onPressed: () => {},
                        child: Text(
                          "Register",
                          style: TextStyle(fontSize: 20),
                        ),
                      ),
                    ],
                  )
                ],
              ),
      ),
    );
  }

  signIn(String email, String password) async {
    Map data = {'ok': 'ok', 'type': "2", 'email': email, 'password': password};
    print(data);
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var response = await http.post("http://vventure.tk/login/", body: data);
    Map<String, dynamic> JSON;

    if (response.statusCode == 200) {
      JSON = json.decode(response.body);

      if (JSON['res'].toString() == "success") {
        setState(() {
          _isLoading = false;

          sharedPreferences.setString("token", JSON['token']);
          sharedPreferences.setString("type", JSON['type']);

          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(
                  builder: (BuildContext context) => InvestorHomeView()),
              (Route<dynamic> route) => false);
        });
      } else {
        setState(() {
          _isLoading = false;
        });
        print("error on jason data");
      }
    } else {
      setState(() {
        _isLoading = false;
      });
      print("error on url");
    }
  }
}
