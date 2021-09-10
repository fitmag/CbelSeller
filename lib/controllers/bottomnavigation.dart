import 'package:cbel/screens/homeSliver.dart';
import 'package:get/get.dart';
import 'package:cbel/screens/account.dart';
import 'package:cbel/screens/basket.dart';
import 'package:cbel/screens/home.dart';
import 'package:cbel/screens/search.dart';

class BottomNavigationController extends GetxController {
  var index = 0.obs;
  
  final List pages = [
    HomeSliver(),
    SearchPage(),
    BasketPage(),
    AcoountPage()
  ];
  
}
