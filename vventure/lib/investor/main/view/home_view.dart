import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vventure/login/view/login_view.dart';
import 'package:vventure/investor/main/content/home/view/results.dart';
import 'package:vventure/investor/main/content/favorites/view/favorites.dart';
import 'package:vventure/investor/main/content/search/view/search.dart';
import 'package:vventure/investor/main/content/inspection/view/inspection.dart';
import 'package:vventure/investor/main/content/profile/view/profile.dart';

//this widget contains main navigation bar and houses main scaffold

class InvestorHomeView extends StatefulWidget {
  @override
  _InvestorHomeViewState createState() => _InvestorHomeViewState();
}

class _InvestorHomeViewState extends State<InvestorHomeView> {
  SharedPreferences sharedPreferences;
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    checkLoginStatus();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: _getPage(_currentIndex),
        bottomNavigationBar: BottomNavigationBar(
          items: [
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.home,
                  color: Color.fromRGBO(132, 94, 194, 1),
                ),
                title: Text(
                  "Inicio",
                  style: TextStyle(color: Color.fromRGBO(132, 94, 194, 1)),
                ),
                backgroundColor: Colors.white),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.favorite_border,
                  color: Color.fromRGBO(132, 94, 194, 1),
                ),
                title: Text(
                  "Favoritos",
                  style: TextStyle(color: Color.fromRGBO(132, 94, 194, 1)),
                ),
                backgroundColor: Colors.white),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.search,
                  color: Color.fromRGBO(132, 94, 194, 1),
                ),
                title: Text(
                  "Buscar",
                  style: TextStyle(color: Color.fromRGBO(132, 94, 194, 1)),
                ),
                backgroundColor: Colors.white),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.assessment,
                  color: Color.fromRGBO(132, 94, 194, 1),
                ),
                title: Text(
                  "Inspección",
                  style: TextStyle(color: Color.fromRGBO(132, 94, 194, 1)),
                ),
                backgroundColor: Colors.white),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.account_circle,
                  color: Color.fromRGBO(132, 94, 194, 1),
                ),
                title: Text(
                  "Perfil",
                  style: TextStyle(color: Color.fromRGBO(132, 94, 194, 1)),
                ),
                backgroundColor: Colors.white)
          ],
          currentIndex: _currentIndex,
          onTap: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
        ),
      ),
    );
  }

  //navigates to page
  _getPage(int index) {
    switch (index) {
      case 0:
        return MainResults();
      case 1:
        return Favorites();
      case 2:
        return Search();
      case 3:
        return Inspection();
      case 4:
        return Profile();
        break;
      default:
        return MainResults();
    }
  }

  //checks log in status
  checkLoginStatus() async {
    sharedPreferences = await SharedPreferences.getInstance();
    if (sharedPreferences.getString("id") == null ||
        sharedPreferences.getString("token") == null ||
        sharedPreferences.getString("type") == null ||
        sharedPreferences.getString("type") != "2" ||
        sharedPreferences.getString("activation") == null ||
        sharedPreferences.getString("activation") != "1") {
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (BuildContext context) => LoginView()),
          (Route<dynamic> route) => false);
    }
  }
}
