import 'package:flutter/material.dart';
import 'package:vventure/splash.dart';
import 'package:vventure/login/view/login_view.dart';
import 'package:vventure/register/view/register_view.dart';
import 'package:vventure/investor/home/view/home_view.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'VVENTURE',
      theme: ThemeData(
          textTheme: Theme.of(context).textTheme.apply(
                fontFamily: 'Poppins',
              )),
      home: Splash(),
      routes: {
        '/login': (context) => LoginView(),
        '/register': (context) => Register(),
        '/investor_home': (context) => InvestorHomeView()
      },
    );
  }
}
