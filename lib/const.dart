import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
class MyTextField extends StatefulWidget {
  MyTextField({@required this.control,@required this.inputType,@required this.icon,@required this.position,@required this.hint});
  String control;
  TextInputType inputType;
  IconData icon;
  String position;
  String hint;
  @override
  _MyTextFieldState createState() => _MyTextFieldState();
}

class _MyTextFieldState extends State<MyTextField> {
  @override
  Widget build(BuildContext context) {
    double radius=60;
    return Container(
      child: TextField(
        onChanged: (val){
          setState(() {
            widget.control=val;
          });
        },
        cursorColor: Colors.white,
        keyboardType: widget.inputType,
        style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold
        ),
        decoration: widget.position=='center'?InputDecoration(
            hintText: widget.hint,
            hintStyle: TextStyle(
                color: Colors.white
            ),
            prefixIcon: Icon(widget.icon,color: Colors.white,),
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
        hintText: widget.hint,
        hintStyle: TextStyle(
            color: Colors.white
        ),
        prefixIcon: Icon(widget.icon,color: Colors.white,),
        border: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white,),
            borderRadius:widget.position=='top'? BorderRadius.only(topRight: Radius.circular(radius))
                :BorderRadius.only(bottomRight: Radius.circular(radius))
        ),
        enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
            borderRadius:widget.position=='top'? BorderRadius.only(topRight: Radius.circular(radius))
                :BorderRadius.only(bottomRight: Radius.circular(radius))
        ),
        focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white,width: 5),
            borderRadius:widget.position=='top'? BorderRadius.only(topRight: Radius.circular(radius))
                :BorderRadius.only(bottomRight: Radius.circular(radius))
        ),
      ),
      ),
    );
  }
}

class ProductItem extends StatefulWidget {
  ProductItem({@required this.price});
  double price;
  double totalPrice;
  @override
  _ProductItemState createState() => _ProductItemState();
}

class _ProductItemState extends State<ProductItem> {
  int itemNum=1;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      margin: EdgeInsets.only(right: 70,top: 10),
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: Colors.white10,
        borderRadius: BorderRadius.only(
            bottomRight: Radius.circular(50),
            topRight: Radius.circular(50)),
      ),
      child: Stack(
        children: <Widget>[
          Positioned(
            child: Container(
              height:100,
              margin: EdgeInsets.only(right: 70,top: 15,bottom: 15),
              padding: EdgeInsets.only(top:15),
              width: MediaQuery.of(context).size.width * 0.3,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(50),
                    topRight: Radius.circular(50)),
              ),
            ),
          ),
          Positioned(
            left: 140,
            top: 20,
            child: Text(
              'product name',
              style: TextStyle(
                  fontStyle: FontStyle.italic,
                  fontSize: 20,
                  color: Colors.white,
                  fontWeight: FontWeight.w700),
            ),
          ),
          Positioned(
            left: 160,
            top: 50,
            child: Text(
              '\$${widget.price}',
              style: TextStyle(
                  fontStyle: FontStyle.italic,
                  fontSize: 30,
                  color: Colors.white,
                  fontWeight: FontWeight.w700
              ),
            ),
          ),
          Positioned(
            right: 23,
            top: 1,
            child: Column(
              children: <Widget>[
                GestureDetector(
                    onTap: (){
                      setState(() {
                          itemNum++;
                          widget.totalPrice=itemNum*widget.price;
                      });
                    },
                    child: Icon(
                      Icons.arrow_drop_up,
                      size: 40,
                      color: Colors.white,
                    )
                ),
                Text(
                  itemNum.toString(),
                  style: TextStyle(
                      fontStyle: FontStyle.italic,
                      fontSize: 25,
                      color: Colors.white,
                      fontWeight: FontWeight.bold
                  ),
                ),
                GestureDetector(
                  onTap: (){
                    setState(() {
                      if(itemNum>1)
                      itemNum--;
                      widget.totalPrice=itemNum*widget.price;
                    });
                  },
                  child: Icon(
                      Icons.arrow_drop_down,
                      size: 40,
                      color: Colors.white,
                    )
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
//****************************************************************************

class User {
   static String UserName;
   static int UserPhone;
   static String UserImage;
   static double lat;
   static double long;
   static String city;
   static int distance;
  //User({this.UserName,this.UserPhone,this.UserImage,this.long,this.lat,this.city});
}