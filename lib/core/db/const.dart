// Superbase db password: Abriko@linyi2024

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:taxi_driver_app/core/controllers/auth/auth_manager_controller.dart';
import 'package:taxi_driver_app/core/controllers/controllers.dart';
import 'package:taxi_driver_app/core/models/user/user_type_model.dart';

class ResendEmailService {
  static String api_key = "re_gvYtduWZ_Dx3KEiv7bDLw7tta945e9iN1";
}

class SuperBaseConf {
  static String url = 'https://svuniibwxdaaygkynwlv.supabase.co';
  static String anonKey =
      'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InN2dW5paWJ3eGRhYXlna3lud2x2Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3MTEwNjg2MjUsImV4cCI6MjAyNjY0NDYyNX0.vx_mP1CEdiPEFaKjYDxBzLiokyW2Vk-di810_DYFT2k';
  static String email = "fulluluyeco-5029@yopmail.com";
  static String password = "123456";
  static AuthController authController = Get.find<AuthController>();

  static Future<void> connectBackend() async {
    try {
      print("before creation");
      await Supabase.instance.client.auth.signUp(
        email: email.toLowerCase(),
        password: password,
        data: {
          "email": email.toLowerCase(),
          "password": password,
          "full_name": "Administrator",
          "phone_number": "0000000000",
          "is_active": true,
          "user_type": UserType.admin.name.toLowerCase(),
          "address": " ",
          "date_of_birth":
              DateTime.parse("2050-01-01").toUtc().toIso8601String(),
        },
      );
      await loginController.logout();
      print("after creation");
    } on AuthException catch (e) {
      Get.snackbar(
        'Backend Error',
        e.toString(),
        backgroundColor: Colors.red[900],
        colorText: Colors.white,
      );
    } catch (e) {
      Get.snackbar(
        'Backend Error',
        e.toString(),
        backgroundColor: Colors.red[900],
        colorText: Colors.white,
      );
    }
  }

  // Get SUPERBASE SESSION
  Session? getSession() {
    Supabase.instance.client.auth.currentSession;
    return null;
  }

  static Future<String> checkAdminExists(String email) async {
    return await authController
        .getUserFromDB(email, type: UserType.admin)
        .then((data) async {
      if (data == null) {
        await connectBackend();
        Get.snackbar(
          'Backend Error',
          "NOT CONNECTED TO THE BACKEND".toString(),
          backgroundColor: Colors.red[900],
          colorText: Colors.white,
        );
        return "NOT CONNECTED TO THE BACKEND";
      } else {
        return "BACKEND CONNECTED ALREADY \n";
      }
    });
    // return "ERROR CONNECTING THE BACKEND";
  }
}
