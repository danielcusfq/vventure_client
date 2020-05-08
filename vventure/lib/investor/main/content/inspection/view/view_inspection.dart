import 'package:flutter/material.dart';
import 'package:vventure/investor/main/content/inspection/controller/communication.dart';
import 'package:vventure/investor/main/content/inspection/model/inspection_model.dart';
import 'package:vventure/investor/main/content/inspection/widget/loading_widget.dart';
import 'package:vventure/investor/main/content/inspection/widget/name_widget.dart';
import 'package:vventure/investor/main/content/inspection/widget/organization_widget.dart';
import 'package:vventure/investor/main/content/inspection/widget/profile_image_widget.dart';
import 'package:vventure/investor/main/content/inspection/widget/inspection_detail_widget.dart';

//this widget displays the detailed view of an inspection

class ViewPreviousInspection extends StatefulWidget {
  final String id;
  final String token;
  final String inspection;
  ViewPreviousInspection(
      {Key key,
      @required this.inspection,
      @required this.id,
      @required this.token})
      : super(key: key);
  @override
  _ViewPreviousInspectionState createState() => _ViewPreviousInspectionState();
}

class _ViewPreviousInspectionState extends State<ViewPreviousInspection> {
  InspectionModel _inspection;
  bool _isLoading;

  //run functions at widget initialization
  @override
  void initState() {
    setState(() {
      _isLoading = true;
    });

    var future = Communication.fetchInspection(
        widget.id, widget.token, widget.inspection);
    future.then((inspection) {
      setState(() {
        _inspection = inspection;
        _isLoading = false;
      });
    });

    super.initState();
  }

  //main view of widget
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
}
