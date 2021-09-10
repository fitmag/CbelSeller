import 'package:cbel/screens/something.dart';
import 'package:cbel/widget/ads.dart';
import 'package:cbel/widget/card.dart';
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
      child: FutureBuilder<QuerySnapshot>(
          future: product.get()!,
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError) {
              print("something");
              Get.to(SomethingPage());
            }
            if (snapshot.hasData &&
                snapshot.connectionState == ConnectionState.waiting) {
              print("watiting");
              return Container(
                child: CircularProgressIndicator(),
              );
            }
            if (snapshot.connectionState == ConnectionState.done &&
                snapshot.hasData) {
              return SafeArea(
                child: CustomScrollView(
                  slivers: [
                    CSliverAppBar(),
                    SliverToBoxAdapter(child: CbelAds()),
                    SectionTitle(text: "Categorie"),
                    SliverToBoxAdapter(child: CategorieSection()),
                    SectionTitle(text: "Nouveaux arrivage"),
                    SliverGrid.count(
                      childAspectRatio: 0.65,
                      crossAxisCount: 2,
                      mainAxisSpacing: 8,
                      crossAxisSpacing: 8,
                      children: snapshot.data!.docs.map((DocumentSnapshot doc) {
                        Map<String, dynamic> docData = doc.data()!;
                        return ProductCard(docData: docData, id: doc.id);
                      }).toList(),
                    )
                  ],
                ),
              );
            }
            print("return the sliver");
            return Container(alignment: Alignment.center, child: CircularProgressIndicator());
          }),
    );
  }
}
