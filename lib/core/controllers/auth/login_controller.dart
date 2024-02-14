import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:taxi_driver_app/core/controllers/controllers.dart';
import 'package:taxi_driver_app/core/models/user/user_type_model.dart';
import 'package:taxi_driver_app/core/services/auth/auth_service.dart';
import 'package:taxi_driver_app/router.dart';
import 'package:uuid/uuid.dart';

class LoginController extends GetxController {
  static LoginController instance = Get.find();
  final AuthService _authService = AuthService();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  final RxBool isLoading = false.obs;

  Future<void> login() async {
    final email = emailController.text;
    final password = passwordController.text;
    // Check if email and password are not empty
    if (email.isEmpty || password.isEmpty) {
      Get.snackbar(
        'Error',
        'Email and Password are required',
        backgroundColor: Colors.red[900],
        colorText: Colors.white,
      );
      return;
    }

    // Check email format
    if (!GetUtils.isEmail(email)) {
      Get.snackbar(
        'Error',
        'Invalid email format',
        backgroundColor: Colors.red[900],
        colorText: Colors.white,
      );
      return;
    }

    // Check password length
    if (password.length < 4) {
      Get.snackbar(
        'Error',
        'Password length limit',
        backgroundColor: Colors.red[900],
        colorText: Colors.white,
      );
      return;
    }
    isLoading.value = true;
    final result = await _authService.login(email, password);
    isLoading.value = false;
    if (result != null) {
      Get.snackbar(
        'Success',
        'Logged in successfully',
        backgroundColor: Colors.green[900],
        colorText: Colors.white,
      );
      authController.setUserId(result.userId);
      authController.setToken(const Uuid().v4());
      authController.setUserType(result.userType);
      authController.setIsCustomer(result.userType == UserType.customer);
      authController.setIsDriver(result.userType == UserType.driver);
      authController.setFullName(result.fullName);
      authController.setPhoneNumber(result.phoneNumber);
      authController.setEmail(result.email);
      authController.setIsLoggedInUser(true);
      Get.toNamed(InitialRoute);
    } else {
      Get.snackbar(
        'Error',
        'INCORRECT CREDENTIALS.',
        backgroundColor: Colors.red[900],
        colorText: Colors.white,
      );
    }
  }
}
