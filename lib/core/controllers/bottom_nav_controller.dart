import 'package:animated_notch_bottom_bar/animated_notch_bottom_bar/animated_notch_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:taxi_driver_app/core/services/ride_service.dart';
import 'package:taxi_driver_app/ui/screens/DRIVER/driver_tab.dart';
import 'package:taxi_driver_app/ui/screens/DRIVER/profile_tab.dart';

import '../models/ride_model.dart';

class BottomNavigationBarController extends GetxController {
  static BottomNavigationBarController instance = Get.find();
  var notchController = NotchBottomBarController(index: 0).obs;

  /// Controller to handle PageView and also handles initial page
  var pageController = PageController(initialPage: 0).obs;
  var selectedIndex = 0.obs;
  final List<BotNavPageModel> bottomBarPages = [
    BotNavPageModel(
      page: const RideDriverTab(),
      normalIcon: const Icon(
        FontAwesomeIcons.taxi,
        // color: theme.scaffoldBackgroundColor,
      ),
    ),
    BotNavPageModel(
      page: const ProfileTab(),
      normalIcon: const Icon(
        Icons.person,
        // color: theme.scaffoldBackgroundColor,
      ),
    ),
  ].obs;

  void updateSelectedIndex(int index) {
    selectedIndex.value = index;
  }
}

class BotNavPageModel {
  final Widget page;
  final Widget normalIcon;
  final Widget? selectedIcon;
  final String? title;
  BotNavPageModel({
    required this.page,
    required this.normalIcon,
    this.selectedIcon,
    this.title,
  });
}
