import 'package:flutter/material.dart';
import 'const.dart';
import 'log-in.dart';
class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  @override
  Widget build(BuildContext context) {
    TextEditingController numcontrol;
    TextEditingController passcontrol;
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
                             // MyTextField(control: numcontrol, inputType: TextInputType.phone, icon: Icons.phone, position: 'top',hint:'Enter your Phone Number'),
                             // MyTextField(control: passcontrol, inputType: TextInputType.text, icon: Icons.lock, position: 'center',hint:'Enter your Password'),
                             // MyTextField(control: passcontrol, inputType: TextInputType.text, icon: Icons.lock, position: 'bottom',hint:'Confirm Password'),
                            ],
                          ),
                        ),
                      ),
                      Positioned(
                        bottom:170,
                        left:-25,
                        child: GestureDetector(
                          onTap: (){},
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
                        top:130,
                        right:140,
                        child: Container(
                          child: Text(
                            'Sign Up',
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
                      Positioned(
                        top:10,
                        left:15,
                        child: GestureDetector(
                          onTap: (){
                            Navigator.pop(context);
                          },
                          child: Icon(
                            Icons.arrow_back_ios,
                            size: 35,
                            color: Colors.white,
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
