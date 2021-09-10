import 'package:cbel/screens/product.dart';
import 'package:cbel/screens/seller.dart';
import 'package:cbel/screens/something.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CbelAds extends StatelessWidget {
  const CbelAds({Key? key, }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    dynamic ads = FirebaseFirestore.instance
      .collection("Ads")
      .where("isActivated", isEqualTo: true)
      .snapshots();
    return StreamBuilder(
        stream: ads,
        builder:
            (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            Get.to(SomethingPage());
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            double width = MediaQuery.of(context).size.width;
            return SizedBox(
                width: double.infinity,
                height: (width * 9) / 16,
                child: Center(child: CircularProgressIndicator()));
          }
          return SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children:
                  snapshot.data!.docs.map((DocumentSnapshot document) {
                Map<String, dynamic> data = document.data()!;
                double width = MediaQuery.of(context).size.width - 48;
                return SizedBox(
                  width: width,
                  height: (width * 9) / 16,
                  child: GestureDetector(
                    onTap: () => {
                      if(data["type"] == "product"){
                        Get.to(ProductPage(productID: data["uid"]))
                      }else if (data["type"] == "seller"){
                        Get.to(SellerPage(sellerID: data["uid"]))
                      }else if (data["type"] == "url"){
                        // TODO: add depandancey and go to the url
                      }
                      },
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(18),
                      child: Image.network(
                        data["image"],
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
          );
        });
  }
}
