import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:taxi_driver_app/core/controllers/auth/auth_manager_controller.dart';
import 'package:taxi_driver_app/core/controllers/controllers.dart';
import 'package:taxi_driver_app/core/models/user/user_type_model.dart';
import 'package:taxi_driver_app/router.dart';

class AuthMiddleware extends GetMiddleware {
  final AuthController authController = Get.find<AuthController>();

  // priority this value the smaller the better
  @override
  int? priority = 0;

  AuthMiddleware({required this.priority});

  @override
  RouteSettings? redirect(String? route) {
    log("_______________________________________________");
    log("isLoggetUserNULL ? ${authController.getUserModel().toString()}");
    log("isTokenNULL ? ${authController.token}");
    log("isUserIdNULL ? ${authController.userId}");
    log("fullName ? ${authController.fullName}");
    log("PHone ? ${authController.phoneNumber}");
    log("isUserTypedNULL ? ${authController.userType}");
    log("_______________________________________________");
    if (authController.checkLoginAndRouteUser() != null) {
      print("Someone is Logged In");
      return RouteSettings(name: authController.checkLoginAndRouteUser());
    } else {
      print("No one is logged");
      return null;
    }
  }
}
