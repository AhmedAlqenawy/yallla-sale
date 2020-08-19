import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';


class Firecategory {
  bool auth() {
    return FirebaseAuth.instance.currentUser() != null ? true : false;
  }

  Future<void> CreateOrAddcategory(data) async{
    if(auth()){
      Firestore.instance.collection('category').add(data);
    }
  }
  getcategory() async{
    return await  Firestore.instance.collection('category').getDocuments();
  }


}
class Fireproduct {
  bool auth() {
    return FirebaseAuth.instance.currentUser() != null ? true : false;
  }


  Future<void> CreateOrAddSroduct(data) async{
    if(auth()){
      Firestore.instance.collection('shop').add(data);
    }
  }

  getProduct(var catname) async{
    return await  Firestore.instance
        .collection('product')
        .where("categoryname",isEqualTo: catname)
        .getDocuments();
  }
  getProductshop(var shop) async{
    return await  Firestore.instance
        .collection('product')
        .where("shopname",isEqualTo: shop)
        .getDocuments();
  }
  gettopcatProduct(var catname) async{
    return await  Firestore.instance
        .collection('product')
        .where("categoryname",isEqualTo:catname)
        .where("top",isEqualTo: true)
        .getDocuments();
  }


  gettopProduct() async{
    return await  Firestore.instance
        .collection('product')
        .where("top",isEqualTo: true)
        .getDocuments();
  }
  getfavProduct() async{
    return await  Firestore.instance
        .collection('product')
        .where("fav",isEqualTo: true)
        .getDocuments();
  }
setproduct(data) async {
  await Firestore.instance.collection("product").document("0yHOxO7hpuaLKGHrQH4c").setData(data);
}

  getProduct1() async{
    return await  Firestore.instance
        .collection('product')
        .getDocuments();
  }
  getshop() async{
    return await  Firestore.instance
        .collection('shopes')
        .getDocuments();
  }

}


class FireImage {
  bool auth() {
    return FirebaseAuth.instance.currentUser() != null ? true : false;
  }


  Future<void> CreateOrAddSroduct(data) async{
    if(auth()){
      Firestore.instance.collection('productImge').add(data);
    }
  }

  getProduct() async{
    return await  Firestore.instance.collection('productImge').getDocuments();
  }
}
