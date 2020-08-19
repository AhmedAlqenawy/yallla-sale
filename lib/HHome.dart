import 'package:city_store/shops.dart';
import 'package:fancy_bottom_navigation/fancy_bottom_navigation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

import 'cart.dart';
import 'faverot.dart';
import 'home.dart';
import 'loginpage.dart';
import 'personal-info.dart';

class HHome extends StatefulWidget {
  @override
  _HHomeState createState() => _HHomeState();
}

class _HHomeState extends State<HHome> {
  SharedPreferences _sharedPreferences;
  void sure() async {
    _sharedPreferences = await SharedPreferences.getInstance();
    _sharedPreferences.setString('email',null);
    print(_sharedPreferences.getString('email'));
    }

  int _currentIndex=0;

  List<Widget> _pages;
  @override
  void initState() {
    _pages = [
      Home(),
      fav(),
      Shops()
    ];
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    SharedPreferences _sharedPreferences;
    return Scaffold(
      drawer:  Drawer(
      elevation: 15,
      child: ListView(
        children: <Widget>[
          UserAccountsDrawerHeader(
            decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: <Color>[
                    Colors.greenAccent,
                    Colors.lightGreenAccent,
                  ],
                ),
                color: Colors.red[100],
                image: DecorationImage(
                  image: AssetImage("images/project_logo.png"),
                )),
          ),
          GestureDetector(
            onTap: (){
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) =>PersonalData() ),);
            },
            child: ListTile(
              title: Text(
                "Profile",
                style: TextStyle(fontSize: 20),
              ),
              leading: Icon(
                Icons.account_circle,
                color: Colors.blue,
                size: 35,
              ),
            ),
          ),
          ListTile(
            title: Text("Notification", style: TextStyle(fontSize: 20)),
            leading: Icon(Icons.notifications,
                color: Colors.orangeAccent, size: 35),
          ),
          GestureDetector(
onTap: (){
  Navigator.of(context).push(MaterialPageRoute(
      builder: (context) =>fav() ),);
},
            child: ListTile(
              title: Text("My Faviorate", style: TextStyle(fontSize: 20)),
              leading: Icon(Icons.favorite, color: Colors.red, size: 35),
            ),
          ),
          ListTile(
            title: Text("Rate App", style: TextStyle(fontSize: 20)),
            leading: Icon(Icons.star,
                color: Colors.yellowAccent[200], size: 35),
          ),
          ListTile(
            title: Text("About", style: TextStyle(fontSize: 20)),
            leading:
            Icon(Icons.info_outline, color: Colors.black54, size: 35),
          ),
          GestureDetector(
            onTap: (){
              launch("tel:01023290023");
              print("XZ");
            },
            child: ListTile(
              title: Text("Contact Us", style: TextStyle(fontSize: 20)),
              leading: Icon(Icons.contact_mail,
                  color: Colors.green[500], size: 35),
            ),
          ),
          InkWell(
            onTap: (){
              sure();
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) =>LoginPage() ),);
            },
            child: ListTile(

              title: Text("Log Out", style: TextStyle(fontSize: 20)),
              leading: Icon(Icons.lock, color: Colors.black, size: 35),
            ),
          ),
        ],
      ),
    ),
        body: _pages==null?CircularProgressIndicator():_pages[_currentIndex],
        bottomNavigationBar: FancyBottomNavigation(
          tabs: [
            TabData(iconData:Icons.home,title: 'Home'),
            TabData(iconData:Icons.favorite,title: 'Favorite'),
            TabData(iconData:Icons.shop,title: 'Shops'),
          ],
          initialSelection: 0,
          circleColor: Colors.black,
          inactiveIconColor: Colors.black,
          onTabChangedListener: (position){
            setState(() {
              _currentIndex=position;
            });
          },
        )
    );
  }
}