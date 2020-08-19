import 'package:city_store/shpw-prodect.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

import 'connectFb.dart';

class fav extends StatefulWidget {
  @override
  _favState createState() => _favState();
}

class _favState extends State<fav> {
  QuerySnapshot Topproduct;
  Firecategory fcategory =new Firecategory();
  Fireproduct fproduct =new Fireproduct();

  @override
  void initState() {
    super.initState();


    fproduct.getfavProduct().then((data){
      setState(() {
        Topproduct = data;
      });
    });
  }
  String calcprice(var x,var y){
    y=x-((y/100)*x);
    return y.toString();
  }
  Widget ShowProduct() {
    if (Topproduct != null) {

      if(Topproduct.documents.length==0)
        return Center(child: Text("NO Product for this Favoirt"));
      else return GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount:2,
        ),
        itemCount: Topproduct.documents.length,
        itemBuilder: (BuildContext context, index) {
          return  GestureDetector(
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=>showproduct(prod: Topproduct.documents[index],)));
              print(Topproduct.documents[index]);
            },
            child: SizedBox(
              //height: 500,
              //width: 120,
              child: Card(
                  color: Colors.white10,
                  elevation: 10.0,
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Image.network(
                          '${Topproduct.documents[index].data['urlimage']}',
                          height: 120,
                          width: 150,
                        ),

                        Text('${Topproduct.documents[index].data['name']}'),

                        Text(
                          '${Topproduct.documents[index].data['price']}',
                          style: TextStyle(decoration: TextDecoration.lineThrough,decorationColor: Colors.red ),
                        ),
                        Text(calcprice(Topproduct.documents[index].data['price'],Topproduct.documents[index].data['sale'])),
                      ])),
            ),
          );
        },
      );
    } else if (Topproduct != null && Topproduct.documents.length == 0) {
      return Center(child: Text("No data Avaliable"));
    } else {
      return Center(child: Text("Please wait its looding..."));
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: AnimationLimiter(
        child:ShowProduct()));
   }

}