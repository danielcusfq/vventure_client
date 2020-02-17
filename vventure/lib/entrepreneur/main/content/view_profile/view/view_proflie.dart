import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ViewInvestorProfile extends StatefulWidget {
  final String id;
  ViewInvestorProfile({Key key, @required this.id}) : super(key: key);

  @override
  _ViewInvestorProfileState createState() => _ViewInvestorProfileState();
}

class _ViewInvestorProfileState extends State<ViewInvestorProfile> {
  @override
  void initState() {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarColor: Colors.white,
        statusBarIconBrightness: Brightness.dark));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
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
        body: Text(this.widget.id),
      ),
    );
  }
}
