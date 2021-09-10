
import 'package:cbel/constant/colors.dart';
import 'package:cbel/controllers/text.dart';
import 'package:cbel/screens/product.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({
    Key? key,
    required this.docData,
    required this.id
  }) : super(key: key);

  final Map<String, dynamic> docData;
  final id;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Get.to(() => ProductPage(productID: id)),
      child: Card(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(8))),
        elevation: 8,
        child: Flex(
          direction: Axis.vertical,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 4,
                child: ClipRRect(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(8),
                        topRight: Radius.circular(8)),
                    child: Image.network(
                      docData["image"],
                      fit: BoxFit.cover,
                      width: (MediaQuery.of(context).size.width - 40) / 2,
                      height: (MediaQuery.of(context).size.width - 40) / 2,
                    ))),
            Expanded(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      TextController.price(docData["price"]),
                      style: GoogleFonts.poppins(
                          fontSize: 16,
                          color: CustomColor.cBlack,
                          fontWeight: FontWeight.bold),
                    ),
                    SmoothStarRating(
                      borderColor: CustomColor.primary,
                      color: CustomColor.primary,
                      rating: docData["stars"],
                      starCount: 5,
                      size: 16,
                      isReadOnly: true,
                    ),
                    Text(docData["title"],
                        style: GoogleFonts.poppins(
                          color: CustomColor.cBlack,
                          fontSize: 16,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,)
                  ],
                ),
              ),
            ),
            Expanded(
              flex : 1 ,
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  primary: CustomColor.primary,
                  textStyle : GoogleFonts.poppins(fontSize: 16,fontWeight : FontWeight.w600),
                  shape : RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(bottomLeft: Radius.circular(8),bottomRight: Radius.circular(8))),
                  fixedSize: Size((MediaQuery.of(context).size.width - 40) / 2, 36)
                  
                ),
                // TODO : add to basket function 
                onPressed: (){}, 
                icon: Icon(Icons.add,
                          color: Colors.white,), 
                label: Text("Panier")),
            )
          ],
        ),
      ),
    );
  }
}
