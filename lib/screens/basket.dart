import 'package:flutter/material.dart';

class BasketPage extends StatelessWidget {
  const BasketPage({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        alignment: Alignment.center,
        child: Text("Basket",style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),),),
    );
  }
}