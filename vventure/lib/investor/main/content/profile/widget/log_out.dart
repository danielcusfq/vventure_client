import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vventure/login/view/login_view.dart';

//displays log out option and handles the request

class LogOut extends StatefulWidget {
  @override
  _LogOutState createState() => _LogOutState();
}

class _LogOutState extends State<LogOut> {
  //main view for the widget
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        GestureDetector(
          onTap: () => {logOut()},
          child: Text(
            "Log Out",
            style: TextStyle(fontSize: 20, color: Colors.red),
          ),
        ),
        GestureDetector(
          onTap: () => {logOut()},
          child: Icon(
            Icons.exit_to_app,
            color: Colors.red,
          ),
        )
      ],
    );
  }

  //log outs user
  logOut() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.clear();

    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (BuildContext context) => LoginView()),
        (Route<dynamic> route) => false);
  }
}
