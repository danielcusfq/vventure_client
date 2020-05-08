import 'package:flutter/material.dart';
import 'package:vventure/entrepreneur/main/content/view_profile/view/view_proflie.dart';

//this class represents a user profile card

class ProfileCard extends StatefulWidget {
  final String id;
  final String image;
  final String name;
  final String last;
  final String organization;

  //card constructor
  ProfileCard(
      {Key key,
      @required this.id,
      @required this.image,
      @required this.name,
      @required this.last,
      @required this.organization})
      : super(key: key);

  @override
  _ProfileCardState createState() => _ProfileCardState();
}

class _ProfileCardState extends State<ProfileCard> {
  //main widget view

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: () => {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) =>
                  ViewInvestorProfile(investorId: this.widget.id),
            ),
          )
        },
        child: Hero(
          tag: widget.id,
          child: Card(
              elevation: 8,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30.0),
              ),
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height / 5,
                padding: EdgeInsets.all(16.0),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Padding(
                      padding:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            this.widget.organization,
                            style: TextStyle(
                                fontSize: 26,
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                          ),
                          Spacer(),
                          Text(
                            this.widget.name,
                            style: TextStyle(fontSize: 22, color: Colors.black),
                          ),
                          Text(
                            this.widget.last,
                            style: TextStyle(fontSize: 22, color: Colors.black),
                          )
                        ],
                      ),
                    ),
                    Spacer(),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: CircleAvatar(
                        radius: (MediaQuery.of(context).size.height / 13),
                        backgroundImage: NetworkImage(this.widget.image),
                        backgroundColor: Colors.transparent,
                      ),
                    )
                  ],
                ),
              )),
        ),
      ),
    );
  }
}
