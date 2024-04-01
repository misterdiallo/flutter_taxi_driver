import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:taxi_driver_app/core/controllers/controllers.dart';
import 'package:taxi_driver_app/core/models/car_model.dart';
import 'package:taxi_driver_app/core/models/user/user_model.dart';
import 'package:taxi_driver_app/core/models/user/user_type_model.dart';

class DriverDataController extends GetxController {
  static DriverDataController instance = Get.find();
  final SupabaseClient _supabaseClient = Supabase.instance.client;

  RxList<CarModel> allCars = RxList<CarModel>();

  getAllCars() async {
    print("get All Cars");
    supabaseController.getAllJoined("cars", "users").then((resp) {
      if (resp == null) {
        allCars.value = [];
      } else {
        allCars.clear();
        allCars.value.addAll(CarModel.fromMapList(resp));
      }
    });
    return allCars;
  }

  Future<bool> newDriverWithCar(UserModel driver, CarModel car) async {
    try {
      return await _supabaseClient.auth.signUp(
        email: driver.email.toLowerCase(),
        password: "123456",
        data: {
          "email": driver.email.toLowerCase(),
          "password": "123456",
          "full_name": driver.full_name.toLowerCase(),
          "phone_number": driver.phone_number,
          "is_active": true,
          "user_type": UserType.driver.name.toLowerCase(),
          "address": "",
          "date_of_birth": driver.date_of_birth!.toIso8601String()
        },
      ).then((value) async {
        await supabaseController.insert('cars', {
          "license_number": car.license_number,
          "model": car.model,
          "plate_number": car.plate_number,
          "color": car.color,
          "user_id": value.user!.id,
        }).then((value) async {
          if (value) {
            await userController.getAllTypeUsersData(UserType.driver);
            return true;
          } else {
            return false;
          }
        });
        return true;
      });
    } on AuthException catch (e) {
      Get.snackbar(
        'Error',
        e.message,
        backgroundColor: Colors.red[900],
        colorText: Colors.white,
      );
      return false;
    } catch (e) {
      Get.snackbar(
        'Error',
        e.toString(),
        backgroundColor: Colors.red[900],
        colorText: Colors.white,
      );
      return false;
    }
  }
}
