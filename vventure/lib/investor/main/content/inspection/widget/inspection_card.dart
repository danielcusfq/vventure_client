import 'package:flutter/material.dart';
import 'package:vventure/investor/main/content/inspection/view/view_inspection.dart';

class InspectionCard extends StatefulWidget {
  final investorID;
  final token;
  final String id;
  final String image;
  final String stage;
  final String organization;
  final String inspection;
  InspectionCard(
      {Key key,
      @required this.investorID,
      @required this.token,
      @required this.id,
      @required this.image,
      @required this.stage,
      @required this.organization,
      @required this.inspection})
      : super(key: key);

  @override
  _InspectionCardState createState() => _InspectionCardState();
}

class _InspectionCardState extends State<InspectionCard> {
  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: widget.inspection,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ViewPreviousInspection(
                    id: widget.investorID,
                    token: widget.token,
                    inspection: widget.inspection),
              ),
            );
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
                            "Stage",
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
      ),
    );
  }
}
