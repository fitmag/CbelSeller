import 'package:cbel/constant/colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomeText extends StatelessWidget {
  const CustomeText(
      {Key? key,
      required this.text,
      this.size = 16.0,
      this.weight = FontWeight.normal,
      this.isOverflow = true,
      this.color = CustomColor.cBlack})
      : super(key: key);
  final String text;
  final double size;
  final FontWeight weight;
  final bool isOverflow;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: GoogleFonts.poppins(
          fontSize: size,
          fontWeight: weight,
          color: color),
      overflow:
          isOverflow == true ? TextOverflow.ellipsis : TextOverflow.visible,
    );
  }
}
