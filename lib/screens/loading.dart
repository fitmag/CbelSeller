
import 'package:flutter/material.dart';

class LoadingPage extends StatelessWidget {
  const LoadingPage({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SizedBox(
          height: double.infinity,
          child: Center(
            child: CircularProgressIndicator(semanticsLabel: 'Loading',),
          ) ,)
        ),
    );
  }
}