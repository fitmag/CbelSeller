import 'package:cbel/constant/colors.dart';
import 'package:cbel/controllers/bottomnavigation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RootPage extends StatefulWidget {
  const RootPage({
    Key? key,
  }) : super(key: key);

  @override
  _RootPageState createState() => _RootPageState();
}

class _RootPageState extends State<RootPage> {
  @override
  Widget build(BuildContext context) {
    BottomNavigationController controller = Get.find();
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
      currentIndex: controller.index.value,
      backgroundColor: Colors.white,
      elevation: 24,
      type: BottomNavigationBarType.fixed,
      selectedItemColor: CustomColor.primary,
      items: [
        BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
              color: CustomColor.cBlack,
            ),
            activeIcon: Icon(
              Icons.home,
              color: CustomColor.primary,
            ),
            label: "Home"),
        BottomNavigationBarItem(
            icon: Icon(Icons.search),
            activeIcon: Icon(
              Icons.search,
              color: CustomColor.primary,
            ),
            label: "Recherche"),
        BottomNavigationBarItem(
            icon: Icon(Icons.shopping_bag),
            activeIcon: Icon(
              Icons.shopping_bag,
              color: CustomColor.primary,
            ),
            label: "Painer"),
        BottomNavigationBarItem(
            icon: Icon(Icons.person),
            activeIcon: Icon(
              Icons.person,
              color: CustomColor.primary,
            ),
            label: "Compte"),
      ],
      onTap: (index) {
        setState(() {
          controller.index.value = index;
        });
      },
    ),
      body: controller.pages[controller.index.value],
    );
  }
}
