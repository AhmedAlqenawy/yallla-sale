import 'package:city_store/HHome.dart';
import 'package:city_store/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'const.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';



class PersonalData extends StatefulWidget {
  @override
  _PersonalDataState createState() => _PersonalDataState();
}

class _PersonalDataState extends State<PersonalData> {
  final _formKey = GlobalKey<FormState>();
  File image;
  final _picker = ImagePicker();
  List<Marker> allMarker=[];
  void getStaticMap(){
  }

  @override
  void initState() {
    super.initState();
    Geolocator().getCurrentPosition(desiredAccuracy: LocationAccuracy.high).then((location){
      setState(() {
        User.long=location.longitude;
        User.lat=location.latitude;
      });
    });
    allMarker.add(Marker(
      markerId: MarkerId("My Location"),
      draggable: true,
      onDragEnd: (loc){
        setState(() {
          User.lat=loc.latitude;
          User.long=loc.longitude;
        });
      },
      position: LatLng(25.561667,29.261021),
    ));
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: SingleChildScrollView(
         child: Container(
             padding: EdgeInsets.all(15),
             width: MediaQuery.of(context).size.width,
             height: MediaQuery.of(context).size.height,
             child: Form(
               key: _formKey,
               child: Column(
                 children: <Widget>[
                   //user image
                   Container(
                     height: 250,
                     padding: EdgeInsets.only(top: 20),
                     child: Column(
                       children: <Widget>[
                         CircleAvatar(
                           radius: 80,
                           backgroundImage: User.UserImage == null
                               ? AssetImage('assets/images/person.jpg')
                               : NetworkImage(User.UserImage),
                         ),
                         RaisedButton(
                           child: Icon(
                             Icons.add_a_photo,
                             size: 35,
                             color: Colors.teal,
                           ),
                           onPressed: () async {
                             showModalBottomSheet<void>(
                                 context: context,
                                 builder: (BuildContext context) {
                                   return Container(
                                     height: 150,
                                     decoration: BoxDecoration(
                                         color: Colors.white,
                                         borderRadius: BorderRadius.only(
                                             topLeft: Radius.circular(50),
                                             topRight: Radius.circular(50))),
                                     child: Row(
                                       children: <Widget>[
                                         Expanded(
                                           child: Column(
                                             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                             crossAxisAlignment: CrossAxisAlignment.center,
                                             children: <Widget>[
                                               IconButton(
                                                 onPressed: () {
                                                   setState(() async {
                                                     final pickedFile =
                                                     await _picker.getImage(
                                                         source: ImageSource
                                                             .camera);
                                                     image = File(pickedFile.path);
                                                     FirebaseStorage fire =
                                                         FirebaseStorage.instance;
                                                     StorageReference root =
                                                     fire.ref();
                                                     StorageReference picFolder =
                                                     root
                                                         .child('picture')
                                                         .child('image1');
                                                     picFolder
                                                         .putFile(image)
                                                         .onComplete
                                                         .then((storeTask) async {
                                                       String link =
                                                       await storeTask.ref
                                                           .getDownloadURL();
                                                       setState(() {
                                                         User.UserImage = link;
                                                       });
                                                     });
                                                     Navigator.pop(context);
                                                   });
                                                 },
                                                 icon: Icon(Icons.camera_enhance,size: 50,color: Colors.teal,),
                                               ),
                                               Padding(
                                                 padding: const EdgeInsets.only(left:30.0),
                                                 child: Text(
                                                   'Camera',
                                                   textAlign: TextAlign.center,
                                                   style: TextStyle(
                                                       fontSize: 20
                                                   ),
                                                 ),
                                               )
                                             ],
                                           ),
                                         ),
                                         Expanded(
                                           child: Column(
                                             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                             crossAxisAlignment: CrossAxisAlignment.center,
                                             children: <Widget>[
                                               IconButton(
                                                 icon: Icon(Icons.storage,size: 50,color: Colors.teal,),
                                                 onPressed: () {
                                                   setState(() async {
                                                     final pickedFile =
                                                     await _picker.getImage(
                                                         source: ImageSource
                                                             .gallery);
                                                     image = File(pickedFile.path);
                                                     FirebaseStorage fire =
                                                         FirebaseStorage.instance;
                                                     StorageReference root =
                                                     fire.ref();
                                                     StorageReference picFolder =
                                                     root
                                                         .child('picture')
                                                         .child('image1');
                                                     picFolder
                                                         .putFile(image)
                                                         .onComplete
                                                         .then((storeTask) async {
                                                       String link =
                                                       await storeTask.ref
                                                           .getDownloadURL();
                                                       setState(() {
                                                         User.UserImage = link;
                                                       });
                                                     });
                                                     Navigator.pop(context);
                                                   });
                                                 },
                                               ),
                                               Padding(
                                                 padding: const EdgeInsets.only(left:30.0),
                                                 child: Text(
                                                   'Gallery',
                                                   textAlign: TextAlign.center,
                                                   style: TextStyle(
                                                       fontSize: 20
                                                   ),
                                                 ),
                                               )
                                             ],
                                           ),
                                         )
                                       ],
                                     ),
                                   );
                                 });
                           },
                         )
                       ],
                     ),
                   ),
                   //user Name
                   TextFormField(
                     onSaved: (value) {
                       setState(() {
                         User.UserName = value;
                       });
                     },
                     cursorColor: Colors.white,
                     style: TextStyle(
                         color: Colors.white, fontWeight: FontWeight.bold),
                     decoration: InputDecoration(
                       icon: Icon(Icons.person_add,color: Colors.white,size: 30,),
                       labelText: 'User Name',

                       labelStyle: TextStyle(color: Colors.white),
                       enabledBorder: OutlineInputBorder(
                           borderRadius: BorderRadius.circular(15),
                           borderSide: BorderSide(
                             color: Colors.white,
                             width: 2,
                           )),
                       focusedBorder: OutlineInputBorder(
                           borderRadius: BorderRadius.circular(15),
                           borderSide: BorderSide(
                             color: Colors.white,
                             width: 2,
                           )),
                     ),
                     validator: (String value) {
                       if (value.trim().isEmpty)
                         return 'this Value is Required';
                       else if (value.trim().length > 20)
                         return 'this Name is too Long';
                     },
                     textAlign: TextAlign.center,
                   ),
                   SizedBox(
                     height: 15,
                   ),
                   //user Phone
                   TextFormField(
                     keyboardType: TextInputType.phone,
                     onSaved: (value) {
                       setState(() {
                         User.UserPhone = int.parse(value);
                       });
                     },
                     validator: (String value) {
                       if (value.trim().length != 11) return 'invalid Number';
                     },
                     cursorColor: Colors.white,
                     style: TextStyle(
                         color: Colors.white, fontWeight: FontWeight.bold),
                     decoration: InputDecoration(
                       icon: Icon(Icons.phone,color: Colors.white,size: 30,),
                       labelText: 'Phone Namber',
                       labelStyle: TextStyle(color: Colors.white),
                       enabledBorder: OutlineInputBorder(
                           borderRadius: BorderRadius.circular(15),
                           borderSide: BorderSide(
                             color: Colors.white,
                             width: 2,
                           )),
                       focusedBorder: OutlineInputBorder(
                           borderRadius: BorderRadius.circular(15),
                           borderSide: BorderSide(
                             color: Colors.white,
                             width: 2,
                           )),
                     ),
                     textAlign: TextAlign.center,
                   ),
                   SizedBox(
                     height: 15,
                   ),
                   //user city
                   TextFormField(
                     readOnly: true,
                     validator: (String value) {
                       if (value.trim()=='No city Found')
                         return 'this Value is Required';
                     },
                     cursorColor: Colors.white,
                     style: TextStyle(
                         color: Colors.white, fontWeight: FontWeight.bold),
                     decoration: InputDecoration(
                       hintText: User.city==null?'No city Found':'${User.city}',
                       hintStyle: TextStyle(color: Colors.white),
                       suffixIcon:Container(
                         width: 50,
                         height: 60,
                         decoration: BoxDecoration(
                             color: Colors.tealAccent[100],
                             borderRadius: BorderRadius.circular(10)
                         ),
                         child:IconButton(
                           icon: Icon(Icons.add_location,size: 35,color: Colors.teal,),
                           onPressed: (){
                             showModalBottomSheet<void>(context: context, builder: (BuildContext context){
                               return Container(
                                 width: MediaQuery.of(context).size.width,
                                 height: MediaQuery.of(context).size.height*0.6,
                                 child: Stack(
                                     children: [
                                       GoogleMap(
                                         initialCameraPosition: CameraPosition(
                                           target: LatLng(User.lat,User.long),
                                           zoom:15.0,
                                         ),
                                         markers: Set.from(allMarker),
                                       ),
                                       Positioned(
                                         bottom: 5,
                                         left: MediaQuery.of(context).size.width*0.43,
                                         child: IconButton(
                                           icon: Icon(Icons.check_circle,color: Colors.green,size: 40,) ,
                                           onPressed: (){
                                             Navigator.pop(context);
                                             setState(() {
                                               User.city="Assuite";
                                             });
                                             print(User.city);
                                             print("****************asd");
                                             print(User.lat);
                                             print(User.long);

                                           },
                                         ),
                                       )
                                     ]
                                 ),
                               );
                             });
                           },
                         ),
                       ) ,
                       focusedBorder: OutlineInputBorder(
                           borderRadius: BorderRadius.circular(15),
                           borderSide: BorderSide(
                             color: Colors.white,
                             width: 2,
                           )),
                       icon: Icon(Icons.location_city,color: Colors.white,size: 30,),
                       enabledBorder: OutlineInputBorder(
                           borderRadius: BorderRadius.circular(15),
                           borderSide: BorderSide(
                             color: Colors.white,
                             width: 2,
                           )),
                     ),
                     textAlign: TextAlign.center,
                   ),
                   RaisedButton(
                     onPressed: () {
                       if(!_formKey.currentState.validate())
                         return;
                       _formKey.currentState.save();
                       Navigator.push(context, MaterialPageRoute(builder: (context)=>HHome()));
                     },
                     child: Icon(
                       Icons.save,
                       size: 35,
                       color: Colors.teal,
                     ),
                   )
                 ],
               ),
             ))
        ),
      ),
    );
  }

}

