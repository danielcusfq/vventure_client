import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vventure/entrepreneur/main/content/inspection/controller/communication.dart';
import 'package:vventure/entrepreneur/main/content/inspection/model/inspection.dart';
import 'package:vventure/entrepreneur/main/content/inspection/widget/inspection_detail.dart';
import 'package:vventure/entrepreneur/main/content/inspection/widget/profile_image_widget.dart';
import 'package:vventure/entrepreneur/main/content/inspection/widget/name_widget.dart';
import 'package:vventure/entrepreneur/main/content/inspection/widget/organization_widget.dart';
import 'package:vventure/entrepreneur/main/content/profile/widget/loading_widget.dart';

class ViewInvestorInspection extends StatefulWidget {
  final String id;
  final String inspection;
  final String investor;

  //constructor of class
  ViewInvestorInspection(
      {Key key,
      @required this.inspection,
      @required this.investor,
      @required this.id})
      : super(key: key);
  @override
  _ViewInvestorInspectionState createState() => _ViewInvestorInspectionState();
}

class _ViewInvestorInspectionState extends State<ViewInvestorInspection> {
  SharedPreferences sharedPreferences;
  String id;
  String token;
  InspectionModel _inspection;
  bool _isLoading = false;

  //functions run at initialization
  @override
  void initState() {
    setState(() {
      _isLoading = true;
    });

    getPreferences().then((val) {
      var future = Communication.fetchInspection(
          id, token, widget.inspection, widget.investor);
      future.then((inspection) {
        setState(() {
          _inspection = inspection;
          _isLoading = false;
        });
      });
    });

    super.initState();
  }

  //main widget with the detailed view of one inspection
  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: widget.inspection,
      child: Scaffold(
        appBar: AppBar(
            backgroundColor: Colors.white,
            bottomOpacity: 0.0,
            elevation: 0,
            leading: IconButton(
              icon: Icon(
                Icons.arrow_back,
                color: Color.fromRGBO(132, 94, 194, 1),
              ),
              onPressed: () => Navigator.pop(context, false),
            )),
        body: _isLoading == true
            ? Center(child: LoadingWidget())
            : Container(
                height: MediaQuery.of(context).size.height,
                color: Colors.white,
                child: ListView(
                  primary: false,
                  shrinkWrap: true,
                  children: <Widget>[
                    ProfileImageWidget(image: _inspection.image),
                    OrganizationWidget(organization: _inspection.organization),
                    NameWidget(name: _inspection.name, last: _inspection.last),
                    InspectionDetailWidget(detail: _inspection.detail)
                  ],
                ),
              ),
      ),
    );
  }

  //access shared preferences of device and user
  Future<dynamic> getPreferences() async {
    sharedPreferences = await SharedPreferences.getInstance();
    setState(() {
      id = sharedPreferences.getString("id");
      token = sharedPreferences.getString("token");
    });
  }
}
