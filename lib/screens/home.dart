import 'package:cbel/constant/colors.dart';
import 'package:cbel/screens/something.dart';
import 'package:cbel/widget/ads.dart';
import 'package:cbel/widget/app_bar.dart';
import 'package:cbel/widget/categorie.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  dynamic messageStream = FirebaseFirestore.instance
      .collection("Message")
      .where("isRead", isEqualTo: false)
      .snapshots();
  dynamic notificationStream = FirebaseFirestore.instance
      .collection("Notification")
      .where("isRead", isEqualTo: false)
      .snapshots();
  dynamic ads = FirebaseFirestore.instance
      .collection("Ads")
      .where("isActivated", isEqualTo: true)
      .snapshots();

  dynamic categorie =
      FirebaseFirestore.instance.collection("Categorie").snapshots();

  CollectionReference product =
      FirebaseFirestore.instance.collection("Products");

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: ListView.builder(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        itemBuilder: (context,i){
          return Column(
            children: [
              CustomAppBar(
            messageStream: messageStream,
            notificationStream: notificationStream),
                CbelAds(),
                SizedBox(
          height: 16,
                ),
                Text("Categorie",
            style:
                GoogleFonts.poppins(fontSize: 18, color: CustomColor.cBlack)),
                SizedBox(
          height: 8.0,
                ),
                CategorieSection(),
                SizedBox(
          height: 8.0,
                ),
                Text("Nouvelles arrivage",
            style:
                GoogleFonts.poppins(fontSize: 18, color: CustomColor.cBlack)),
                FutureBuilder<QuerySnapshot>(
            future: product.get(),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasError) {
                Get.to(SomethingPage());
              }
              if (snapshot.hasData &&
                  snapshot.connectionState == ConnectionState.waiting) {
                return Container(
                  alignment: Alignment.center,
                  child: CircularProgressIndicator(),
                );
              }
              
              return Expanded(
                child: GridView.count(
                    crossAxisCount: 2,
                    mainAxisSpacing: 16,
                    crossAxisSpacing: 16,
                    children: snapshot.data!.docs.map((DocumentSnapshot doc) {
                      Map<String, dynamic> docData = doc.data()!;
                      print(docData["image"]);
                      return Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16)
                        ),
                        child: Column(
                          children: [
                            SizedBox(
                              
                              width: (MediaQuery.of(context).size.width - 48) /2,
                              height: (MediaQuery.of(context).size.width - 48) /2,
                              child: Image.network(docData["image"],fit: BoxFit.fill,))],
                        ),
                      );
                    }).toList()),
              );
            })
            ],
          );}
      ),
    ));
  }
}
