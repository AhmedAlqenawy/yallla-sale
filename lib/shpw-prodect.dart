import 'package:city_store/shopproducts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_simple_rating_bar/flutter_simple_rating_bar.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

import 'connectFb.dart';

class showproduct extends StatefulWidget {
   var prod;
 // final List<String> ls;
  showproduct({@required this.prod});
  @override
  _product createState() => _product();
}

class _product extends State<showproduct> {
  QuerySnapshot content;
  Fireproduct fcategory =new Fireproduct();
Color colo;

  List<String> ls=new List<String>();
  void initState() {
    fcategory.gettopcatProduct(widget.prod["categoryname"]).then((data){
      setState(() {
        content = data;
      });
    });
    if(widget.prod["fav"]==true)
      colo=Colors.red;
    else
      colo=Colors.black;
    setState(() {
      ls.add(widget.prod["urlimage"]);
      ls.add(widget.prod["urlimage2"]);
      ls.add(widget.prod["urlimage3"]);
    });
  }
  String calcprice(var x,var y){
    y=x-((y/100)*x);
    return y.toString();
  }
  Widget Showrelatedproduct(){
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
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
                                child:Container(
                                  width: MediaQuery.of(context).size.width,
                                  height: MediaQuery.of(context).size.height*0.1,
                                  child: Swiper(
                                    itemCount: ls.length,
                                    loop: true,
                                    scale: 0.5,
                                    autoplay: true,
                                    viewportFraction: 0.6,
                                    pagination: SwiperPagination(),
                                    itemBuilder: (BuildContext context, int index) {
                                      return ClipRRect(
                                          borderRadius: BorderRadius.circular(40),
                                          child: Container(
                                            width: MediaQuery.of(context).size.width,
                                            height: MediaQuery.of(context).size.height*0.1,
                                            child: GestureDetector(
                                              child: Container(
                                                decoration: BoxDecoration(),
                                              ),
                                            ),
                                            decoration: BoxDecoration(
                                                image: DecorationImage(
                                                    image: NetworkImage(ls[index]),
                                                    fit: BoxFit.fill),
                                                borderRadius: BorderRadius.circular(40)),
                                          ));
                                    },
                                  ),
                                ) ,
                                decoration: BoxDecoration(
                                    color: Colors.black,
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
                            ),
                          ],
                        ),
                        Positioned(
                          top: 300,
                          child: Container(
                            padding: EdgeInsets.all(20),
                            height: MediaQuery.of(context).size.height-300,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Container(
                                  child: Text(
                                    widget.prod['name'].toString(),
                                    style: TextStyle(
                                     fontSize: 25,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Colors.blue[100],
                                    borderRadius: BorderRadius.only(topRight:Radius.circular(30),bottomLeft: Radius.circular(30)),
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.all(20),
                                  decoration: BoxDecoration(
                                      color: Colors.blue[100],
                                    borderRadius: BorderRadius.only(topRight:Radius.circular(30),bottomLeft: Radius.circular(30)),
                                  ),
                                  child: Row(
                                    children: <Widget>[
                                    Text("Shop :"),
                                    GestureDetector(
                                      onTap: (){
                                        Navigator.push(context, MaterialPageRoute(builder: (context)=>ShopProduct(prod: widget.prod,)));

                                      },
                                          child: Text(widget.prod['shopname']
                                          ,
                                            style: TextStyle(
                                              color: Colors.blue
                                            ),
                                          ),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.all(20),
                                  decoration: BoxDecoration(
                                      color: Colors.blue[100],
                                    borderRadius: BorderRadius.only(topRight:Radius.circular(30),bottomLeft: Radius.circular(30)),                                  ),
                                  child: Row(
                                    children: <Widget>[
                                      Text("offer end date : "),
                                      Text(widget.prod['lasttime'].toDate().toString()),
                                    ],
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.all(20),
                                  decoration: BoxDecoration(
                                      color: Colors.blue[100],
                                    borderRadius: BorderRadius.only(topRight:Radius.circular(30),bottomLeft: Radius.circular(30)),                                  ),
                                  child: Row(
                                    children: <Widget>[
                                      Text("price : "),
                                      Text(calcprice(widget.prod['price'], widget.prod['sale'])+"LE",
                                        style: TextStyle(fontSize: 20),),
                                      SizedBox(width: 10,),
                                      Text(widget.prod['price'].toString()+" LE",style: TextStyle(
                                          color: Colors.grey,
                                          decoration: TextDecoration.lineThrough,
                                          decorationStyle: TextDecorationStyle.solid ,
                                          decorationThickness: 2,
                                          decorationColor: Colors.red
                                      ),),
                                    ],
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.all(20),
                                  decoration: BoxDecoration(
                                      color: Colors.blue[100],
                                    borderRadius: BorderRadius.only(topRight:Radius.circular(30),bottomLeft: Radius.circular(30)),                                  ),
                                  child: Row(
                                    children: <Widget>[
                                      Container(
                                        child: Row(
                                          children: <Widget>[
                                            GestureDetector(

                                              child: Icon(
                                                  Icons.favorite,
                                                color: colo,
                                              ),
                                              onTap:(){
                                                /*if(colo==Colors.black)
                                                  {
                                                    colo=Colors.red;
                                                    fcategory.setproduct({
                                                      "fav":true,
                                                      "categoryname":widget.prod["categoryname"],
                                                      "lasttime":widget.prod["lasttime"],
                                                      "urlimage":widget.prod["urlimage"],
                                                      "top":widget.prod["top"],
                                                      "shopname":widget.prod["shopname"],
                                                      "sale":widget.prod["sale"],
                                                      "price":widget.prod["price"],
                                                      "name":widget.prod["name"],
                                                    });
                                                  }
                                                else
                                                  {
                                                    colo=Colors.black;
                                                   fcategory.setproduct({
                                                     "fav":false,
                                                     "categoryname":widget.prod["categoryname"],
                                                     "lasttime":widget.prod["lasttime"],
                                                     "urlimage":widget.prod["urlimage"],
                                                     "top":widget.prod["top"],
                                                     "shopname":widget.prod["shopname"],
                                                     "sale":widget.prod["sale"],
                                                     "price":widget.prod["price"],
                                                     "name":widget.prod["name"],
                                                   });
                                                  }
*/
                                                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>showproduct(prod: widget.prod,)));

                                              } ,
                                            ),
                                            SizedBox(width: 20,),
                                            Icon(Icons.share),
                                          ],
                                        ),
                                      ),
                                      SizedBox(width: 20,),
                                      RatingBar(
                                        rating: 3,
                                        icon:Icon(Icons.star,size:40,color: Colors.grey,),
                                        starCount: 5,
                                        spacing: 5.0,
                                        size: 40,
                                        isIndicator: false,
                                        allowHalfRating: true,
                                        onRatingCallback: (double value,ValueNotifier<bool> isIndicator){
                                          print('Number of stars-->  $value');
                                          //change the isIndicator from false  to true ,the       RatingBar cannot support touch event;
                                          isIndicator.value=true;
                                        },
                                        color: Colors.amber,
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
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
