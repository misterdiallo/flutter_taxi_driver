import 'package:flutter/material.dart';
import 'package:taxi_driver_app/admin/pages/driver.dart';
import 'package:taxi_driver_app/admin/pages/places.dart';
import 'package:taxi_driver_app/admin/pages/rides.dart';
import 'package:taxi_driver_app/admin/pages/settings.dart';
import 'package:taxi_driver_app/admin/pages/users.dart';

import 'pages/home.dart';

class AdminRoutes {
  static const AdminHomeRoute = "/home";
  static const AdminDriverRoute = "/drivers";
  static const AdminUserRoute = "/users";
  static const AdminRideRoute = "/rides";
  static const AdminSettingRoute = "/settings";
  static const AdminPlaces = "/places";
  // static const Admin = "/";
  // static const Admin = "/";
  // static const Admin = "/";

  // Define a method to return the widget for a given route
  static Widget getPage(String route, {GlobalKey<ScaffoldState>? scaffoldKey}) {
    switch (route) {
      case AdminDriverRoute:
        return AdminDriverPage(scaffoldKey: scaffoldKey!);
      case AdminUserRoute:
        return AdminUserPage(scaffoldKey: scaffoldKey!);
      case AdminRideRoute:
        return AdminRidePage(scaffoldKey: scaffoldKey!);
      case AdminSettingRoute:
        return AdminSettingPage(scaffoldKey: scaffoldKey!);
      case AdminPlaces:
        return AdminPlacesPage(scaffoldKey: scaffoldKey!);
      default:
        return HomePage(scaffoldKey: scaffoldKey!);
    }
  }
}
