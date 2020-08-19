

import 'package:firebase_messaging/firebase_messaging.dart';
import 'dart:io';
class pushnotification{
  final FirebaseMessaging _fcm=new FirebaseMessaging();
  Future initialise() async {
    if(Platform.isAndroid){
      _fcm.requestNotificationPermissions( IosNotificationSettings());
    }
    _fcm.configure(
      onMessage: (Map<String, dynamic> message) async {
        print("onMessage: $message");
      },
      onLaunch:  (Map<String, dynamic> message) async {
        print("onLaunch: $message");
      },
      onResume:  (Map<String, dynamic> message) async {
        print("onResume: $message");
      },
    );
  }
  void navigate(Map<String, dynamic> message){
    var data =message['data'];
    var view =message['view'];
    if(view !=null){
    /*  if(view=='home'){
        Navigator.pushReplacement(BuildContext context,  MaterialPageRoute(
            builder: (context) => Home();
        ));
      }*/
    }
  }
}