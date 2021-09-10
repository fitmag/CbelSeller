
import 'package:cbel/constant/colors.dart';
import 'package:cbel/screens/seller.dart';
import 'package:cbel/screens/something.dart';
import 'package:cbel/widget/text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SellerSection extends StatelessWidget {
  const SellerSection({
    Key? key,
    required this.data,
  }) : super(key: key);

  final Map<String, dynamic> data;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: FirebaseFirestore.instance
            .collection("Seller")
            .doc(data["sellerID"])
            .get(),
        builder: (BuildContext context,
            AsyncSnapshot<DocumentSnapshot> snapshot) {
          if (snapshot.hasError ||
              (snapshot.hasData &&
                  !snapshot.data!.exists)) {
            Get.to(() => SomethingPage());
          }
          if (snapshot.connectionState ==
              ConnectionState.done) {
            Map<String, dynamic> seller =
                snapshot.data!.data();
            return Row(
              mainAxisAlignment:
                  MainAxisAlignment.spaceBetween,
              crossAxisAlignment:
                  CrossAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () => Get.to(SellerPage(
                      sellerID: snapshot.data!.id)),
                  child: Row(
                    children: [
                      Container(
                        width: 48,
                        height: 48,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: CustomColor.primary,
                        ),
                        child: seller["storeImage"] ==
                                null
                            ? Center(
                                child: Text(
                                  seller["storeName"]
                                      [0],
                                  style: TextStyle(
                                      fontWeight:
                                          FontWeight
                                              .bold,
                                      fontSize: 24,
                                      color:
                                          Colors.white),
                                ),
                              )
                            : ClipRRect(
                                borderRadius:
                                    BorderRadius
                                        .circular(48),
                                child: Image.network(
                                  seller["storeImage"],
                                  fit: BoxFit.cover,
                                  width: 48,
                                  height: 48,
                                ),
                              ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 16),
                        child: Column(
                          crossAxisAlignment:
                              CrossAxisAlignment.start,
                          children: [
                            CustomeText(
                              text: seller["storeName"],
                              size: 18,
                              weight: FontWeight.w500,
                            ),
                            CustomeText(
                                text:
                                    "${seller["articleCount"]} Articles",
                                size: 14)
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                TextButton(
                    // TODO : add S'abonner methode
                    onPressed: () => {},
                    child: CustomeText(
                        text: "S'abonner",
                        size: 18,
                        color: CustomColor.primary))
              ],
            );
          }
          return Center(
              child: CircularProgressIndicator());
        });
  }
}
