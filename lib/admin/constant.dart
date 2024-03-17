import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:taxi_driver_app/ui/styles/colors.dart';

var primaryColorCode = Get.isDarkMode ? dprimaryColor : Colors.black12;
var cardBackgroundColor =
    Get.isDarkMode ? dbackgroundColor.withAlpha(200) : Colors.white;
