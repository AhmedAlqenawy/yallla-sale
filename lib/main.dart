import 'package:city_store/log-in.dart';
import 'package:city_store/shops.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'cart.dart';
import 'profile.dart';
import 'home.dart';
import 'personal-info.dart';
import 'splash.dart';
import 'market-page.dart';
import 'package:fancy_bottom_navigation/fancy_bottom_navigation.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(

      debugShowCheckedModeBanner: false,
      title: 'City Stores',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home:Splah(),

    );
  }
}
class MyHomePage extends StatefulWidget {
  MyHomePage({Key key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
 int _currentIndex=0;
 List<Widget> _pages;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }
 
}