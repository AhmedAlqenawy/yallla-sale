import 'package:city_store/shpw-prodect.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

import 'connectFb.dart';
class ShopProduct extends StatefulWidget {
  var prod;
  ShopProduct({@required this.prod});
  @override
  _ShopProductState createState() => _ShopProductState();
}

class _ShopProductState extends State<ShopProduct> {
  QuerySnapshot content;
  Fireproduct fcategory =new Fireproduct();
  void initState() {
    fcategory.getProductshop(widget.prod["name"]).then((data){
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
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>showproduct(prod: content.documents[index])));
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
                                  '${content.documents[index].data['urlimage']}',
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
      return Text("No data Avaliable");
    }
    else{
      return Text("Please wait its looding...");
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height*0.2,
                   child:Image.network(
                        '${widget.prod['image']}',
                        height: 120,
                        width: 150,
                     fit: BoxFit.fill,
                   )
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height*0.13,
                  child: Column(
                    children: <Widget>[
                      Expanded(
                        child: Container(
                            decoration: BoxDecoration(
                                color: Colors.blue[100],
                                borderRadius: BorderRadius.only(topRight: Radius.circular(30),bottomLeft: Radius.circular(30))
                            ),
                            margin: EdgeInsets.all(5),
                            padding: EdgeInsets.symmetric(horizontal: 10),
                            child: Row(
                              children: <Widget>[
                                Icon(Icons.location_on),
                                Text("${widget.prod['address']}",
                                textAlign: TextAlign.center,
                                ),
                              ],
                            )
                        ),
                      ),
                      SizedBox(height: 5,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                       children: <Widget>[
                         Expanded(
                           child: Container(
                               padding: EdgeInsets.all(10),
                               margin: EdgeInsets.all(5),
                               decoration: BoxDecoration(
                                   color: Colors.blue[100],
                                   borderRadius: BorderRadius.only(topRight: Radius.circular(30),bottomLeft: Radius.circular(30))
                               ),
                               child: Row(
                                 children: <Widget>[
                                   Icon(Icons.timelapse),
                                   Padding(
                                     padding: const EdgeInsets.symmetric(horizontal: 8),
                                     child: Text('${widget.prod['work time']}'),
                                   ),
                                 ],
                               )
                           ),
                         ),
                         Expanded(
                           child: Container(
                               padding: EdgeInsets.all(10),
                               margin: EdgeInsets.all(5),
                               decoration: BoxDecoration(
                                   color: Colors.blue[100],
                                   borderRadius: BorderRadius.only(topRight: Radius.circular(30),bottomLeft: Radius.circular(30))
                               ),
                               child: Row(
                                 children: <Widget>[
                                   Icon(Icons.phone),
                                   Padding(
                                     padding: const EdgeInsets.symmetric(horizontal: 5),
                                     child: Text('${widget.prod['phone']}'),
                                   ),
                                 ],
                               )
                           ),
                         ),
                       ],
                      ),
                    ],
                  ),
                  ),
                Container(
                    width: MediaQuery.of(context).size.width,
                    child:Divider(
                      thickness: 2,
                    )
                ),
                Expanded(
                  child: AnimationLimiter(
                    child: done()
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
