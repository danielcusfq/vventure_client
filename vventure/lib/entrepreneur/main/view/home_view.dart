import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vventure/login/view/login_view.dart';
import 'package:vventure/entrepreneur/main/content/home/view/results.dart';
import 'package:vventure/entrepreneur/main/content/favorites/view/favorites.dart';
import 'package:vventure/entrepreneur/main/content/search/view/search.dart';
import 'package:vventure/entrepreneur/main/content/inspection/view/inspection.dart';
import 'package:vventure/entrepreneur/main/content/profile/view/profile.dart';

//this class contains all the navigation features of the entrepreneur

class EntrepreneurHomeView extends StatefulWidget {
  @override
  _EntrepreneurHomeViewState createState() => _EntrepreneurHomeViewState();
}

class _EntrepreneurHomeViewState extends State<EntrepreneurHomeView> {
  SharedPreferences sharedPreferences;
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    checkLoginStatus();
  }

  //main view for the app and navigation
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

  //get the index of the page thr user is going to navigate
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

  //check if user is logged in and is an entrepreneur
  checkLoginStatus() async {
    sharedPreferences = await SharedPreferences.getInstance();
    if (sharedPreferences.getString("id") == null ||
        sharedPreferences.getString("token") == null ||
        sharedPreferences.getString("type") == null ||
        sharedPreferences.getString("type") != "1" ||
        sharedPreferences.getString("activation") == null ||
        sharedPreferences.getString("activation") != "1") {
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (BuildContext context) => LoginView()),
          (Route<dynamic> route) => false);
    }
  }
}
