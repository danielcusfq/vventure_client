import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vventure/entrepreneur/main/common_models/profile.dart';
import 'package:vventure/entrepreneur/main/content/view_profile/controller/comunication.dart';
import 'package:vventure/entrepreneur/main/content/view_profile/widget/background_widget.dart';
import 'package:vventure/entrepreneur/main/content/view_profile/widget/custom_video.dart';
import 'package:vventure/entrepreneur/main/content/view_profile/widget/highlights_widget.dart';
import 'package:vventure/entrepreneur/main/content/view_profile/widget/image_widget.dart';
import 'package:vventure/entrepreneur/main/content/view_profile/widget/info_widget.dart';
import 'package:vventure/entrepreneur/main/content/view_profile/widget/inspection_widget.dart';
import 'package:vventure/entrepreneur/main/content/view_profile/widget/interests.dart';
import 'package:vventure/entrepreneur/main/content/view_profile/widget/loading_widget.dart';
import 'package:vventure/entrepreneur/main/content/view_profile/widget/name_widget.dart';
import 'package:vventure/entrepreneur/main/content/view_profile/widget/organization_widget.dart';
import 'package:vventure/entrepreneur/main/content/view_profile/widget/profile_image_widget.dart';
import 'package:vventure/entrepreneur/main/content/view_profile/widget/timeline_widget.dart';

//this widget shows user information

class ViewInvestorProfile extends StatefulWidget {
  final String investorId;

  ViewInvestorProfile({
    Key key,
    @required this.investorId,
  }) : super(key: key);

  @override
  _ViewInvestorProfileState createState() => _ViewInvestorProfileState();
}

class _ViewInvestorProfileState extends State<ViewInvestorProfile> {
  SharedPreferences sharedPreferences;
  String id;
  String token;
  Profile _profile;
  Color _favorite;
  bool _isLoading = false;

  //run functions in widget initialize
  @override
  void initState() {
    setState(() {
      _isLoading = true;
    });

    getPreferences().then((val) {
      var future = Communication.fetchProfile(widget.investorId, id, token);
      future
        ..then((profile) {
          setState(() {
            _profile = profile;
            _isLoading = false;
            if (_profile.inFavorites == true) {
              _favorite = Colors.red;
            } else {
              _favorite = Colors.grey;
            }
          });
        });
    });

    super.initState();
  }

  //main view for widget
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
            backgroundColor: Colors.white,
            bottomOpacity: 0.0,
            elevation: 0,
            title: _isLoading == true
                ? Text("")
                : Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Spacer(),
                      GestureDetector(
                        onTap: () {
                          if (_profile.inFavorites == true) {
                            var future = Communication.removeFromFavorites(
                                id, token, widget.investorId);
                            future.then((value) {
                              if (value == "success") {
                                setState(() {
                                  _profile.inFavorites = false;
                                  _favorite = Colors.grey;
                                });
                              }
                            });
                          } else {
                            var future = Communication.addToFavorites(
                                id, token, widget.investorId);
                            future.then((value) {
                              if (value == "success") {
                                setState(() {
                                  _profile.inFavorites = true;
                                  _favorite = Colors.red;
                                });
                              }
                            });
                          }
                        },
                        child: Icon(Icons.favorite, color: _favorite),
                      )
                    ],
                  ),
            leading: IconButton(
              icon: Icon(
                Icons.arrow_back,
                color: Color.fromRGBO(132, 94, 194, 1),
              ),
              onPressed: () => Navigator.pop(context, false),
            )),
        body: Hero(
          tag: widget.investorId,
          child: Container(
            color: Colors.white,
            child: _isLoading == true
                ? Center(child: LoadingWidget())
                : SizedBox.expand(
                    child: Stack(
                      children: <Widget>[
                        Container(
                          child: CustomVideo(
                            video: _profile.video,
                          ),
                        ),
                        SizedBox.expand(
                          child: DraggableScrollableSheet(
                            initialChildSize: 0.715,
                            minChildSize: 0.715,
                            builder: (BuildContext buildContext, scroll) {
                              return Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 15, vertical: 15),
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.only(
                                        topRight: Radius.circular(25),
                                        topLeft: Radius.circular(25)),
                                    boxShadow: [
                                      BoxShadow(
                                          color: Colors.grey, blurRadius: 10.0)
                                    ]),
                                child: ListView(
                                  controller: scroll,
                                  children: <Widget>[
                                    Center(
                                      child: Container(
                                        height: 8,
                                        width: 50,
                                        decoration: BoxDecoration(
                                            color: Colors.grey,
                                            borderRadius:
                                                BorderRadius.circular(5)),
                                      ),
                                    ),
                                    ProfileImageWidget(
                                      image: _profile.image,
                                    ),
                                    OrganizationWidget(
                                      organization: _profile.organization,
                                    ),
                                    NameWidget(
                                      name: _profile.name,
                                      last: _profile.last,
                                    ),
                                    InterestsWidget(
                                      interest: _profile.interest,
                                    ),
                                    BackgroundWidget(
                                      background: _profile.background,
                                    ),
                                    HighlightsWidget(
                                      highlights: _profile.highlight,
                                    ),
                                    InfoWidget(
                                      info: _profile.info,
                                    ),
                                    ImageWidget(
                                      images: _profile.images,
                                    ),
                                    UserTimelineWidget(
                                      timeline: _profile.timeline,
                                    ),
                                    InspectionWidget(
                                      investor: widget.investorId,
                                      id: id,
                                      token: token,
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                        )
                      ],
                    ),
                  ),
          ),
        ),
      ),
    );
  }

  //get device and user preferences
  Future<dynamic> getPreferences() async {
    sharedPreferences = await SharedPreferences.getInstance();
    setState(() {
      id = sharedPreferences.getString("id");
      token = sharedPreferences.getString("token");
    });
  }
}
