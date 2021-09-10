
import 'package:cbel/constant/colors.dart';
import 'package:cbel/widget/icon.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CSliverAppBar extends StatelessWidget {
  const CSliverAppBar({Key? key,}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    dynamic messageStream = FirebaseFirestore.instance
      .collection("Message")
      .where("isRead", isEqualTo: false)
      .snapshots();
    dynamic notificationStream = FirebaseFirestore.instance
      .collection("Notification")
      .where("isRead", isEqualTo: false)
      .snapshots();
    return SliverAppBar(
        floating : true,
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle : true,
        title: Text("CBEL", style: GoogleFonts.poppins(fontSize: 24,fontWeight: FontWeight.bold,color: CustomColor.primary)),
        leading: IconWithBadge(stream: messageStream, icon: "assets/icons/msg.svg" , press: () {}),
        leadingWidth: 24,
        actions: [
          IconWithBadge(stream: notificationStream, icon: "assets/icons/notif.svg" , press: () {}),
        ],
      );
  }
}