import 'package:flutter/material.dart';
import 'package:splashscreen/splashscreen.dart';
import 'package:vventure/login/view/login_view.dart';

class Splash extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new SplashScreen(
        seconds: 2,
        navigateAfterSeconds: new LoginView(),
        image: new Image.asset('assets/images/vventure.png'),
        backgroundColor: Colors.white,
        styleTextUnderTheLoader: new TextStyle(),
        photoSize: 100.0,
        loaderColor: Colors.deepPurpleAccent);
  }
}
