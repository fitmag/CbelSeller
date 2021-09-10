import 'package:carousel_slider/carousel_slider.dart';
import 'package:cbel/constant/colors.dart';
import 'package:cbel/controllers/product.dart';
import 'package:cbel/controllers/text.dart';
import 'package:cbel/screens/something.dart';
import 'package:cbel/widget/floating_button.dart';
import 'package:cbel/widget/icon.dart';
import 'package:cbel/widget/product_details.dart';
import 'package:cbel/widget/text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class ProductPage extends StatefulWidget {
  ProductPage({Key? key, required this.productID}) : super(key: key);

  final String productID;

  @override
  _ProductPageState createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  final ProductController productController = Get.find();

  @override
  void dispose() {
    productController.carsoulIndex.value = 0;
    productController.priceIndex.value = 0;
    productController.productPrice.value = 0;
    productController.extra.value = [];
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    CarouselController carouselController = CarouselController();

    return Scaffold(
      body: FutureBuilder(
          future: FirebaseFirestore.instance
              .collection("Products")
              .doc(widget.productID)
              .get(),
          builder:
              (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
            if (snapshot.hasError ||
                (snapshot.hasData && !snapshot.data!.exists)) {
              Get.to(() => SomethingPage());
            }
            if (snapshot.connectionState == ConnectionState.done &&
                snapshot.hasData) {
              Map<String, dynamic> data = snapshot.data!.data();

              return Stack(
                children: [
                  Positioned(
                    child: CustomScrollView(
                      slivers: [
                        SliverAppBar(
                          pinned: true,
                          elevation: 8,
                          iconTheme: IconThemeData(size: 24),
                          leadingWidth: 62,
                          backgroundColor: Colors.white,
                          expandedHeight:
                              MediaQuery.of(context).size.width - 32,
                          leading: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 16),
                            child: CircleIcon(
                                icon: Icons.keyboard_arrow_left,
                                onTap: () => Get.back()),
                          ),
                          actions: [
                            Padding(
                              padding: const EdgeInsets.only(right: 16),
                              child: CircleIcon(
                                  icon: Icons.favorite_outline,
                                  onTap: () =>
                                      Get.snackbar("favori", "clicked")),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(right: 16),
                              child: CircleIcon(
                                  icon: Icons.share,
                                  onTap: () =>
                                      Get.snackbar("share", "Sharing")),
                            ),
                          ],
                          stretch: false,
                          flexibleSpace: FlexibleSpaceBar(
                            background: Stack(
                              children: [
                                Positioned(
                                    top: 0,
                                    child: data["images"] != null
                                        ? SizedBox(
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
                                            height: MediaQuery.of(context)
                                                .size
                                                .width,
                                            child: CarouselSlider(
                                              carouselController:
                                                  carouselController,
                                              options: CarouselOptions(
                                                  height: MediaQuery.of(context)
                                                      .size
                                                      .width,
                                                  aspectRatio: 1,
                                                  viewportFraction: 1,
                                                  onPageChanged: (int index,
                                                      CarouselPageChangedReason
                                                          reasen) {
                                                    print(
                                                        "Reasen : ${reasen.toString()}");
                                                    productController
                                                        .carsoulIndex
                                                        .value = index;
                                                  }),
                                              items: TextController.getList(
                                                      data["images"])
                                                  .map((value) {
                                                return Image.network(
                                                  value,
                                                  width: MediaQuery.of(context)
                                                      .size
                                                      .width,
                                                  height: MediaQuery.of(context)
                                                      .size
                                                      .width,
                                                  fit: BoxFit.cover,
                                                );
                                              }).toList(),
                                            ),
                                          )
                                        : Image.network(
                                            data["image"],
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
                                            height: MediaQuery.of(context)
                                                .size
                                                .width,
                                            fit: BoxFit.cover,
                                          )),
                                Positioned(
                                    bottom: 16,
                                    child: Container(
                                      alignment: Alignment.center,
                                      width: MediaQuery.of(context).size.width,
                                      child: data["images"] != null
                                          ? Obx(() => AnimatedSmoothIndicator(
                                                activeIndex: productController
                                                    .carsoulIndex.value,
                                                count: TextController.getList(
                                                        data["images"])
                                                    .length,
                                                effect: ExpandingDotsEffect(
                                                    activeDotColor:
                                                        CustomColor.primary,
                                                    dotColor: Colors.white,
                                                    dotHeight: 16,
                                                    dotWidth: 16),
                                              ))
                                          : Container(),
                                    )),
                              ],
                            ),
                          ),
                        ),
                        SliverToBoxAdapter(
                          child: ProductDetails(
                              data: data,
                              productController: productController,
                              carouselController: carouselController),
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                      bottom: 0,
                      child: Container(
                        alignment: Alignment.center,
                        width: MediaQuery.of(context).size.width,
                        height: 48,
                        decoration: BoxDecoration(
                            color: CustomColor.primary,
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(16),
                                topRight: Radius.circular(16))),
                        child: TextButton.icon(
                            onPressed: () => Get.snackbar("title", "message"),
                            icon: Icon(
                              Icons.shopping_bag_rounded,
                              color: Colors.white,
                              size: 24,
                            ),
                            label: CustomeText(
                              text: "Ajouter au Panier",
                              color: Colors.white,
                              size: 18,
                              weight: FontWeight.w500,
                            )),
                      ))
                ],
              );

              /// return Stack(
              ///   fit: StackFit.expand,
              ///   children: [
              ///     Positioned(
              ///         width: MediaQuery.of(context).size.width,
              ///         height: MediaQuery.of(context).size.width,
              ///         child: data["images"] != null
              ///             ? CarouselSlider(
              ///                 carouselController: carouselController,
              ///                 options: CarouselOptions(
              ///                     height: MediaQuery.of(context).size.width,
              ///                     aspectRatio: 1,
              ///                     viewportFraction: 1,
              ///                     onPageChanged: (int index,
              ///                         CarouselPageChangedReason reasen) {
              ///                       print("Reasen : ${reasen.toString()}");
              ///                       productController.carsoulIndex.value =
              ///                           index;
              ///                     }),
              ///                 items: TextController.getList(data["images"])
              ///                     .map((value) {
              ///                   return Image.network(
              ///                     value,
              ///                     width: MediaQuery.of(context).size.width,
              ///                     height: MediaQuery.of(context).size.width,
              ///                     fit: BoxFit.cover,
              ///                   );
              ///                 }).toList(),
              ///               )
              ///             : Image.network(
              ///                 data["image"],
              ///                 width: MediaQuery.of(context).size.width,
              ///                 height: MediaQuery.of(context).size.width,
              ///                 fit: BoxFit.cover,
              ///               )),
              ///     data["images"] != null
              ///         ? Positioned(
              ///             width: MediaQuery.of(context).size.width,
              ///             top: MediaQuery.of(context).size.width - 56,
              ///             child: Center(
              ///               child: Obx(() => AnimatedSmoothIndicator(
              ///                     activeIndex:
              ///                         productController.carsoulIndex.value,
              ///                     count: TextController.getList(data["images"])
              ///                         .length,
              ///                     effect: ExpandingDotsEffect(
              ///                         activeDotColor: CustomColor.primary,
              ///                         dotColor: Colors.white,
              ///                         dotHeight: 16,
              ///                         dotWidth: 16),
              ///                   )),
              ///             ))
              ///         : Container(),
              ///     Positioned(
              ///       top: 16,
              ///       width: MediaQuery.of(context).size.width,
              ///       height: 56,
              ///       child: SafeArea(
              ///         child: Padding(
              ///           padding: const EdgeInsets.symmetric(horizontal: 16),
              ///           child: Row(
              ///             mainAxisAlignment: MainAxisAlignment.spaceBetween,
              ///             children: [
              ///               CircleIcon(
              ///                 icon: Icons.keyboard_arrow_left,
              ///                 onTap: () => Get.back(),
              ///               ),
              ///               // TODO : add product to favorit
              ///               CircleIcon(
              ///                   icon: Icons.favorite_border,
              ///                   onTap: () => Get.snackbar(
              ///                       "FAvorite", "added to favotite"))
              ///             ],
              ///           ),
              ///         ),
              ///       ),
              ///     ),
              ///     Positioned(
              ///       width: MediaQuery.of(context).size.width,
              ///       top: MediaQuery.of(context).size.width - 16,
              ///       child: ProductDetails(data: data, productController: productController, carouselController: carouselController),
              ///     ),
              ///     Positioned(
              ///         right: 16,
              ///         top: MediaQuery.of(context).size.width - 44,
              ///         width: 56,
              ///         height: 56,
              ///         // TODO : share implementation
              ///         child: FloatingBtn())
              ///   ],
              /// );
            }
            return Center(child: CircularProgressIndicator());
          }),
    );
  }
}
