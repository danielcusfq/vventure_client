import 'dart:async';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vventure/login/view/login_view.dart';
import 'package:vventure/entrepreneur/main/view/home_view.dart';
import 'package:vventure/investor/main/view/home_view.dart';

//splash screen for app
class Splash extends StatefulWidget {
  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  SharedPreferences sharedPreferences;

  @override
  void initState() {
    super.initState();
    checkLoginStatus();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Image.asset(
            'assets/images/vventure.png',
            width: 250,
          ),
          Container(
            height: 120,
          ),
          CircularProgressIndicator(
            valueColor:
                AlwaysStoppedAnimation<Color>(Color.fromRGBO(255, 150, 113, 1)),
          )
        ],
      ),
    );
  }

  //check the login status of the user and redirects user to respective path
  checkLoginStatus() async {
    sharedPreferences = await SharedPreferences.getInstance();

    Timer(Duration(seconds: 3), () {
      if (sharedPreferences.getString("id") != null ||
          sharedPreferences.getString("token") != null ||
          sharedPreferences.getString("type") != null ||
          sharedPreferences.getString("activation") != null ||
          sharedPreferences.getString("activation") == "1") {
        // redirects user to home or login
        if (sharedPreferences.getString("type") == "1") {
          // redirects entrepreneur to home page
          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(
                  builder: (BuildContext context) => EntrepreneurHomeView()),
              (Route<dynamic> route) => false);
        } else if (sharedPreferences.getString("type") == "2") {
          // redirects investor to home page
          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(
                  builder: (BuildContext context) => InvestorHomeView()),
              (Route<dynamic> route) => false);
        } else {
          // redirects user to login
          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (BuildContext context) => LoginView()),
              (Route<dynamic> route) => false);
        }
      } else {
        // redirects user to login
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (BuildContext context) => LoginView()),
            (Route<dynamic> route) => false);
      }
    });
  }
}
