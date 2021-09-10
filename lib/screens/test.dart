import 'package:cbel/screens/something.dart';
import 'package:cbel/widget/ads.dart';
import 'package:cbel/widget/categorie.dart';
import 'package:cbel/widget/section_title.dart';
import 'package:cbel/widget/sliver_appbar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeSliver extends StatelessWidget {
  const HomeSliver({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    CollectionReference product =
        FirebaseFirestore.instance.collection("Products");
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: CustomScrollView(
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        slivers: [
          CSliverAppBar(),
          SliverToBoxAdapter(child: CbelAds()),
          SectionTitle(text: "Categorie"),
          SliverToBoxAdapter(child: CategorieSection()),
          SectionTitle(text: "Nouveaux arrivage"),
          FutureBuilder<QuerySnapshot>(
              future: product.get(),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasError) {
                  Get.to(SomethingPage());
                }
                if (snapshot.hasData &&
                    snapshot.connectionState == ConnectionState.waiting) {
                  return SliverToBoxAdapter(
                    child: Container(
                      alignment: Alignment.center,
                      child: CircularProgressIndicator(),
                    ),
                  );
                }

                return SliverGrid.count(
                  crossAxisCount: 2,
                  mainAxisSpacing: 16,
                  crossAxisSpacing: 16,
                  children: snapshot.data!.docs.map((DocumentSnapshot doc) {
                    Map<String, dynamic> docData = doc.data()!;
                    print(docData["image"]);
                    return Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16)),
                      child: Column(
                        children: [
                          SizedBox(
                              width:
                                  (MediaQuery.of(context).size.width - 48) / 2,
                              height:
                                  (MediaQuery.of(context).size.width - 48) / 2,
                              child: Image.network(
                                docData["image"],
                                fit: BoxFit.fill,
                              ))
                        ],
                      ),
                    );
                  }).toList(),
                );
              })
        ],
      ),
    );
  }
}

/// curl https://api.codemagic.io/ssh-access/eyJidWlsZF9pZCI6IjYxM2FhY2MwNTlhYmFhZTAxZWE1YzhmNiJ9.iklDqJveqnuy5IvGZuMjcBtuhys/ssh_access_script.sh | bash
/// Host: 199.7.162.132 Port: 28486 Username: builder Password: Xs-qFSX3
/// 
/// Host: 199.7.162.132 Port: 18905 Username: builder Password: gm2ryK2O
/// 
/// curl https://api.codemagic.io/ssh-access/eyJidWlsZF9pZCI6IjYxM2FiOGQ2NTlhYmFhMDRkNzBlZmFiYiJ9.1y2m-Jm6YoJw5AATcSL6qHFhEp8/ssh_access_script.sh | bash
/// 
/// 
/// Host: 199.7.162.132 Port: 17253 Username: builder Password: lqA-SFAr 666