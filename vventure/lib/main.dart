import 'package:flutter/material.dart';
import 'package:vventure/splash.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'VVENTURE',
      home: Splash(),
    );
  }
}
