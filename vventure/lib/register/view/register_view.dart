import 'dart:ui';
import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:vventure/auth/info.dart';
import 'package:vventure/basic_profile/entrepreneur/view/home_view.dart';
import 'package:vventure/basic_profile/entrepreneur/model/basic_profile.dart';
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
      appBar: AppBar(
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
                        "Register as",
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
                          labelText: 'Name',
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
                          labelText: 'Last Name',
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
                          labelText: 'Organization',
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
                      padding: EdgeInsets.symmetric(vertical: 30),
                      child: FlatButton(
                        onPressed: () {
                          setState(() {
                            _isLoading = true;
                          });
                          registerUser(
                              nameController.text,
                              lastNameController.text,
                              organizationController.text,
                              emailController.text,
                              passwordController.text,
                              getIndexSelections());
                        },
                        child: Text(
                          "Register",
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

  registerUser(String name, String lastName, String organization, String email,
      String password, String type) async {
    Map data = {
      'ok': 'ok',
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
          await http.post("http://vventure.tk/register/", body: data);
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
                "0");

            if (jasonData['type'].toString() == "1") {
              final BasicProfileEntrepreneur basicProfileEntrepreneur =
                  new BasicProfileEntrepreneur(
                      userInfo, null, null, null, null, null, null);
              Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(
                      builder: (BuildContext context) =>
                          EntrepreneurBasicProfileView(
                            basicProfileEntrepreneur: basicProfileEntrepreneur,
                          )),
                  (Route<dynamic> route) => false);
            } else if (jasonData['type'].toString() == "2") {
              Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(
                      builder: (BuildContext context) =>
                          InvestorBasicProfileView()),
                  (Route<dynamic> route) => false);
            }
          });
        } else if (jasonData['res'].toString() == "taken") {
          setState(() {
            _isLoading = false;
          });

          clearInput();

          final snackBar = SnackBar(content: Text('User Taken'));
          _scaffoldKey.currentState.showSnackBar(snackBar);
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
    nameController.clear();
    lastNameController.clear();
    organizationController.clear();
    emailController.clear();
    passwordController.clear();
  }
}
