import 'package:flutter/material.dart';

class AcoountPage extends StatelessWidget {
  const AcoountPage({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        alignment: Alignment.center,
        child: Text("Account",style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),),),
    );
  }
}