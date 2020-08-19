import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

class Product{
  var idDocument ;
  var itemName ;
  var itemPrice ;
  var itemImage ;
  var itemId ;
  var selected ;
  double itemLat;
  double itemLong;

  Product({this.idDocument, this.itemName, this.itemPrice, this.itemImage,
    this.itemId, this.selected,this.itemLat,this.itemLong});

}
class Market extends StatefulWidget {
  Market({@required this.market});
  int market;
  @override
  _MarketState createState() => _MarketState();
}

class _MarketState extends State<Market> {
  Firestore _firestore = Firestore.instance;
  List<Widget> listWidgt=[];
  List<Product> products = [];
  bool isLoading = true;
  Widget todayWidget = null;

  GestureDetector buildGestureDetectorIcon(Product product) {
//    return GestureDetector(
//        onTap: () {
//          if (product.selected ) {
//            setState(() {
//              _firestore.collection('market1').document('todayOffer').setData({
//                'selected': false,
//                'itemName': product.itemName,
//                'itemPrice': product.itemPrice,
//                'itemId': product.itemId,
//                'itemImage': product.itemImage,
//              }
//              );
//            });
//            print('mmmmmmmmmmmmmmmmmmmmmmmmm00');
//          }
//          else {
//            setState(() {
//              _firestore.collection('market1').document('todayOffer').setData({
//                'selected':true,
//                'itemName':product.itemName,
//                'itemPrice':product.itemPrice,
//                'itemId':product.itemId,
//                'itemImage':product.itemImage,
//              }
//              );
//            });
//            print('mmmmmmmmmmmmmmmmmmmmmmmmm00');
//          }
//        },
//        child: Container(
//          width: 50,
//          height: 40,
//          child: product.selected
//              ? Icon(
//            Icons.check,
//            color: Colors.white,
//          )
//              : Icon(Icons.add),
//          decoration: BoxDecoration(
//            color: product.selected
//                ? Colors.orange.withOpacity(.9)
//                : Colors.orange.withOpacity(.2),
//            borderRadius: BorderRadius.only(
//              bottomRight: Radius.circular(30),
//              topLeft: Radius.circular(30),
//            ),
//          ),
//        ));
  }

  Future getData() async {
    final items = await _firestore.collection('market${widget.market}').getDocuments();
    for (var item in items.documents) {
      products.add(
          Product(
            idDocument: item.documentID,
            itemName: item.data['itemName'],
            itemPrice: item.data['itemPrice'],
            itemImage: item.data['itemImage'],
            itemId: item.data['itemId'],
            selected: item.data['selected'],
          ));
      setState(() {
        isLoading = false;
      });
    }
  }
  Widget widget1(List products){
    for(var product in products)
      if (product.idDocument == 'todayOffer') {
        setState(() {
          todayWidget = AnimationConfiguration.staggeredList(
              position: 0,
              duration: const Duration(milliseconds: 2000),
              child: ScaleAnimation(
                child: FadeInAnimation(
                  child: Container(
                    height: 210,
                    child: Stack(
                      children: <Widget>[
                        Positioned(
                          top: 5,
                          left: 10,
                          right: 10,
                          child: Container(
                            height: 200,
                            width: 400,
                            decoration: BoxDecoration(
                                color: Colors.white70,
                                borderRadius: BorderRadius.circular(30)),
                            child: Stack(
                              children: <Widget>[
                                //offer image
                                Positioned(
                                  top: 40,
                                  left: 10,
                                  child: Container(
                                    width: 150,
                                    height: 150,
                                    child: Image(
                                      image:
                                      AssetImage('assets/images/offer.png'),
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                ),
                                //Icon
                                Positioned(
                                    right: 0,
                                    bottom: 0,
                                    child: Container(
                                      width: 50,
                                      height: 40,
                                      decoration: BoxDecoration(
                                        color: product.selected
                                            ? Colors.orange.withOpacity(.9)
                                            : Colors.orange.withOpacity(.2),
                                        borderRadius: BorderRadius.only(
                                          bottomRight: Radius.circular(30),
                                          topLeft: Radius.circular(30),
                                        ),
                                      ),
                                      child: IconButton(
                                        icon: product.selected?Icon(Icons.check,size: 30,):Icon(Icons.add,size: 30,),
                                        onPressed:() {
                                          if (product.selected ) {
                                            setState(() {
                                              _firestore.collection('market1').document('todayOffer').setData({
                                                'selected': false,
                                                'itemName': product.itemName,
                                                'itemPrice': product.itemPrice,
                                                'itemId': product.itemId,
                                                'itemImage': product.itemImage,
                                              }
                                              );
                                            });
                                            print('mmmmmmmmmmmmmmmmmmmmmmmmm00');
                                          }
                                          else {
                                            setState(() {
                                              _firestore.collection('market1').document('todayOffer').setData({
                                                'selected':true,
                                                'itemName':product.itemName,
                                                'itemPrice':product.itemPrice,
                                                'itemId':product.itemId,
                                                'itemImage':product.itemImage,
                                              }
                                              );
                                            });
                                            print('mmmmmmmmmmmmmmmmmmmmmmmmm00');
                                          }
                                        },
                                      ),

                                    )
                                ),
                                //image
                                Positioned(
                                  top: 0,
                                  right: 45,
                                  child: Container(
                                    width: 200,
                                    height: 200,
                                    child: Image(
                                      image:
                                      AssetImage('assets/images/item3.png'),
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                ),
                                //item name
                                Positioned(
                                  right: 60,
                                  bottom: 5,
                                  child: Container(
                                    padding: EdgeInsets.all(5),
                                    width: 150,
                                    height: 40,
                                    child: Text(
                                      product.itemName,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          color: Colors.black.withOpacity(0.7),
                                          fontWeight: FontWeight.w700,
                                          fontSize: 20,
                                          fontStyle: FontStyle.italic),
                                    ),
                                  ),
                                ),
                                //price
                                Positioned(
                                  right: -5,
                                  top: -7,
                                  child: Container(
                                    width: 100,
                                    height: 100,
                                    padding: EdgeInsets.only(top: 55),
                                    decoration: BoxDecoration(
                                        image: DecorationImage(
                                            image: AssetImage(
                                                'assets/images/template.png'),
                                            fit: BoxFit.fill)),
                                    child: Text(
                                      product.itemPrice.toString()+'EGP',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          backgroundColor: Colors.white,
                                          color: Colors.black,
                                          fontWeight: FontWeight.w400,
                                          fontSize: 16,
                                          fontStyle: FontStyle.italic),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Positioned(
                          left: 12,
                          top: 7,
                          child: Container(
                            width: 50,
                            height: 40,
                            child: GestureDetector(
                                onTap: () {
                                  Navigator.pop(context);
                                },
                                child: Icon(Icons.arrow_back_ios)),
                            decoration: BoxDecoration(
                              color: Colors.black.withOpacity(.2),
                              borderRadius: BorderRadius.circular(30),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ));
        });
      }
  }

  Widget widget2({Product product,int index}){
    return AnimationConfiguration.staggeredList(
        position: index,
        duration: const Duration(milliseconds: 2000),
        child: ScaleAnimation(
            child: FadeInAnimation(
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.white, borderRadius: BorderRadius.circular(30)),
                  child: Stack(
                    children: <Widget>[
                      //Icon
                      Positioned(
                          right: 0,
                          bottom: 0,
                          child: Container(
                            width: 50,
                            height: 40,
                            decoration: BoxDecoration(
                              color: Colors.redAccent.withOpacity(.2),
                              borderRadius: BorderRadius.only(
                                bottomRight: Radius.circular(30),
                                topLeft: Radius.circular(30),
                              ),
                            ),
                            child: IconButton(
                              icon: product.selected?Icon(Icons.favorite,size: 30,color: Colors.red,):Icon(Icons.favorite_border,size: 20,color: Colors.red),
                              onPressed:() {
                                if (product.selected ) {
                                  setState(() {
                                    product.selected=false;
                                    _firestore.collection('market${widget.market}').document('${product.idDocument}').updateData({
                                      'selected': false,
                                    }
                                    );
                                  });
                                }
                                else {
                                  setState(() {
                                    product.selected=true;
                                    _firestore.collection('market${widget.market}').document('${product.idDocument}').updateData({
                                      'selected':true,
                                    }
                                    );
                                  });
                                }
                              },
                            ),
                          )
                      ),
                      //image
                      Positioned(
                        top: 40,
                        left: 10,
                        child: Container(
                          width: 180,
                          height: 150,
                          child: Image(
                            image: AssetImage('assets/images/item${product.itemId}.png'),
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                      //item name
                      Positioned(
                        left: 1,
                        bottom: 0,
                        child: Container(
                          padding: EdgeInsets.all(5),
                          width: 150,
                          height: 40,
                          child: Text(
                            product.itemName,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Colors.black.withOpacity(0.7),
                                fontWeight: FontWeight.w700,
                                fontSize: 20,
                                fontStyle: FontStyle.italic),
                          ),
                        ),
                      ),
                      //price
                      Positioned(
                        left: 5,
                        top: 5,
                        child: Container(
                          width: 60,
                          height: 60,
                          padding: EdgeInsets.only(top: 15),
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage('assets/images/star.png'),
                                  fit: BoxFit.fill)),
                          child: Text(
                            '\$${product.itemPrice}',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                backgroundColor: Color(0xFFFFCA45),
                                color: Colors.black,
                                fontWeight: FontWeight.w400,
                                fontSize: 22,
                                fontStyle: FontStyle.italic),
                          ),
                        ),
                      ),
                    ],
                  ),
                ))));
  }
  @override
  void initState() {
     getData();
//    todayWidget = widget.widget;
//    listWidgt = widget.list;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: AnimationLimiter(
          child: Container(
              width: MediaQuery
                  .of(context)
                  .size
                  .width,
              height: MediaQuery
                  .of(context)
                  .size
                  .height,
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/images/marketback.jpg'),
                    fit: BoxFit.fill
                ),
              ),
              child: Column(
                children: <Widget>[
//                  todayWidget==null? Container(
//                      height: 220,
//                      child: CircularProgressIndicator()
//                  ) : todayWidget,
                  isLoading ?
                  Padding(
                    padding: const EdgeInsets.only(top:300),
                    child: Center(
                        child:CircularProgressIndicator(
                          backgroundColor: Colors.red,
                          strokeWidth: 15,
                        ),
                    ),
                  ) :
                  Expanded(
                    child: GridView.builder(
                      gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2,mainAxisSpacing: 20,crossAxisSpacing: 10,childAspectRatio: 0.85 ),
                      itemCount: products.length,
                      itemBuilder: (context,index)=>widget2(product: products[index],index: index),
                    ),
                  )

                ],
              )
          ),
        ),
      ),
    );
  }
}