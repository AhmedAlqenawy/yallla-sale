import 'package:city_store/home.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'const.dart';
import 'regist.dart';
import 'main.dart';
class LogIn extends StatefulWidget {
  @override
  _LogInState createState() => _LogInState();
}

class _LogInState extends State<LogIn> {
  String phoneNo;
  String smsCode;
  String verififcationId;
  final _codeController=TextEditingController();
  final _phoneController=TextEditingController();
  Container buildContainer(
  TextInputType inputType,
  IconData icon,
  String position,
  String hint,){
    double radius=60;
    return Container(
      child: TextField(
        controller: _phoneController,
        cursorColor: Colors.white,
        keyboardType: inputType,
        style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold
        ),
        decoration: position=='center'?InputDecoration(
          hintText: hint,
          hintStyle: TextStyle(
              color: Colors.white
          ),
          prefixIcon: Icon(icon,color: Colors.white,),
          border: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white,),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white,width: 5),
          ),
        ):InputDecoration(
          hintText: hint,
          hintStyle: TextStyle(
              color: Colors.white
          ),
          prefixIcon: Icon(icon,color: Colors.white,),
          border: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.white,),
              borderRadius:position=='top'? BorderRadius.only(topRight: Radius.circular(radius))
                  :BorderRadius.only(bottomRight: Radius.circular(radius))
          ),
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.white),
              borderRadius:position=='top'? BorderRadius.only(topRight: Radius.circular(radius))
                  :BorderRadius.only(bottomRight: Radius.circular(radius))
          ),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.white,width: 5),
              borderRadius:position=='top'? BorderRadius.only(topRight: Radius.circular(radius))
                  :BorderRadius.only(bottomRight: Radius.circular(radius))
          ),
        ),
      ),
    );
  }

  Future<bool> verifyphone(String phone)async{
    final PhoneCodeAutoRetrievalTimeout autoRetrive=(String verId){
      verififcationId=verId;
    };

    FirebaseAuth _auth=FirebaseAuth.instance;
    await _auth.verifyPhoneNumber(
        phoneNumber: phone,
        timeout: Duration(seconds: 30),
        verificationCompleted:(AuthCredential credential)async{
          Navigator.of(context).pop();
          AuthResult result=await _auth.signInWithCredential(credential);

          FirebaseUser user=result.user;
          if(user!=null){
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>MyHomePage()));
          }
          else
          {
            print('error');
          }
        } ,
        verificationFailed:(AuthException exption){
          print('${exption.message}');
        },
        codeSent: (String verId,[int forceResendingToken]){
          showDialog(
              context: context,
              barrierDismissible: false,
              builder: (BuildContext context){
                return AlertDialog(
                  title: Text('Enter sms Code'),
                  elevation: 15,
                  actions: <Widget>[
                    FlatButton(
                      child: Text('Done'),
                      onPressed: ()async{
                        final  code=_codeController.text.trim();
                        AuthCredential credential=PhoneAuthProvider.getCredential(verificationId: verififcationId, smsCode:code);

                        AuthResult result=await _auth.signInWithCredential(credential);

                        FirebaseUser user=result.user;
                          if(user!=null){
                            Navigator.pop(context);
                            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>MyHomePage()));
                          }
                          else
                          {
                            print('error');
                          }
                        }
                    )
                  ],
                  content: TextField(
                    controller: _codeController,
                  ),
                );
              }
          );
        },
        codeAutoRetrievalTimeout: autoRetrive
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: (
          Container(
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.7)
              ),
              child: Stack(
                children: <Widget>[
                  Positioned(
                    top:250,
                    left: -5,
                    child: Container(
                      height: 200,
                      width: MediaQuery.of(context).size.width*0.8,
                      child: Column(
                        children: <Widget>[
                          buildContainer( TextInputType.phone,  Icons.phone,  'top','Enter your Phone Number'),
                          buildContainer( TextInputType.text, Icons.lock, 'bottom','Enter your Password'),
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    bottom:200,
                    left:-25,
                    child: GestureDetector(
                      onTap: (){
                        final phone=_phoneController.text.trim();
                        verifyphone(phone);
                      },
                      child: Container(
                        width: 220,
                        height: 60,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(40)
                        ),
                        child: Icon(
                          Icons.send,
                          size: 35,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom:110,
                    left:-25,
                    child: GestureDetector(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>Register()));
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: 20),
                        width: 220,
                        height: 60,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(40)
                        ),
                        child: Text(
                          'Create New Account',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w700,
                            fontSize: 18
                          ),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top:130,
                    right:140,
                    child: Container(
                      child: Text(
                        'Sign In',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 45,
                          fontStyle: FontStyle.italic
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            decoration: BoxDecoration(
                color: Colors.black,
            image: DecorationImage(
              image: AssetImage('assets/images/ecommerce.png'),
              fit: BoxFit.fill
            )
            ),
          )
          ),
        ),
      ),
    );
  }
}
