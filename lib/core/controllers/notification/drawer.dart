import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NotificationDrawerController extends GetxController {
  static NotificationDrawerController instance = Get.find();
  RxBool isDrawerOpen = false.obs;

  void toggleDrawer(GlobalKey<ScaffoldState> scaffoldKey) {
    isDrawerOpen.value
        ? scaffoldKey.currentState!.closeEndDrawer()
        : scaffoldKey.currentState!.openEndDrawer();
    isDrawerOpen.value = !isDrawerOpen.value;
  }
}
