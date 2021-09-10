
import 'package:flutter/material.dart';

class SomethingPage extends StatelessWidget {
  const SomethingPage({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Cbel"),
      ),
      body: SafeArea(
        child: SizedBox(
          // TODO: image with text for this page
          width: double.infinity,
          child: Text("Something is wrong please restart the app"),
        ),
        ),
    );
  }
}