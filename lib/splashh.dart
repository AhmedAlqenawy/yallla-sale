import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'loginpage.dart';

class splash extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _Splash();
  }
}

  class _Splash extends State<splash>{
  @override
  void initState() {
  // TODO: implement initState
  super.initState();
  pref();
  startTimer();
  }
  SharedPreferences _sharedPreferences;
  pref()async{
    _sharedPreferences=await SharedPreferences.getInstance();
    if(_sharedPreferences.getString('email')==null){
    _sharedPreferences.setString('email', 'ahmed');
    _sharedPreferences.setString('pass' , 'ahmed');
    }
  }
  startTimer () async {
  var duration = Duration (seconds: 0);
  return Timer (duration,route);
  }
  route(){
  Navigator.pushReplacement(context, MaterialPageRoute(
  builder: (context) => Login()
  ));
  }
  @override
  Widget build(BuildContext context) {
  // TODO: implement build
  return Scaffold(
  backgroundColor: Colors.white,
  body: Center (
  child: Column (
  mainAxisAlignment: MainAxisAlignment.center,
  children: <Widget>[
  Container(
  ),

  ],),),);
  }

  }