
import 'package:cbel/constant/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FloatingBtn extends StatelessWidget {
  const FloatingBtn({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () =>
          Get.snackbar("share", "where you wante to share"),
      child: Container(
            width : 56 ,
            height: 56 ,
            decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.white,

            /// border: Colors.grey
            boxShadow: [
              BoxShadow(
                  blurRadius: 1,
                  color: Colors.grey,
                  offset: Offset.zero)
            ]),
        child: Icon(
          Icons.share,
          color: CustomColor.primary,
        ),
      ),
    );
  }
}
