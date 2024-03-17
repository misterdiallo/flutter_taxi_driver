import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:taxi_driver_app/admin/admin_routes.dart';
import 'package:taxi_driver_app/router.dart';

import 'pages/home.dart';

class AdminNavController extends GetxController {
  final GlobalKey<ScaffoldState> scaffoldKey;
  final RxString currentRoute = AdminRoutes.AdminHomeRoute.obs;

  AdminNavController({required this.scaffoldKey});

  void changePage(String route) {
    currentRoute.value = route;
  }

  Widget get currentPage =>
      AdminRoutes.getPage(currentRoute.value, scaffoldKey: scaffoldKey);
}
