import 'package:flutter/material.dart';

//widget that shows loading status

class LoadingWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
          width: 100,
          height: 100,
          child: CircularProgressIndicator(
            valueColor:
                AlwaysStoppedAnimation<Color>(Color.fromRGBO(255, 150, 113, 1)),
          ),
        ),
      ],
    );
  }
}
