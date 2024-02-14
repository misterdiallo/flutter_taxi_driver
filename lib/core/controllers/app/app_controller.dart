// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:taxi_driver_app/core/models/user/user_type_model.dart';
import 'package:taxi_driver_app/router.dart';
import 'package:taxi_driver_app/ui/styles/theme.dart';

class AppController extends GetxController {
  static AppController instance = Get.find();
  final appControl = GetStorage();

  bool get isDarkMode => appControl.read('isDarkMode') ?? false;
  ThemeData get theme => isDarkMode ? ThemeScheme.dark() : ThemeScheme.light();

  bool changeTheme(bool val) {
    appControl.write('isDarkMode', !isDarkMode);
    Get.changeTheme(theme);
    return isDarkMode;
  }

  void changeLang(String val) {
    appControl.write('lang', val);
  }

  String get lang =>
      appControl.read("lang") ?? const Locale('en').languageCode.toString();
  void reset() {
    appControl.erase();
  }
}
