import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:vventure/splash.dart';
import 'package:vventure/login/view/login_view.dart';
import 'package:vventure/register/view/register_view.dart';
import 'package:vventure/investor/main/view/home_view.dart';
import 'package:vventure/entrepreneur/main/view/home_view.dart';

//launch main app
void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
          [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown])
      .then((_) => runApp(new MyApp()));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'vventure',
      theme: ThemeData(
          //Theme data for the application
          primaryColor: Color.fromRGBO(132, 94, 194, 1),
          accentColor: Color.fromRGBO(132, 94, 194, 1),
          textTheme: Theme.of(context).textTheme.apply(
                fontFamily: 'Poppins',
              )),
      home: Splash(),
      routes: {
        //named routes fro the application
        '/login': (context) => LoginView(),
        '/register': (context) => Register(),
        '/investor_home': (context) => InvestorHomeView(),
        '/entrepreneur_home': (context) => EntrepreneurHomeView()
      },
    );
  }
}
