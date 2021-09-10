import 'package:carousel_slider/carousel_controller.dart';
import 'package:cbel/constant/colors.dart';
import 'package:cbel/controllers/product.dart';
import 'package:cbel/controllers/text.dart';
import 'package:cbel/widget/seller_section.dart';
import 'package:cbel/widget/ship.dart';
import 'package:cbel/widget/text.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

class ProductDetails extends StatelessWidget {
  const ProductDetails({
    Key? key,
    required this.data,
    required this.productController,
    required this.carouselController,
  }) : super(key: key);

  final Map<String, dynamic> data;
  final ProductController productController;
  final CarouselController carouselController;

  @override
  Widget build(BuildContext context) {
    if (data["hasPrices"]) {
      productController.productPrice.value = int.parse(TextController.getList(
          data["prices"])[productController.priceIndex.value]);
    } else {
      productController.productPrice.value = data["price"];
    }
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 16),
          CustomeText(
            text: data["title"],
            size: 18,
            weight: FontWeight.w600,
            isOverflow: false,
          ),
          Obx(() => CustomeText(
                text:
                    TextController.price(productController.productPrice.value),
                size: 24,
                color: CustomColor.primary,
                weight: FontWeight.w600,
              )),
          CustomeText(
            text: data["decription"],
            isOverflow: false,
          ),
          SizedBox(height: 8,),
          Divider(
            thickness: 1,
          ),
          SizedBox(height: 8,),
          SellerSection(data: data),
          SizedBox(height: 8, ),
          Divider(
            thickness: 1,
          ),
          
          data["hasColor"] == true
              ? Container(
                  width: double.infinity,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 8,
                      ),
                      CustomeText(
                        text: "Les couleur diponible",
                        size: 18,
                        weight: FontWeight.w500,
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                            children: List.generate(
                                TextController.getList(data["colors"]).length,
                                (index) {
                          List<String> list =
                              TextController.getList(data["colors"]);
                          return Padding(
                            padding: const EdgeInsets.only(right: 16),
                            child: ColorShip(
                              text: list[index],
                              index: index,
                              controller: carouselController,
                            ),
                          );
                        })),
                      )
                    ],
                  ),
                )
              : Container(),
          data["hasSize"] == true
              ? Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 8),
                      Row(
                        children: [
                          CustomeText(
                            text: "Les ${data["sizeType"]} disponible",
                            size: 18,
                            weight: FontWeight.w500,
                          ),
                          data["hasSizeInfo"] == true
                              ? IconButton(
                                  onPressed: () => Get.snackbar(
                                        "Information sure la taille",
                                        data["sizeInfo"],
                                        backgroundColor: CustomColor.cBlack,
                                        colorText: Colors.white,
                                        icon: Icon(
                                          Icons.info,
                                          size: 24,
                                          color: Colors.white,
                                        ),
                                        isDismissible: true,
                                        borderRadius: 16,
                                      ),
                                  icon: Icon(Icons.info,
                                      color: CustomColor.primary))
                              : Container(),
                        ],
                      ),
                      data["hasPrices"] == false
                          ? SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                children: List.generate(
                                    TextController.getList(data["sizes"])
                                        .length, (index) {
                                  List sizes =
                                      TextController.getList(data["sizes"]);
                                  return SizeShip(sizes: sizes, index: index);
                                }),
                              ))
                          : SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                  children: List.generate(
                                      TextController.getList(data["prices"])
                                          .length, (index) {
                                List sizes =
                                    TextController.getList(data["sizes"]);
                                return SizeWithPriceShip(
                                    productController: productController,
                                    sizes: sizes,
                                    index: index,
                                    data: data);
                              })),
                            ),
                    ],
                  ),
                )
              : Container(),
          data["hasExtra"] == true?    
          Container(child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 8),
              CustomeText(
            text: "Supplement",
            size: 18,
            weight: FontWeight.w500,
          ),
          SizedBox(
            height: 8,
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
                children: List.generate(
                    TextController.getList(data["extra"]).length,
                    (index) {
              
              productController.extra.add(false);
              return Padding(
                padding: const EdgeInsets.only(right: 16),
                child: GestureDetector(
                  onTap: () {
                    

                    if (productController.extra[index] == false) {
                      print("not selected");
                      productController.productPrice.value += int.parse(
                          TextController.getList(
                              data["extraPrices"])[index]);
                      productController.extra[index] = true;
                    } else if (productController.extra[index]== true) {
                      print("selected");
                      productController.productPrice.value -= int.parse(
                          TextController.getList(
                              data["extraPrices"])[index]);
                      productController.extra[index] = false;
                    }
                  },
                  child: Obx(() => Container(
                        height: 32,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                            color: productController.extra[index] == true
                                ? CustomColor.primary
                                : Colors.white,
                            border: Border.all(
                              color: CustomColor.primary,
                              width: 2,
                            )),
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 16),
                          child: CustomeText(
                              text: TextController.getList(
                                  data["extra"])[index],
                              size: 14,
                              color: productController.extra[index] == true
                                  ? Colors.white
                                  : CustomColor.cBlack,
                              weight: FontWeight.w500),
                        ),
                      )),
                ),
              );
            })),
          )
            ],
          ))
          : Container(),
          SizedBox(height:16),
          Row(
            mainAxisAlignment : MainAxisAlignment.spaceBetween,
            children: [
              CustomeText(text: "Livraison",size: 18,weight: FontWeight.w500,),
              TextButton(onPressed: (){}, child: CustomeText(text: "Modifier",size: 14,weight: FontWeight.w400,color: CustomColor.primary,))
            ],
          ),
          
          CustomeText(text: "600 DA",size: 18,weight: FontWeight.w500,color: CustomColor.primary,),
          CustomeText(text: "Yaldine Expresse 48h",size: 14,weight: FontWeight.w400,),
          CustomeText(text: "Distination ORAN",size: 14,weight: FontWeight.w400,),
          SizedBox(height:8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomeText(text: "Les avis",size: 18,weight: FontWeight.w500,),
              TextButton(onPressed: (){}, child: CustomeText(text: "voire plus",size: 14,color: CustomColor.primary,))  
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SmoothStarRating(
                      borderColor: CustomColor.primary,
                      color: CustomColor.primary,
                      rating: 5,
                      starCount: 5,
                      size: 16,
                      isReadOnly: true,
                    ),
              CustomeText(text: data["five"].toString(),size: 14,weight: FontWeight.w400,),  
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SmoothStarRating(
                      borderColor: CustomColor.primary,
                      color: CustomColor.primary,
                      rating: 4,
                      starCount: 5,
                      size: 16,
                      isReadOnly: true,
                    ),
              CustomeText(text: data["four"].toString(),size: 14,weight: FontWeight.w400,),  
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SmoothStarRating(
                      borderColor: CustomColor.primary,
                      color: CustomColor.primary,
                      rating: 3,
                      starCount: 5,
                      size: 16,
                      isReadOnly: true,
                    ),
              CustomeText(text: data["there"].toString(),size: 14,weight: FontWeight.w400,),  
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SmoothStarRating(
                      borderColor: CustomColor.primary,
                      color: CustomColor.primary,
                      rating: 2,
                      starCount: 5,
                      size: 16,
                      isReadOnly: true,
                    ),
              CustomeText(text: data["two"].toString(),size: 14,weight: FontWeight.w400,),  
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SmoothStarRating(
                      borderColor: CustomColor.primary,
                      color: CustomColor.primary,
                      rating: 1,
                      starCount: 5,
                      size: 16,
                      isReadOnly: true,
                    ),
              CustomeText(text: data["one"].toString(),size: 14,weight: FontWeight.w400,),  
            ],
          ),
          
          SizedBox(height: 56)
        ],
      ),
    );
  }
}
