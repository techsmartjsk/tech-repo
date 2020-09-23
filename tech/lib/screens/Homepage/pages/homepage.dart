import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../bloc.navigation_bloc/navigation_bloc.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';

class HomePage extends StatefulWidget with NavigationStates {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Firestore _firestore = Firestore.instance;

  Future<void> scanBarcodeNormal() async {
    String _scanBarcode;
    String barcodeScanRes;
    try {
      String name, image;
      int price;
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          "#ff6666", null , true, ScanMode.BARCODE);
      var getProduct = await _firestore.collection('products').document(barcodeScanRes);
      getProduct.get().then((value) => {
        name = value.data['name'],
        image = value.data['image'],
        price = value.data['price'],
        print(name),
        print(price),
        print(image),
        AddToCart(name, image, price, barcodeScanRes)
      });
    } catch(e){
      print(e);
    }
    if (!mounted) return;
    setState(() {
      _scanBarcode = barcodeScanRes;
    });
  }

  void AddToCart(String name, String image,int price, String cid) async{
    print(name);
    print(image);
    print(cid);
    print(price);
    Firestore __firestore = Firestore.instance;
    final _auth = FirebaseAuth.instance;

    final user = await _auth.currentUser();
    String id = user.uid;
    __firestore.collection('users').document(id).collection('cart_items').document(cid)
        .setData({
      "name":name,
      "image":image,
      "price":price
    });
  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
        appBar: AppBar(title: const Text('Barcode scan')),
        body: Builder(builder: (BuildContext context) {
          return Container(
              alignment: Alignment.center,
              child: Flex(
                  direction: Axis.vertical,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    RaisedButton(
                        onPressed: () => scanBarcodeNormal(),
                        child: Text("Start barcode scan")),
                  ]));
        }));
  }
}

