
import 'package:cbel/constant/colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SectionTitle extends StatelessWidget {
  const SectionTitle({
    Key? key,
    required this.text
  }) : super(key: key);

  final text;

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: EdgeInsets.only(top: 16, bottom: 8),
        child: Text(
          text,
          style: GoogleFonts.poppins(color: CustomColor.cBlack, fontSize: 18),
        ),
      ),
    );
  }
}
