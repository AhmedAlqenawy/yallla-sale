

import 'dart:ui';
import 'package:city_store/shpw-prodect.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'connectFb.dart';
import 'market-page.dart';
import 'const.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'notificationservice.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  pushnotification _fcm=new pushnotification();
  QuerySnapshot content;
  QuerySnapshot contentproduct;
  QuerySnapshot Topproduct;
  QuerySnapshot ProductImage;
  Firecategory fcategory =new Firecategory();
  Fireproduct fproduct =new Fireproduct();
  FireImage imm=new FireImage();
  var spinner =false;


  @override
  void initState() {

    super.initState();
    _fcm.initialise();
    fcategory.getcategory().then((data){
      setState(() {
        content = data;
      });
    });
    imm.getProduct().then((data){
      setState(() {
        ProductImage = data;
      });
    });
    fproduct.getProduct1().then((data){
      setState(() {
        contentproduct = data;
      });
    });
    fproduct.gettopProduct().then((data){
      setState(() {
        Topproduct = data;
      });
    });
  }
  String calcprice(var x,var y){
    y=x-((y/100)*x);
    return y.toString();
  }
  Widget Showcategory(){
    if(content!=null)
    {
      return ListView.builder(
        scrollDirection: Axis.horizontal,
        itemExtent: 70,
        padding: EdgeInsets.all(5.0),
        itemBuilder:(BuildContext context,index ){
          return Container(
            child: Column(
              children: <Widget>[
                Expanded(
                  child: GestureDetector(
                    child: CircleAvatar(
                      radius: 25,
                        backgroundImage: NetworkImage(content.documents[index].data['urlimage'])
                    ),
                    onTap:(){
                      setState(() {
                        spinner=true;
                      });
                      //print(contentproduct.documents[index].data['name']);
                      if(content.documents[index].data['name']=='all')
                        {
                          fproduct.getProduct1().then((data)
                          {
                            setState(() {
                              contentproduct = data;
                              spinner=false;
                            });
                          });
                          fproduct.gettopProduct().then((data){
                            setState(() {
                              Topproduct = data;
                            });
                          });
                        }
                      else 
                       {
                         fproduct.getProduct('${content.documents[index].data['name']}').then((data){
                        setState(() {
                          contentproduct = data;
                          spinner=false;
                        });
                      });
                         fproduct.gettopcatProduct('${content.documents[index].data['name']}').then((data){

                           setState(() {
                             Topproduct = data;
                           });
                         });
                       }
                    },
                  ),
                ),
                Text('${content.documents[index].data['name']}',
                  style: TextStyle(
                  color: Colors.white
                ),
                  overflow: TextOverflow.ellipsis,

                ),
              ],
            ),

          );
        }
        ,itemCount: content.documents.length,

      );
    }
    else if(content!=null&& content.documents.length==0){
      return Text("No data Avaliable");
    }
    else{
      return Text("Please wait its looding...");
    }

  }

  Widget ShowProduct() {
    if (contentproduct != null) {
     
      if(contentproduct.documents.length==0)
        return Center(child: Text("NO Product for this category"));
      else return GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount:2,
        ),
        itemCount: contentproduct.documents.length,
        itemBuilder: (BuildContext context, index) {
          return  GestureDetector(
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=>showproduct(prod: contentproduct.documents[index],)));
              print(contentproduct.documents[index]);
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
                          '${contentproduct.documents[index].data['urlimage']}',
                          height: 120,
                          width: 150,
                        ),

                        Text('${contentproduct.documents[index].data['name']}'),

                        Text(
                          '${contentproduct.documents[index].data['price']}',
                          style: TextStyle(decoration: TextDecoration.lineThrough,decorationColor: Colors.red ),
                        ),
                        Text(calcprice(contentproduct.documents[index].data['price'],contentproduct.documents[index].data['sale'])),
                      ])),
            ),
          );
        },
      );
    } else if (contentproduct != null && contentproduct.documents.length == 0) {
      return Center(child: Text("No data Avaliable"));
    } else {
      return Center(child: Text("Please wait its looding..."));
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: ModalProgressHUD(
          inAsyncCall: spinner,
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Container(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  child: Stack(
                    children: <Widget>[
                     Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            color: Colors.white,
                            height: 250,
                            child: Container(
                              decoration: BoxDecoration(
                                  color: Colors.black,
//                        image: DecorationImage(
//                          image: AssetImage('assets/images/ecommerce.png'),
//                          fit: BoxFit.fill,
//                        ),
                                  borderRadius: BorderRadius.only(
                                      bottomLeft: Radius.circular(100))),
                            ),
                          ),
                          Expanded(
                            child: Container(
                              color: Colors.black,
                              child: Container(
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.only(
                                        topRight: Radius.circular(100),
                                        bottomRight: Radius.circular(100))),
                              ),
                            ),
                          )
                        ],
                     ),
                      //top bar
                      Positioned(
                        child: Container(
                          padding: EdgeInsets.all(10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              //menu Icon
                              Icon(
                                Icons.menu,
                                color: Colors.white,
                                size: 30,
                              ),
                              SizedBox(
                                width: 180,
                              ),
                              //Search
                              Container(
                                height: 30,
                                width: 110,
                                child: TextField(
                                  decoration: InputDecoration(
                                      prefixIcon: Icon(
                                        Icons.search,
                                        color: Colors.white,
                                      ),
                                      border: OutlineInputBorder(
                                          borderSide: BorderSide(color: Colors.grey),
                                          borderRadius: BorderRadius.circular(30)),
                                      enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(color: Colors.grey),
                                          borderRadius: BorderRadius.circular(30)),
                                      focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(color: Colors.grey),
                                          borderRadius: BorderRadius.circular(30))),
                                ),
                              ),
                              CircleAvatar(
                                radius: 20,
                                backgroundImage: User.UserImage==null?AssetImage('assets/images/person.jpg'):NetworkImage(User.UserImage),
                              )
                            ],
                          ),
                        ),
                      ),
                      //ShowCategory
                      Positioned(
                         top: MediaQuery.of(context).size.height*0.07,
                         child: Container(
                             height: MediaQuery.of(context).size.height*0.1,
                             width: MediaQuery.of(context).size.width,
                             //color: Colors.red,
                             child: Showcategory()
                         )
                     ),
                      // top offer
                    Positioned(
                          top: MediaQuery.of(context).size.height*0.18,
                          child: Column(
                            children: <Widget>[
                              Container(
                                width: MediaQuery.of(context).size.width,
                                height:  MediaQuery.of(context).size.height*0.2,
                                child: Topproduct==null?
                                Center(
                                  child: CircularProgressIndicator(
                                    backgroundColor: Colors.red,
                                  ),
                                )
                                    :Swiper(
                                  itemCount: 10,
                                  loop: true,
                                  scale: 0.6,
                                  autoplay: true,
                                  viewportFraction: 0.99,
                                  pagination: SwiperPagination(),
                                  itemBuilder: (BuildContext context, int index) {
                                    return ClipRRect(
                                        borderRadius: BorderRadius.circular(40),
                                        child: Container(
                                          height:350,
                                          width: 200,
                                          child: GestureDetector(
                                            onTap: () {
                                              Duration(seconds: 2);
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) => Market(
                                                        market: index,
                                                      )));
                                            },
                                            child: Container(
                                              decoration: BoxDecoration(),
                                            ),
                                          ),
                                          decoration: BoxDecoration(
                                              image: DecorationImage(
                                                  image: NetworkImage(
                                                    '${Topproduct.documents[index].data['urlimage']}',
                                                  ),
                                                  fit: BoxFit.fill),
                                              borderRadius: BorderRadius.circular(40)),
                                        ));
                                  },
                                ),
                              ),
                            ],
                          )),
                      //ShowProduct
                     Positioned(
                          top: MediaQuery.of(context).size.height*0.42,
                          child: Container(
                              height: 400,
                             // color: Colors.red,
                              width: MediaQuery.of(context).size.width,
                              child: ShowProduct()
                          )
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
