import 'package:flutter/material.dart';

class CategoriePage extends StatelessWidget {
  const CategoriePage({Key? key, @required this.categorieId}) : super(key: key);
  final categorieId ;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              Text("Categorie page"),
              Text(categorieId)
            ],
          ),
        ),
      ),
    );
  }
}
