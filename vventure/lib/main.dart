import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:vventure/splash.dart';
import 'package:vventure/login/view/login_view.dart';
import 'package:vventure/register/view/register_view.dart';
import 'package:vventure/investor/home/view/home_view.dart';
import 'package:vventure/entrepreneur/main/view/home_view.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
          [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown])
      .then((_) => runApp(new MyApp()));
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.white, statusBarIconBrightness: Brightness.dark));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'VVENTURE',
      theme: ThemeData(
          primaryColor: Color.fromRGBO(132, 94, 194, 1),
          accentColor: Color.fromRGBO(132, 94, 194, 1),
          textTheme: Theme.of(context).textTheme.apply(
                fontFamily: 'Poppins',
              )),
      home: Splash(),
      routes: {
        '/login': (context) => LoginView(),
        '/register': (context) => Register(),
        '/investor_home': (context) => InvestorHomeView(),
        '/entrepreneur_home': (context) => EntrepreneurHomeView()
      },
    );
  }
}
