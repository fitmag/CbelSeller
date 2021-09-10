import 'package:cbel/controllers/bottomnavigation.dart';
import 'package:cbel/controllers/home.dart';
import 'package:cbel/controllers/product.dart';
import 'package:cbel/screens/loading.dart';
import 'package:cbel/screens/root.dart';
import 'package:cbel/screens/something.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Get.put(HomeController());
  Get.put(BottomNavigationController());
  Get.put(ProductController());
  runApp(FirebaseInit());
}

class FirebaseInit extends StatefulWidget {
  const FirebaseInit({Key? key}) : super(key: key);

  @override
  _FirebaseInitState createState() => _FirebaseInitState();
}

class _FirebaseInitState extends State<FirebaseInit> {
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      // Initialize FlutterFire:
      future: _initialization,
      builder: (context, snapshot) {
        // Check for errors
        if (snapshot.hasError) {
          return MaterialApp(
            title: "CBEL",
            home: SomethingPage(),
          );
        }

        // Once complete, show your application
        if (snapshot.connectionState == ConnectionState.done) {
          return GetMaterialApp(
            debugShowCheckedModeBanner: false,
            title: "Cbel",
            home: RootPage(),
            
          );
        }

        // Otherwise, show something whilst waiting for initialization to complete
        return MaterialApp(title: "Cbel", home: LoadingPage());
      },
    );
  }
}
