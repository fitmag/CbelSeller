
import 'package:cbel/constant/colors.dart';
import 'package:cbel/screens/categorie.dart';
import 'package:cbel/screens/something.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class CategorieSection extends StatelessWidget {
  const CategorieSection({Key? key,}) : super(key: key);



  @override
  Widget build(BuildContext context) {
    dynamic categorie =
      FirebaseFirestore.instance.collection("Categorie").snapshots();
    return StreamBuilder(
          stream: categorie,
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError) {
              Get.to(SomethingPage());
            }

            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }

            return SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                crossAxisAlignment : CrossAxisAlignment.start,
                children: snapshot.data!.docs.map((DocumentSnapshot document) {
                  Map<String, dynamic> data = document.data()!;
                  return Padding(
                    padding: const EdgeInsets.only(right: 16.0),
                    child: GestureDetector(
                      onTap: () => {
                        Get.to(CategoriePage(categorieId: document.id,))
                      },
                      child: Column(
                        children: [
                            Stack(
                              children: [Container(
                                width: 48.0,
                                height:48.0,
                                decoration: BoxDecoration(
                                  color: CustomColor.primary,
                                  shape: BoxShape.circle),
                                
                              ),
                              Positioned(
                                top: 12,
                                right: 12,
                                child: Container(
                                    width: 24,
                                    height: 24,
                                    child: Center(
                                      child: Image.network(
                                        data["image"],
                                        color: Colors.white,),
                                    ),
                                  ),
                              )],
                            ),
                            SizedBox(height: 8,),
                            Text(
                              data["name"],
                              style: GoogleFonts.poppins(color: CustomColor.cBlack,fontSize: 14),
                              )
                        ],
                      ),
                    ),
                  );
                }).toList(),
              ),
            );
          });
  }
}
