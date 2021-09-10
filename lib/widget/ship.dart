import 'package:carousel_slider/carousel_controller.dart';
import 'package:cbel/constant/colors.dart';
import 'package:cbel/controllers/product.dart';
import 'package:cbel/controllers/text.dart';
import 'package:cbel/widget/text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ColorShip extends StatelessWidget {
  const ColorShip(
      {Key? key,
      required this.text,
      required this.index,
      required this.controller})
      : super(key: key);
  final String text;
  final int index;
  final CarouselController controller;
  @override
  Widget build(BuildContext context) {
    ProductController productController = Get.find();
    return Obx(() => GestureDetector(
          onTap: () {
            controller.jumpToPage(index);
            productController.carsoulIndex.value = index;
          },
          child: Container(
              alignment: Alignment.center,
              height: 32,
              decoration: productController.carsoulIndex.value == index
                  ? BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      shape: BoxShape.rectangle,
                      color: CustomColor.primary,
                      border: Border.all(
                        color: CustomColor.primary,
                        width: 2,
                      ))
                  : BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      shape: BoxShape.rectangle,
                      color: Colors.white,
                      border: Border.all(
                        color: CustomColor.primary,
                        width: 2,
                      )),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: CustomeText(
                  text: text,
                  size: 14,
                  weight: FontWeight.w400,
                  color: productController.carsoulIndex.value != index
                      ? CustomColor.cBlack
                      : Colors.white,
                ),
              )),
        ));
  }
}

class SizeWithPriceShip extends StatelessWidget {
  const SizeWithPriceShip(
      {Key? key,
      required this.productController,
      required this.sizes,
      required this.index,
      required this.data})
      : super(key: key);

  final ProductController productController;
  final List sizes;
  final int index;
  final Map<String, dynamic> data;

  @override
  Widget build(BuildContext context) {
    return Obx(() => Padding(
          padding: const EdgeInsets.only(right: 16),
          child: GestureDetector(
            onTap: () {
              productController.priceIndex.value = index;
              productController.productPrice.value = int.parse(
                  TextController.getList(
                      data["prices"])[productController.priceIndex.value]);
              List.generate(productController.extra.length, (index) {
                if (productController.extra[index] == true) {
                  productController.extra[index] = false;
                  
                }
              });
              
            },
            child: Container(
              alignment: Alignment.center,
              height: 32,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: CustomColor.primary, width: 2),
                color: productController.priceIndex.value == index
                    ? CustomColor.primary
                    : Colors.white,
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: CustomeText(
                  text: sizes[index],
                  size: 14,
                  weight: FontWeight.w400,
                  color: productController.priceIndex.value == index
                      ? Colors.white
                      : CustomColor.cBlack,
                ),
              ),
            ),
          ),
        ));
  }
}

class SizeShip extends StatelessWidget {
  const SizeShip({
    Key? key,
    required this.sizes,
    required this.index,
  }) : super(key: key);

  final List sizes;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 16),
      child: Container(
        alignment: Alignment.center,
        height: 32,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: CustomColor.primary, width: 2)),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: CustomeText(
            text: sizes[index],
            size: 14,
            weight: FontWeight.w400,
          ),
        ),
      ),
    );
  }
}
