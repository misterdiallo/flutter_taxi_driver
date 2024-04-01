import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:taxi_driver_app/core/controllers/fisrt_run/first_run_controller.dart';
import 'package:taxi_driver_app/core/db/const.dart';
import 'package:taxi_driver_app/core/services/first_run/first_run_check_service.dart';
import 'package:taxi_driver_app/router.dart';

class SkipSplashMiddleWare extends GetMiddleware {
  final firstRunCheck = Get.find<FirstRunCheckService>();

  // priority this value the smaller the better
  @override
  int? priority = 0;

  SkipSplashMiddleWare({required this.priority});
  @override
  RouteSettings? redirect(String? route) {
    if (firstRunCheck.isFirstRun == true) {
      print("It is the FIRST TIME");
      firstRunCheck.updateFirstRunToNo(false);
      return const RouteSettings(name: SplashRoute);
    } else {
      print("not new, LIFE GOES ON");
      return null;
    }
  }
}
