import 'package:flutter/material.dart';

class InvestorHomeView extends StatefulWidget {
  @override
  _InvestorHomeViewState createState() => _InvestorHomeViewState();
}

class _InvestorHomeViewState extends State<InvestorHomeView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Investor"),
      ),
    );
  }
}
