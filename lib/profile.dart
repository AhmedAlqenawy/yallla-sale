import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'const.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  List<Marker> marker=[];
  @override
  void initState() {
    super.initState();
    marker.add(
        Marker(
      markerId: MarkerId('My Location'),
      draggable: false,
      position: User.lat==null?LatLng(89.25467,99.54875):LatLng(User.lat,User.long),
    ));
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          color: Colors.white,
          child:Stack(
            children: <Widget>[
              //back image
              Positioned(
                child: Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        colorFilter: ColorFilter.mode(Colors.black, BlendMode.dstATop),
                          image: AssetImage('assets/images/profile.jpg'),
                          fit: BoxFit.fill
                      ),
                    ),
                    height: 300,
                    width: MediaQuery.of(context).size.width
                ),
              ),
              //user image
              Positioned(
                top: 50,
                left: 40,
                child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      image: DecorationImage(
                          image:User.UserImage==null?AssetImage('assets/images/person.jpg'):NetworkImage(User.UserImage),
                          fit: BoxFit.fill
                      ),
                    ),
                    height: 100,
                    width:100
                ),
              ),
              //user name
              Positioned(
                top: 60,
                left: 160,
                child: Text(
                  User.UserName==null?'Ahmed Ahmed':User.UserName,
                  style: TextStyle(
                    letterSpacing: 1.5,
                      color: Colors.white,
                      fontWeight: FontWeight.w900,
                      fontSize: 22
                  ),
                ),
              ),
              //user phone number
              Positioned(
                top: 105,
                left: 170,
                child: Row(
                  children: <Widget>[
                    Icon(
                      Icons.phone,
                      size: 25,
                      color: Colors.white,
                    ),
                    SizedBox(width: 10,),
                    Text(
                      User.UserPhone==null?'01222222222':User.UserPhone.toString(),
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w400,
                          fontSize: 18
                      ),
                    ),
                  ],
                ),
              ),
              Positioned(
                  top: 230,
                  child: Container(
                    height:430 ,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(topLeft: Radius.circular(50),topRight: Radius.circular(50),
                      ),
                      color: Colors.white,
                    ),
                  )
              ),
            ],
          ),
        ),
      ),
    );
  }
}
