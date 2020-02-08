import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:vventure/basic_profile/entrepreneur/model/basic_profile.dart';
import 'package:vventure/basic_profile/entrepreneur/view/basic_second.dart';

class EntrepreneurBasicProfileView extends StatefulWidget {
  final BasicProfileEntrepreneur basicProfileEntrepreneur;
  EntrepreneurBasicProfileView(
      {Key key, @required this.basicProfileEntrepreneur})
      : super(key: key);

  @override
  _EntrepreneurBasicProfileViewState createState() =>
      _EntrepreneurBasicProfileViewState();
}

class _EntrepreneurBasicProfileViewState
    extends State<EntrepreneurBasicProfileView> {
  File _image;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        bottomOpacity: 0,
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Color.fromRGBO(132, 94, 194, 1),
          ),
          onPressed: () => Navigator.pop(context, false),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(color: Colors.white),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text("Welcome to VVENTURE", style: TextStyle(fontSize: 20)),
            Container(
              height: MediaQuery.of(context).size.height / 3,
              child: _image == null
                  ? Image.asset(
                      'assets/images/add_profile_image.png',
                      width: 150,
                      height: 150,
                    )
                  : Container(
                      height: MediaQuery.of(context).size.height / 3,
                      width: MediaQuery.of(context).size.height / 3,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                              image: FileImage(_image), fit: BoxFit.fill)),
                    ),
            ),
            FlatButton(
              onPressed: getImage,
              child: Text(
                "Add Profile Image",
                style: TextStyle(fontSize: 20),
              ),
            ),
            Container(
              height: 5,
            ),
            FlatButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => BasicProfileSecondEnt(
                              basicProfileEntrepreneur:
                                  this.widget.basicProfileEntrepreneur,
                            )));
              },
              child: Text(
                "Next",
                style: TextStyle(fontSize: 20),
              ),
            ),
          ],
          //child: _image == null ? Text('No image selected.') : Image.file(_image),
        ),
      ),
    );
  }

  Future getImage() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      _image = image;
      this.widget.basicProfileEntrepreneur.profilePicture = _image;
    });
  }
}
