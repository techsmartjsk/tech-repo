import 'package:flutter/material.dart';


void main() => runApp(
  MaterialApp(
    home: CartApp(),
  )
);
class CartApp extends StatefulWidget {
  @override
  _CartAppState createState() => _CartAppState();
}

class _CartAppState extends State<CartApp> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text('This is the cart page'),
    );
  }
}
