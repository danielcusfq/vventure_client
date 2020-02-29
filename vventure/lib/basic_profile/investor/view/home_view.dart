import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:vventure/auth/info.dart';
import 'package:vventure/login/view/login_view.dart';
import 'package:vventure/basic_profile/investor/controller/communication.dart';
import 'package:vventure/investor/main/view/home_view.dart';

class BasicProfileInvestorView extends StatefulWidget {
  final UserInfo userInfo;
  BasicProfileInvestorView({Key key, @required this.userInfo})
      : super(key: key);

  @override
  _BasicProfileInvestorViewState createState() =>
      _BasicProfileInvestorViewState();
}

class _BasicProfileInvestorViewState extends State<BasicProfileInvestorView> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  TextEditingController interests = new TextEditingController();
  TextEditingController background = new TextEditingController();
  File _image;
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
          key: _scaffoldKey,
          appBar: _isLoading
              ? null
              : AppBar(
                  title: Align(
                    alignment: Alignment.center,
                    child: Text(
                      "Welcome to VVENTURE",
                      style: TextStyle(
                          fontSize: 24, color: Color.fromRGBO(132, 94, 194, 1)),
                    ),
                  ),
                  backgroundColor: Colors.white,
                  elevation: 0,
                  leading: IconButton(
                    icon: Icon(
                      Icons.arrow_back,
                      color: Color.fromRGBO(132, 94, 194, 1),
                    ),
                    onPressed: () => Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(
                            builder: (BuildContext context) => LoginView()),
                        (Route<dynamic> route) => false),
                  ),
                  bottom: TabBar(
                    unselectedLabelColor: Color.fromRGBO(132, 94, 194, 1),
                    indicatorSize: TabBarIndicatorSize.label,
                    indicator: BoxDecoration(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(15),
                            topRight: Radius.circular(15)),
                        color: Color.fromRGBO(132, 94, 194, 1)),
                    tabs: <Widget>[
                      // column that contains load image -- first tab
                      Tab(
                        child: Align(
                          alignment: Alignment.center,
                          child: Text("Profile Picture"),
                        ),
                      ),
                      Tab(
                        child: Align(
                          alignment: Alignment.center,
                          child: Text("Interests & Background"),
                        ),
                      )
                    ],
                  ),
                ),
          body: _isLoading
              ? Center(
                  child: CircularProgressIndicator(
                      valueColor: new AlwaysStoppedAnimation<Color>(
                          Color.fromRGBO(255, 150, 113, 1))))
              : TabBarView(
                  children: <Widget>[
                    Container(
                      color: Colors.white,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Container(
                            height: MediaQuery.of(context).size.height / 3,
                            child: _image == null
                                ? Image.asset(
                                    'assets/images/add_profile_image.png',
                                    width: 150,
                                    height: 150,
                                  )
                                : Container(
                                    height:
                                        MediaQuery.of(context).size.height / 3,
                                    width:
                                        MediaQuery.of(context).size.height / 3,
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        image: DecorationImage(
                                            image: FileImage(_image),
                                            fit: BoxFit.fill)),
                                  ),
                          ),
                          FlatButton(
                            onPressed: getImage,
                            child: Text(
                              "Add Profile Image",
                              style: TextStyle(
                                  fontSize: 20,
                                  color: Color.fromRGBO(132, 94, 194, 1)),
                            ),
                          ),
                          Container(
                            height: 5,
                          )
                        ],
                        //child: _image == null ? Text('No image selected.') : Image.file(_image),
                      ),
                    ),
                    Container(
                      color: Colors.white,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            "What Are Your Interests",
                            style: TextStyle(fontSize: 20),
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 20, vertical: 30),
                            width: MediaQuery.of(context).size.width,
                            child: TextField(
                              controller: interests,
                              cursorColor: Color.fromRGBO(132, 94, 194, 1),
                              style: TextStyle(
                                  color: Color.fromRGBO(132, 94, 194, 1),
                                  fontSize: 20),
                              keyboardType: TextInputType.text,
                              minLines: 3,
                              maxLines: 3,
                              decoration: new InputDecoration(
                                labelStyle: new TextStyle(
                                    color: Color.fromRGBO(132, 94, 194, 1),
                                    fontSize: 20),
                                focusedBorder: UnderlineInputBorder(
                                    borderSide: new BorderSide(
                                        color:
                                            Color.fromRGBO(132, 94, 194, 1))),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 5.0),
                            child: Text(
                              "Tell Us About Yourself",
                              style: TextStyle(fontSize: 20),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 20, vertical: 30),
                            width: MediaQuery.of(context).size.width,
                            child: TextField(
                              controller: background,
                              cursorColor: Color.fromRGBO(132, 94, 194, 1),
                              style: TextStyle(
                                  color: Color.fromRGBO(132, 94, 194, 1),
                                  fontSize: 20),
                              keyboardType: TextInputType.text,
                              minLines: 3,
                              maxLines: 3,
                              decoration: new InputDecoration(
                                labelStyle: new TextStyle(
                                    color: Color.fromRGBO(132, 94, 194, 1),
                                    fontSize: 20),
                                focusedBorder: UnderlineInputBorder(
                                    borderSide: new BorderSide(
                                        color:
                                            Color.fromRGBO(132, 94, 194, 1))),
                              ),
                            ),
                          ),
                          FlatButton(
                            onPressed: () {
                              setState(() {
                                _isLoading = true;
                              });

                              completeRegister(this.widget.userInfo, _image,
                                  interests.text, background.text);
                            },
                            child: Text(
                              "Finish",
                              style: TextStyle(
                                  fontSize: 20,
                                  color: Color.fromRGBO(132, 94, 194, 1)),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                )),
    );
  }

  Future getImage() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      _image = image;
    });
  }

  void completeRegister(
      UserInfo userInfo, File image, String interest, String background) {
    var future =
        Communication.completeRegister(userInfo, _image, interest, background);

    future.then((result) {
      // manages result from server
      if (result.toString() == "Success") {
        // redirects user to home page
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(
                builder: (BuildContext context) => InvestorHomeView()),
            (Route<dynamic> route) => false);
      } else if (result.toString() == "Activated") {
        // redirects user to log in
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (BuildContext context) => LoginView()),
            (Route<dynamic> route) => false);
      } else if (result.toString() == "Wrong Response") {
        setState(() {
          _isLoading = false;
        });

        final snackBar = SnackBar(content: Text('Server Error'));
        _scaffoldKey.currentState.showSnackBar(snackBar);
      } else if (result.toString() == "Server Error") {
        setState(() {
          _isLoading = false;
        });

        final snackBar = SnackBar(content: Text('Server Error'));
        _scaffoldKey.currentState.showSnackBar(snackBar);
      } else if (result.toString() == "empty") {
        setState(() {
          _isLoading = false;
        });

        final snackBar = SnackBar(content: Text('All Fields Are Required'));
        _scaffoldKey.currentState.showSnackBar(snackBar);
      } else {
        setState(() {
          _isLoading = false;
        });

        final snackBar = SnackBar(content: Text('An Error Ocurred'));
        _scaffoldKey.currentState.showSnackBar(snackBar);
      }
    });
  }
}
