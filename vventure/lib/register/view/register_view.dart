import 'dart:ui';
import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:vventure/auth/info.dart';
import 'package:vventure/basic_profile/entrepreneur/view/home_view.dart';
import 'package:vventure/basic_profile/investor/view/home_view.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  List<bool> _selections = [true, false];
  TextEditingController nameController = new TextEditingController();
  TextEditingController lastNameController = new TextEditingController();
  TextEditingController organizationController = new TextEditingController();
  TextEditingController emailController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: _isLoading
          ? null
          : AppBar(
              backgroundColor: Colors.transparent,
              bottomOpacity: 0.0,
              elevation: 0,
              leading: IconButton(
                icon: Icon(
                  Icons.arrow_back,
                  color: Color.fromRGBO(132, 94, 194, 1),
                ),
                onPressed: () => Navigator.pop(context, false),
              )),
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(
                  valueColor: new AlwaysStoppedAnimation<Color>(
                      Color.fromRGBO(255, 150, 113, 1))))
          // main content of view
          : Container(
              height: MediaQuery.of(context).size.height,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(bottom: 25.0),
                          child: new Image.asset(
                            'assets/images/vventure.png',
                            width: 150,
                          ),
                        )
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: new Text(
                        "Regístrate como",
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
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      width: MediaQuery.of(context).size.width,
                      child: TextField(
                        controller: nameController,
                        cursorColor: Color.fromRGBO(132, 94, 194, 1),
                        style: TextStyle(
                            color: Color.fromRGBO(132, 94, 194, 1),
                            fontSize: 20),
                        keyboardType: TextInputType.text,
                        decoration: new InputDecoration(
                          labelText: 'Nombre',
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
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      width: MediaQuery.of(context).size.width,
                      child: TextField(
                        controller: lastNameController,
                        cursorColor: Color.fromRGBO(132, 94, 194, 1),
                        style: TextStyle(
                            color: Color.fromRGBO(132, 94, 194, 1),
                            fontSize: 20),
                        keyboardType: TextInputType.text,
                        decoration: new InputDecoration(
                          labelText: 'Apellido',
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
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      width: MediaQuery.of(context).size.width,
                      child: TextField(
                        controller: organizationController,
                        cursorColor: Color.fromRGBO(132, 94, 194, 1),
                        style: TextStyle(
                            color: Color.fromRGBO(132, 94, 194, 1),
                            fontSize: 20),
                        keyboardType: TextInputType.text,
                        decoration: new InputDecoration(
                          labelText: 'Organización',
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
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      width: MediaQuery.of(context).size.width,
                      child: TextField(
                        controller: emailController,
                        cursorColor: Color.fromRGBO(132, 94, 194, 1),
                        style: TextStyle(
                            color: Color.fromRGBO(132, 94, 194, 1),
                            fontSize: 20),
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
                            color: Color.fromRGBO(132, 94, 194, 1),
                            fontSize: 20),
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
                      padding: EdgeInsets.symmetric(vertical: 30),
                      child: FlatButton(
                        onPressed: () {
                          // set loading state
                          setState(() {
                            _isLoading = true;
                          });
                          // register user and performs redirect
                          registerUser(
                              nameController.text,
                              lastNameController.text,
                              organizationController.text,
                              emailController.text,
                              passwordController.text,
                              getIndexSelections());
                        },
                        child: Text(
                          "Registrarse",
                          style: TextStyle(
                              fontSize: 20,
                              color: Color.fromRGBO(132, 94, 194, 1)),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
    );
  }

  // registers user and redirects user
  registerUser(String name, String lastName, String organization, String email,
      String password, String type) async {
    Map data = {
      'auth':
          'f82d371b7c8178f9632c83cb33bd3cfe4f8ae7847394a0ff3513f5d679ff5fb3',
      'type': type,
      'name': name,
      'last': lastName,
      'org': organization,
      'email': email,
      'password': password
    };

    if (type != null &&
        name.isNotEmpty &&
        lastName.isNotEmpty &&
        organization.isNotEmpty &&
        password.isNotEmpty &&
        email.isNotEmpty) {
      var response =
          await http.post("https://vventure.tk/register/", body: data);
      Map<String, dynamic> jasonData;

      if (response.statusCode == 200) {
        jasonData = json.decode(response.body);

        // verifies if response is correct
        if (jasonData['res'].toString() == "success" &&
            (jasonData['type'].toString() == "1" ||
                jasonData['type'].toString() == "2")) {
          setState(() {
            _isLoading = false;

            final UserInfo userInfo = new UserInfo(
                jasonData['token'].toString(),
                jasonData['type'].toString(),
                "0");

            // verifies type of user and redirects to proper page
            // 1 -> entrepreneur, 2 -> investor
            if (jasonData['type'].toString() == "1") {
              Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(
                      builder: (BuildContext context) => BasicProfileEntView(
                            userInfo: userInfo,
                          )),
                  (Route<dynamic> route) => false);
            } else if (jasonData['type'].toString() == "2") {
              Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(
                      builder: (BuildContext context) =>
                          BasicProfileInvestorView(
                            userInfo: userInfo,
                          )),
                  (Route<dynamic> route) => false);
            }
          });
        } else if (jasonData['res'].toString() == "taken") {
          setState(() {
            _isLoading = false;
          });

          clearInput();

          final snackBar = SnackBar(content: Text('Usuario tomado'));
          _scaffoldKey.currentState.showSnackBar(snackBar);
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
    nameController.clear();
    lastNameController.clear();
    organizationController.clear();
    emailController.clear();
    passwordController.clear();
  }
}
