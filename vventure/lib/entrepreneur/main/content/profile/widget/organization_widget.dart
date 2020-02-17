import 'package:flutter/material.dart';

class OrganizationWidget extends StatefulWidget {
  final String organization;
  OrganizationWidget({Key key, @required this.organization}) : super(key: key);
  @override
  _OrganizationWidgetState createState() => _OrganizationWidgetState();
}

class _OrganizationWidgetState extends State<OrganizationWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 20),
      child: Center(
          child: Container(
        child: Text(
          this.widget.organization,
          style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
        ),
      )),
    );
  }
}
