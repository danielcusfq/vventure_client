import 'package:flutter/material.dart';
import 'package:vventure/investor/main/content/view_profile/view/view_profile.dart';

class ProfileCard extends StatefulWidget {
  final String id;
  final String image;
  final String stage;
  final String organization;
  final bool inspection;
  final String inspectionid;
  ProfileCard(
      {Key key,
      @required this.id,
      @required this.image,
      @required this.stage,
      @required this.organization,
      @required this.inspection,
      this.inspectionid})
      : super(key: key);

  @override
  _ProfileCardState createState() => _ProfileCardState();
}

class _ProfileCardState extends State<ProfileCard> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: () {
          if (widget.inspection == true) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ViewEntrepreneurProfile(
                  entrepreneurId: this.widget.id,
                  inspection: true,
                  inspectionId: widget.inspectionid,
                ),
              ),
            );
          } else {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ViewEntrepreneurProfile(
                    entrepreneurId: this.widget.id, inspection: false),
              ),
            );
          }
        },
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
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
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
                          "Etapa",
                          style: TextStyle(fontSize: 18, color: Colors.black),
                        ),
                        Text(
                          this.widget.stage,
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
    );
  }
}
