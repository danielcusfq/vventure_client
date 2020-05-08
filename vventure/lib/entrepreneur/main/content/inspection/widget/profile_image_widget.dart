import 'package:flutter/material.dart';

//this widget contain the profile image of the investor

class ProfileImageWidget extends StatefulWidget {
  final String image;
  ProfileImageWidget({
    Key key,
    @required this.image,
  }) : super(key: key);

  @override
  _ProfileImageWidgetState createState() => _ProfileImageWidgetState();
}

class _ProfileImageWidgetState extends State<ProfileImageWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Container(
              child: CircleAvatar(
            radius: MediaQuery.of(context).size.height / 7,
            backgroundImage: NetworkImage(widget.image),
            backgroundColor: Colors.transparent,
          ))
        ],
      ),
    );
  }
}
