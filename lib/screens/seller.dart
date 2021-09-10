import 'package:flutter/material.dart';

class SellerPage extends StatelessWidget {
  const SellerPage({Key? key , @required this.sellerID}) : super(key: key);
  final sellerID;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              Text("Seller page"),
              SizedBox(
                height: 18,
              ),
              Text(sellerID)
            ],
          ),
        ),
      ),
    );
  }
}
