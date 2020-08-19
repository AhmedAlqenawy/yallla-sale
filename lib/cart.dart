
//  Widget endScafold(){
//    return Scaffold(
//      backgroundColor: Colors.black,
//      body: SafeArea(
//          child: SingleChildScrollView(
//            child: Column(
//              crossAxisAlignment: CrossAxisAlignment.start,
//              children: <Widget>[
//                Container(
//                  width: MediaQuery.of(context).size.width,
//                  height: 200,
//                  decoration: BoxDecoration(
//                      image: DecorationImage(
//                        image: AssetImage('assets/images/cart.jpeg'),
//                        fit: BoxFit.fill,
//                      )),
//                ),
//                Container(
//                  child: Column(
//                    crossAxisAlignment: CrossAxisAlignment.stretch,
//                    children: <Widget>[
//                      Text(
//                        'Total Bill',
//                        textAlign: TextAlign.center,
//                        style: TextStyle(
//                            fontStyle: FontStyle.italic,
//                            fontSize: 25,
//                            color: Colors.grey,
//                            fontWeight: FontWeight.w400),
//                      ),
//                      SizedBox(
//                        height: 10,
//                      ),
//                      Text(
//                        totalPrice.toString(),
//                        textAlign: TextAlign.center,
//                        style: TextStyle(
//                            fontStyle: FontStyle.italic,
//                            fontSize: 35,
//                            color: Colors.white,
//                            fontWeight: FontWeight.bold),
//                      ),
//                    ],
//                  ),
//                ),
//                Column(
//                  crossAxisAlignment: CrossAxisAlignment.start,
//                  children: <Widget>[
//                    buldCartItem(15,0),
//                    buldCartItem(12,1),
//                    buldCartItem(66,2),
//                    buldCartItem(79,3),
//                  ],
//                ),
//                Divider(
//                  color: Colors.grey,
//                  height: 10,
//                  thickness: 2,
//                ),
//                GestureDetector(
//                  onTap: () {
//                  },
//                  child: Container(
//                      margin: EdgeInsets.all(15),
//                      padding: EdgeInsets.all(10),
//                      width: 120,
//                      height: 50,
//                      decoration: BoxDecoration(
//                          color: Colors.blue,
//                          borderRadius: BorderRadius.circular(30)),
//                      child: Text(
//                        'Confirm',
//                        textAlign: TextAlign.center,
//                        style: TextStyle(
//                            fontStyle: FontStyle.italic,
//                            fontSize: 25,
//                            color: Colors.black,
//                            fontWeight: FontWeight.bold),
//                      )),
//                ),
//                SizedBox(
//                  height: 20,
//                )
//              ],
//            ),
//          )),
//    );
//  }
//}
//
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'const.dart';
class Product{
  int marketNum;
  var idDocument ;
  var itemName ;
  var itemPrice ;
  var itemImage ;
  var itemId ;
  var selected ;
  double itemLat;
  double itemLong;

  Product({this.marketNum,this.idDocument, this.itemName, this.itemPrice, this.itemImage,
    this.itemId, this.selected,this.itemLat,this.itemLong});

}
class Cart extends StatefulWidget {

  @override
  _CartState createState() => _CartState();
}

class _CartState extends State<Cart> {
  Firestore _firestore = Firestore.instance;
  List<Product> products = [];
  List<Marker> allMarker=[];
  bool isLoading = true;
  GoogleMapController _controller;
  void mapCreate(GoogleMapController controller){
    setState(() {
      _controller=controller;
    });
  }

  Future getData() async {
    for(int i=0;i<4;i++) {
      final items = await _firestore.collection('market$i').getDocuments();
      for (var item in items.documents) {
        bool selected = item.data['selected'];
        if (selected) {
          products.add(
              Product(
                marketNum: i,
                idDocument: item.documentID,
                itemName: item.data['itemName'],
                itemPrice: item.data['itemPrice'],
                itemImage: item.data['itemImage'],
                itemId: item.data['itemId'],
                selected: item.data['selected'],
                itemLat: item.data['location'].latitude,
                itemLong: item.data['location'].longitude,
              ));
        }
        setState(() {
          isLoading = false;
        });
      }
    }
  }
  Widget widget2({Product product,int index}){
    allMarker.add(
        Marker(
      markerId: MarkerId('${product.itemId.toString()}'),
      draggable: false,
      position: LatLng(product.itemLat,product.itemLong),
    ));
    return AnimationConfiguration.staggeredList(
      position: 0,
      duration: const Duration(milliseconds: 2000),
      child: ScaleAnimation(
        child: FadeInAnimation(
     child: Row(
      children: <Widget>[
        Container(
          height: 100,
          margin: EdgeInsets.only(top: 10),
          width: MediaQuery
              .of(context)
              .size
              .width * 0.8,
          decoration: BoxDecoration(
            color: Colors.white10,
            borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(50),
                topRight: Radius.circular(50)),
          ),
          child: Stack(
            children: <Widget>[
              //item image
              Positioned(
                child: Container(
                  height: 100,
                  margin: EdgeInsets.only(right: 70, top: 15, bottom: 15),
                  padding: EdgeInsets.only(top: 15),
                  width: MediaQuery
                      .of(context)
                      .size
                      .width * 0.3,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    image: DecorationImage(
                        image: AssetImage('assets/images/item${product.itemId}.png')
                    ),
                    borderRadius: BorderRadius.only(
                        bottomRight: Radius.circular(50),
                        topRight: Radius.circular(50)),
                  ),
                ),
              ),
              //item name
              Positioned(
                left: 140,
                top: 20,
                child: Text(
                  product.itemName,
                  style: TextStyle(
                      fontStyle: FontStyle.italic,
                      fontSize: 20,
                      color: Colors.white,
                      fontWeight: FontWeight.w700),
                ),
              ),
              //item price
              Positioned(
                left: 160,
                top: 50,
                child: Text(
                  product.itemPrice.toString(),
                  style: TextStyle(
                      fontStyle: FontStyle.italic,
                      fontSize: 30,
                      color: Colors.white,
                      fontWeight: FontWeight.w700
                  ),
                ),
              ),
              //item icon
              Positioned(
                right: 20,
                top: 25,
                child:IconButton(
                  color: Colors.teal,
                  icon: Icon(Icons.map,size: 35,),
                  onPressed: (){
                    print(User.long);
                    showModalBottomSheet<void>(context: context, builder: (BuildContext context){
                      return Container(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height*0.7,
                        child: GoogleMap(
                          onMapCreated: mapCreate,
                          initialCameraPosition: CameraPosition(
                            target: LatLng(product.itemLat,product.itemLong),
                            zoom:10.0,
                          ),
                          markers: Set.from(allMarker),
                          mapType: MapType.normal,
                        ),
                      );
                    });
                  },
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: IconButton(
            onPressed: () async{
              await _firestore.collection('market${product.marketNum}')
                  .document('${product.idDocument}')
                  .updateData(
                  {
                'selected': false,
              });
              setState(() {
                products.removeAt(index);
              });
            },
            icon: Icon(
              Icons.delete,
              color: Colors.teal,
              size: 45,
            ),
          ),
        ),
      ],
    )
    )
    )
    );
  }
  @override
  void initState() {
    getData();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: isLoading ? Center(
         child:Container(
           height: 50,
        width: 50,
        child: CircularProgressIndicator(backgroundColor: Colors.red,)
          )) : SingleChildScrollView(
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
                  colorFilter: ColorFilter.mode(
                      Colors.black.withOpacity(0.6), BlendMode.dstATop),
                  image: AssetImage('assets/images/cart.jpeg'),
                  fit: BoxFit.fill,
                )),
            child: products.length == 0 ?
            Container(
              padding: EdgeInsets.all(50),
              decoration: BoxDecoration(
                  color: Colors.white10,
                  borderRadius: BorderRadius.circular(30)
              ),
              child: Text('No Favorite Item',
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                    fontSize: 35
                ),
              ),
            )
                : ListView.builder(
              itemCount: products.length,
              itemBuilder: (context,index)=>widget2(product: products[index],index: index),
            ),
          ),
        ),
      ),
    );
  }
}