import 'package:city_store/shopproducts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

import 'connectFb.dart';

class Shops extends StatefulWidget {
  @override
  _ShopsState createState() => _ShopsState();
}

class _ShopsState extends State<Shops> {
  QuerySnapshot content;
  Fireproduct fcategory =new Fireproduct();
  void initState() {
    fcategory.getshop().then((data){
      setState(() {
        content = data;
      });
    });
  }
  Widget done(){
    if(content!=null)
   {
     return GridView.count(
       crossAxisCount: 2,
       children: List.generate(
         content.documents.length,
             (int index) {
           return AnimationConfiguration.staggeredGrid(
             position: index,
             duration: const Duration(milliseconds: 375),
             columnCount: 2,
             child: ScaleAnimation(
               child: FadeInAnimation(
                   child:GestureDetector(
                     onTap: (){
                       Navigator.push(context, MaterialPageRoute(builder: (context)=>ShopProduct(
                         prod: content.documents[index],
                       )));
                     },
                     child: SizedBox(
                       //height: 500,
                       //width: 120,
                       child: Container(
                           margin: EdgeInsets.all(5),
                           decoration: BoxDecoration(
                               color: Colors.blue[100],
                               borderRadius: BorderRadius.only(topRight: Radius.circular(30),bottomLeft: Radius.circular(30))
                           ),
                           child: Column(
                               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                               children: <Widget>[
                                 Image.network(
                                   '${content.documents[index].data['image']}',
                                   height: 120,
                                   width: 150,
                                 ),
                                 Text('${content.documents[index].data['name']}'),
                               ])),
                     ),
                   )
               ),
             ),
           );
         },
       ),
     );
   }else if(content!=null&& content.documents.length==0){
      return Center(child: Text("No data Avaliable"));
    }
    else{
      return Center(child: Text("Please wait its looding..."));
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimationLimiter(
        child: done()
      ),

    );
  }
}
