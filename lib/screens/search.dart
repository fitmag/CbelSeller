import 'package:flutter/material.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        alignment: Alignment.center,
        child: Text("Search",style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),),),
    );
  }
}