import 'package:city_store/splashh.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:loading_animations/loading_animations.dart';
import 'log-in.dart';
import 'personal-info.dart';
class Splah extends StatefulWidget {
  @override
  _SplahState createState() => _SplahState();
}

class _SplahState extends State<Splah> with SingleTickerProviderStateMixin{

  AnimationController _animationController;
  @override
  void initState() {
  super.initState();
  _animationController=AnimationController(
      vsync: this,
      duration: Duration(seconds: 2),
      upperBound: 400
  );
  _animationController.forward();
  _animationController.addListener(() {
    setState(() {

    });
  });
  Timer(Duration(seconds: 5),(){
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>splash()));
  });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Stack(
          children: <Widget>[
            Positioned(
                top:-35,
                left: -40,
                child: Image(
                  width: _animationController.value,
                  height: 400,
                  image: AssetImage('assets/images/splash.jpeg'),
                ),
            ),
            Positioned(
                top:110,
                left: 110,
                child: Text(
                  'Yalla Sale',
                  style: TextStyle(
                      fontSize: _animationController.value*0.15,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                )
            ),
            Positioned(
                top:180,
                left: _animationController.value*0.30,
                child: Text(
                  'Discover Offers',
                  style: TextStyle(
                      fontStyle: FontStyle.italic,
                      letterSpacing: 2,
                      wordSpacing: 3,
                      fontSize: 20,
                      color: Colors.pink,
                      fontWeight: FontWeight.w400),
                )
            ),
            Positioned(
              top: 300,
              left: 150,
              child: LoadingBouncingGrid.circle(
                  size: 120,
                  duration: Duration(seconds: 1),
                  backgroundColor: Colors.pink,
                ),
            ),
          ],
        ),
      ),
    );
  }
}
