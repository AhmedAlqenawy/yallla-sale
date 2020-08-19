import 'package:city_store/splash_screen.dart';
import 'package:fancy_dialog/FancyAnimation.dart';
import 'package:fancy_dialog/FancyGif.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:fancy_dialog/fancy_dialog.dart';

class Login extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.light(),
      home: LoginPage(),
    );
  }
}

class LoginPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _LoginPageState();
  }
}

AuthResult fireauth;
SharedPreferences _sharedPreferences;

class _LoginPageState extends State<LoginPage> {
  @override
  void initState() {
    super.initState();
    sure();
  }

  SharedPreferences _sharedPreferences;

  void sure() async {
    _sharedPreferences = await SharedPreferences.getInstance();
    print(
        _sharedPreferences.getString('email') + '*******from sure************');
    if (_sharedPreferences.getString('email') != 'ahmed') {
      umail = _sharedPreferences.getString('email');
      upass = _sharedPreferences.getString('pass');
      done();
    }
  }

  var check = true;

  void onchange(val) {
    print(val);
    setState(() {
      check = val;
    });
  }

  void done() async {
    final formdata = _formKey.currentState;
    try {
      fireauth = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: umail, password: upass);
      _sharedPreferences.setString('email', umail);
      _sharedPreferences.setString('pass', upass);
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => splash_screen()));
    } catch (error) {
      print(umail + upass + fireauth.user.email);
    }
  }

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String _email, _pass;
  String upass, umail;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        body:   SingleChildScrollView(
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: Stack(
              children: <Widget>[
                Container(
                  width: double.infinity,
                  height: double.infinity,
                  child: Image.asset("images/background.png",fit: BoxFit.fill,),
                ),
                Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Center(child: Image.asset("assets/logo.png",height: 30,
                        width: 30,alignment: Alignment.center,)),
                      SizedBox(height: 13,),
                      Text("Ylla Sale App",
                        style: TextStyle(
                            fontSize: 27,color: Colors.white,
                            letterSpacing: 1

                        ),),
                      SizedBox(height: 30,),

                      SizedBox(height: 40,),
                      Text("Sign In", textAlign: TextAlign.center,style: TextStyle(
                        color: Colors.white,
                        letterSpacing: 1,
                        fontSize: 23,

                      ),),
                      SizedBox(height: 8,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text("قم بتسجيل الدخول ", textAlign: TextAlign.center,style:  TextStyle(
                            color: Colors.white70,
                            letterSpacing: 1,
                            fontSize: 17,

                          ),),
                        ],
                      ),
                      SizedBox(height: 30,),
                      Form(
                        child: Container(
                          margin: EdgeInsets.symmetric(vertical: 10,horizontal: 45),
                          child: Column(
                            children: <Widget>[
                              TextFormField(
                                style: TextStyle(color: Colors.white),
                                validator: (val) => val.isEmpty ? "Enter Valid Email":null,
                                decoration: InputDecoration(
                                  enabledBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(color: Colors.white)
                                  ),
                                  hintText: "Email",hintStyle: TextStyle(
                                    color: Colors.white,
                                    fontSize: 15
                                ),
                                ),
                                onChanged: (val){
                                  umail = val;
                                },
                              ),
                              SizedBox(height: 16,),
                              TextFormField(
                                style: TextStyle(color: Colors.white),
                                obscureText: true,
                                validator: (val) => val.isEmpty ? "Enter Password":null,
                                decoration: InputDecoration(
                                  enabledBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(color: Colors.white)
                                  ),
                                  hintText: "Password",hintStyle: TextStyle(
                                    color: Colors.white70,
                                    fontSize: 15
                                ),
                                ),
                                onChanged: (val){
                                  upass = val;
                                },
                              ),
                              SizedBox(height: 30,),
                              FlatButton(
                                onPressed: () {
                                  showDialog(
                                      context: context,
                                      builder: (BuildContext context) =>
                                          FancyDialog(
                                            title: "Dialog",
                                            descreption: "",
                                            okFun: done,
                                            animationType:
                                            FancyAnimation.TOP_BOTTOM,
                                            gifPath: FancyGif.SUBMIT,
                                          ));
                                },
                                child: Text("SUBMIT",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                        letterSpacing: 1)),
                                color: Colors.green,
                                shape: RoundedRectangleBorder(
                                    borderRadius:
                                    BorderRadius.circular(16.0)),
                              )

                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 20,),
                    ],
                  ),
                ),
              ],
            ),
          ),
        )
    );
  }
}
